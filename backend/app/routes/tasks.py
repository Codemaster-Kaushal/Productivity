"""Tasks routes."""

import uuid
from datetime import date, datetime, timezone

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, and_
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.task import Task
from app.schemas.task import TaskCreate, TaskResponse
from app.services.scoring import calculate_true_score
from app.envelope import success_response

router = APIRouter(prefix="/tasks", tags=["Tasks"])


@router.get("/today")
async def get_today_tasks(
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Get today's tasks."""
    try:
        today = date.today()
        result = await db.execute(
            select(Task).where(
                and_(
                    Task.user_id == user.id,
                    Task.date == today,
                    Task.deleted_at.is_(None),
                )
            )
        )
        tasks = result.scalars().all()
        return success_response(
            [TaskResponse.model_validate(t).model_dump() for t in tasks]
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch tasks")


@router.post("")
async def create_task(
    body: TaskCreate,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Create a new task."""
    try:
        task = Task(
            user_id=user.id,
            title=body.title,
            date=body.date,
            linked_goal_id=body.linked_goal_id,
        )
        db.add(task)
        await db.commit()
        await db.refresh(task)
        return success_response(TaskResponse.model_validate(task).model_dump())
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to create task")


@router.patch("/{task_id}/complete")
async def complete_task(
    task_id: uuid.UUID,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Mark a task as complete."""
    try:
        result = await db.execute(
            select(Task).where(
                and_(
                    Task.id == task_id,
                    Task.user_id == user.id,
                    Task.deleted_at.is_(None),
                )
            )
        )
        task = result.scalar_one_or_none()

        if not task:
            raise HTTPException(status_code=404, detail="Task not found")

        task.is_completed = True
        await db.commit()

        # Recalculate True Score
        await calculate_true_score(user.id, task.date, db)

        return success_response(TaskResponse.model_validate(task).model_dump())
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise e


@router.delete("/{task_id}")
async def delete_task(
    task_id: uuid.UUID,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Soft-delete a task."""
    try:
        result = await db.execute(
            select(Task).where(
                and_(
                    Task.id == task_id,
                    Task.user_id == user.id,
                    Task.deleted_at.is_(None),
                )
            )
        )
        task = result.scalar_one_or_none()

        if not task:
            raise HTTPException(status_code=404, detail="Task not found")

        task.deleted_at = datetime.now(timezone.utc)
        await db.commit()
        return success_response({"deleted": True})
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to delete task")
