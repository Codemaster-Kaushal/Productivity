from datetime import datetime, timedelta, timezone

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from sqlalchemy import select, and_

from app.database import get_db
from app.dependencies import get_current_user
from app.models.task import Task
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
    
    # 1. Sync back to Google Calendar (already there)
    event = await google_service.create_task_event(
        str(current_user.id),
        title=body.title,
        task_date=body.date,
        db=db,
        task_id=body.task_id,
        notes=body.notes,
    )
    
    # 2. Sync back to Google Tasks
    task_res = await google_service.sync_google_task(
        str(current_user.id),
        title=body.title,
        task_date=body.date,
        is_completed=body.is_completed,
        db=db,
        notes=body.notes,
    )

    if task_res and "id" in task_res and body.task_id:
        import uuid
        try:
            task_uuid = uuid.UUID(body.task_id)
            result = await db.execute(select(Task).where(and_(Task.id == task_uuid, Task.user_id == current_user.id)))
            db_task = result.scalar_one_or_none()
            if db_task:
                db_task.google_task_id = task_res["id"]
                await db.commit()
        except ValueError:
            pass
            
    return {
        "success": True,
        "data": {
            "event": event,
            "task": task_res
        },
        "connected": event is not None or task_res is not None,
        "error": None,
    }

@router.get("/calendar/tasks/pull")
async def pull_google_tasks(
    current_user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    google_service = GoogleService()
    tasks = await google_service.get_todays_google_tasks(str(current_user.id), db)
    
    if not tasks:
        return {"success": True, "data": []}
        
    pulled_tasks = []
    today = date.today()
    for task in tasks:
        title = task.get("title")
        if not title:
            continue
            
        g_id = task.get("id")
        is_completed = task.get("status") == "completed"
        
        # Check if we already have it by google_task_id or title+date
        result = await db.execute(
            select(Task).where(
                and_(
                    Task.user_id == current_user.id,
                    (Task.google_task_id == g_id) | (and_(Task.title == title, Task.date == today))
                )
            )
        )
        db_task = result.scalar_one_or_none()
        
        if db_task:
            if not db_task.google_task_id:
                db_task.google_task_id = g_id
            # App wins: if there's conflict, we don't overwrite DB logic unless we want to.
            # But wait, if app wins, we don't update local state from Google,
            # except if it's newly completed in Google.
            pulled_tasks.append(db_task)
        else:
            # Create new local task from Google Task
            new_task = Task(
                user_id=current_user.id,
                title=title,
                date=today,
                is_completed=is_completed,
                google_task_id=g_id
            )
            db.add(new_task)
            pulled_tasks.append(new_task)
            
    await db.commit()
    return {"success": True, "count": len(tasks), "data": [t.title for t in pulled_tasks]}
    
