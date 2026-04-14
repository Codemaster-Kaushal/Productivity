import os
import httpx
from datetime import datetime, timezone
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.user import UserProfile

class GoogleService:
    CALENDAR_BASE = "https://www.googleapis.com/calendar/v3"
    FIT_BASE = "https://www.googleapis.com/fitness/v1/users/me"

    async def get_valid_token(self, user_id: str, db: AsyncSession) -> str | None:
        result = await db.execute(
            select(UserProfile).where(UserProfile.id == user_id)
        )
        profile = result.scalar_one_or_none()
        if not profile or not profile.google_access_token:
            return None

        # Check if token is expired (refresh if within 5 minutes of expiry)
        if profile.google_token_expires_at:
            expires = profile.google_token_expires_at.replace(tzinfo=timezone.utc)
            if (expires - datetime.now(timezone.utc)).total_seconds() < 300:
                return await self._refresh_token(profile, db)

        return profile.google_access_token

    async def _refresh_token(self, profile: UserProfile, db: AsyncSession) -> str | None:
        if not profile.google_refresh_token:
            return None

        async with httpx.AsyncClient() as client:
            response = await client.post(
                "https://oauth2.googleapis.com/token",
                data={
                    "client_id": os.getenv("GOOGLE_CLIENT_ID"),
                    "client_secret": os.getenv("GOOGLE_CLIENT_SECRET"),
                    "refresh_token": profile.google_refresh_token,
                    "grant_type": "refresh_token",
                }
            )
            if response.status_code != 200:
                return None

            data = response.json()
            profile.google_access_token = data["access_token"]
            profile.google_token_expires_at = datetime.now(timezone.utc).replace(
                second=0
            ).isoformat()
            await db.commit()
            return data["access_token"]

    async def get_todays_steps(self, user_id: str, db: AsyncSession) -> int:
        token = await self.get_valid_token(user_id, db)
        if not token:
            return 0

        import time
        now_ms = int(time.time() * 1000)
        midnight_ms = now_ms - (now_ms % 86400000)

        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{self.FIT_BASE}/dataset:aggregate",
                headers={"Authorization": f"Bearer {token}"},
                json={
                    "aggregateBy": [{"dataTypeName": "com.google.step_count.delta"}],
                    "bucketByTime": {"durationMillis": 86400000},
                    "startTimeMillis": midnight_ms,
                    "endTimeMillis": now_ms,
                }
            )
            if response.status_code != 200:
                return 0

            buckets = response.json().get("bucket", [])
            total = 0
            for bucket in buckets:
                for dataset in bucket.get("dataset", []):
                    for point in dataset.get("point", []):
                        for val in point.get("value", []):
                            total += val.get("intVal", 0)
            return total

    async def get_todays_events(self, user_id: str, db: AsyncSession) -> list:
        token = await self.get_valid_token(user_id, db)
        if not token:
            return []

        from datetime import date
        today = date.today().isoformat()

        async with httpx.AsyncClient() as client:
            response = await client.get(
                f"{self.CALENDAR_BASE}/calendars/primary/events",
                headers={"Authorization": f"Bearer {token}"},
                params={
                    "timeMin": f"{today}T00:00:00Z",
                    "timeMax": f"{today}T23:59:59Z",
                    "singleEvents": True,
                    "orderBy": "startTime",
                }
            )
            if response.status_code != 200:
                return []

            return response.json().get("items", [])
