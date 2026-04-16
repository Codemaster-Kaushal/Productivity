from datetime import datetime, timedelta, timezone

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_db
from app.dependencies import get_current_user
from app.models.user import UserProfile
from app.schemas.calendar import TaskCalendarSyncRequest
from app.services.google_service import GoogleService

router = APIRouter(tags=["Calendar"])


@router.get("/calendar/today")
async def get_today_events(
    current_user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    google_service = GoogleService()
    connected = (
        await google_service.get_valid_token(str(current_user.id), db)
    ) is not None
    events = await google_service.get_todays_events(str(current_user.id), db)
    return {"success": True, "data": events, "connected": connected, "error": None}


@router.get("/calendar/month")
async def get_month_events(
    month: str = Query(..., description="YYYY-MM"),
    current_user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    year, month_number = month.split("-")
    month_start = datetime(
        int(year),
        int(month_number),
        1,
        tzinfo=timezone.utc,
    )
    next_month = datetime(
        month_start.year + (1 if month_start.month == 12 else 0),
        1 if month_start.month == 12 else month_start.month + 1,
        1,
        tzinfo=timezone.utc,
    )

    google_service = GoogleService()
    connected = (
        await google_service.get_valid_token(str(current_user.id), db)
    ) is not None
    events = await google_service.get_events_between(
        str(current_user.id),
        month_start,
        next_month - timedelta(seconds=1),
        db,
    )
    return {"success": True, "data": events, "connected": connected, "error": None}


@router.get("/calendar/steps/today")
async def get_today_steps(
    current_user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    google_service = GoogleService()
    connected = (
        await google_service.get_valid_token(str(current_user.id), db)
    ) is not None
    steps = await google_service.get_todays_steps(str(current_user.id), db)
    return {"success": True, "data": steps, "connected": connected, "error": None}


@router.post("/calendar/tasks/sync")
async def sync_task_to_calendar(
    body: TaskCalendarSyncRequest,
    current_user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    google_service = GoogleService()
    event = await google_service.create_task_event(
        str(current_user.id),
        title=body.title,
        task_date=body.date,
        db=db,
        task_id=body.task_id,
        notes=body.notes,
    )
    return {
        "success": True,
        "data": event,
        "connected": event is not None,
        "error": None,
    }
