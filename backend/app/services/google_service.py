from __future__ import annotations

from datetime import date, datetime, time, timedelta, timezone

import httpx
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import get_settings
from app.models.user import UserProfile


class GoogleService:
    CALENDAR_BASE = "https://www.googleapis.com/calendar/v3"
    FIT_BASE = "https://www.googleapis.com/fitness/v1/users/me"

    async def get_valid_token(self, user_id: str, db: AsyncSession) -> str | None:
        result = await db.execute(select(UserProfile).where(UserProfile.id == user_id))
        profile = result.scalar_one_or_none()
        if not profile or not profile.google_access_token:
            return None

        if profile.google_token_expires_at:
            expires = profile.google_token_expires_at
            if expires.tzinfo is None:
                expires = expires.replace(tzinfo=timezone.utc)
            else:
                expires = expires.astimezone(timezone.utc)
            if (expires - datetime.now(timezone.utc)).total_seconds() < 300:
                return await self._refresh_token(profile, db)

        return profile.google_access_token

    async def _refresh_token(
        self,
        profile: UserProfile,
        db: AsyncSession,
    ) -> str | None:
        if not profile.google_refresh_token:
            return None

        settings = get_settings()
        if not settings.google_client_id or not settings.google_client_secret:
            return None

        async with httpx.AsyncClient(timeout=15.0) as client:
            response = await client.post(
                "https://oauth2.googleapis.com/token",
                data={
                    "client_id": settings.google_client_id,
                    "client_secret": settings.google_client_secret,
                    "refresh_token": profile.google_refresh_token,
                    "grant_type": "refresh_token",
                },
            )

        if response.status_code != 200:
            return None

        data = response.json()
        expires_in = int(data.get("expires_in", 3600))
        profile.google_access_token = data["access_token"]
        profile.google_token_expires_at = datetime.now(timezone.utc) + timedelta(
            seconds=expires_in
        )
        await db.commit()
        return data["access_token"]

    async def get_todays_steps(self, user_id: str, db: AsyncSession) -> int:
        token = await self.get_valid_token(user_id, db)
        if not token:
            return 0

        now = datetime.now(timezone.utc)
        midnight = datetime.combine(now.date(), time.min, tzinfo=timezone.utc)

        async with httpx.AsyncClient(timeout=20.0) as client:
            response = await client.post(
                f"{self.FIT_BASE}/dataset:aggregate",
                headers={"Authorization": f"Bearer {token}"},
                json={
                    "aggregateBy": [{"dataTypeName": "com.google.step_count.delta"}],
                    "bucketByTime": {"durationMillis": 86400000},
                    "startTimeMillis": int(midnight.timestamp() * 1000),
                    "endTimeMillis": int(now.timestamp() * 1000),
                },
            )

        if response.status_code != 200:
            return 0

        buckets = response.json().get("bucket", [])
        total = 0
        for bucket in buckets:
            for dataset in bucket.get("dataset", []):
                for point in dataset.get("point", []):
                    for value in point.get("value", []):
                        total += value.get("intVal", 0)
        return total

    async def get_todays_events(self, user_id: str, db: AsyncSession) -> list[dict]:
        today = date.today()
        start = datetime.combine(today, time.min, tzinfo=timezone.utc)
        end = datetime.combine(today, time.max, tzinfo=timezone.utc)
        return await self.get_events_between(user_id, start, end, db)

    async def get_events_between(
        self,
        user_id: str,
        start: datetime,
        end: datetime,
        db: AsyncSession,
    ) -> list[dict]:
        token = await self.get_valid_token(user_id, db)
        if not token:
            return []

        async with httpx.AsyncClient(timeout=20.0) as client:
            response = await client.get(
                f"{self.CALENDAR_BASE}/calendars/primary/events",
                headers={"Authorization": f"Bearer {token}"},
                params={
                    "timeMin": start.isoformat().replace("+00:00", "Z"),
                    "timeMax": end.isoformat().replace("+00:00", "Z"),
                    "singleEvents": True,
                    "orderBy": "startTime",
                },
            )

        if response.status_code != 200:
            return []

        return response.json().get("items", [])

    async def create_task_event(
        self,
        user_id: str,
        title: str,
        task_date: date,
        db: AsyncSession,
        *,
        task_id: str | None = None,
        notes: str | None = None,
    ) -> dict | None:
        token = await self.get_valid_token(user_id, db)
        if not token:
            return None

        end_date = task_date + timedelta(days=1)
        payload = {
            "summary": title,
            "description": notes or "Synced from Celestial Productivity",
            "start": {"date": task_date.isoformat()},
            "end": {"date": end_date.isoformat()},
            "extendedProperties": {
                "private": {
                    "source": "celestial_productivity",
                    "task_id": task_id or "",
                }
            },
        }

        async with httpx.AsyncClient(timeout=20.0) as client:
            response = await client.post(
                f"{self.CALENDAR_BASE}/calendars/primary/events",
                headers={"Authorization": f"Bearer {token}"},
                json=payload,
            )

        if response.status_code not in (200, 201):
            return None

        return response.json()
