"""Goals routes — Big 3 daily goals."""

import uuid
from datetime import date, datetime, timezone

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, and_, func
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.goal import Goal
from app.schemas.goal import GoalCreate, GoalResponse
from app.services.scoring import calculate_true_score
from app.envelope import success_response

router = APIRouter(prefix="/goals", tags=["Goals"])


@router.get("/today")
async def get_today_goals(
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Get today's Big 3 goals."""
    try:
        today = date.today()
        result = await db.execute(
            select(Goal).where(
                and_(
                    Goal.user_id == user.id,
                    Goal.date == today,
                    Goal.deleted_at.is_(None),
                )
            )
        )
        goals = result.scalars().all()
        return success_response(
            [GoalResponse.model_validate(g).model_dump() for g in goals]
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch goals")


@router.post("")
async def create_goal(
    body: GoalCreate,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Create a new Big 3 goal. Max 3 per day per user."""
    try:
        # Enforce max 3 goals per day
        count_result = await db.execute(
            select(func.count()).select_from(Goal).where(
                and_(
                    Goal.user_id == user.id,
                    Goal.date == body.date,
                    Goal.deleted_at.is_(None),
                )
            )
        )
        current_count = count_result.scalar() or 0

        if current_count >= 3:
            raise HTTPException(
                status_code=400,
                detail="Maximum 3 goals per day reached",
            )

        goal = Goal(
            user_id=user.id,
            title=body.title,
            subject=body.subject,
            date=body.date,
            semester_goal_id=body.semester_goal_id,
            focus_window_start=body.focus_window_start,
            focus_window_end=body.focus_window_end,
        )
        db.add(goal)
        await db.commit()
        await db.refresh(goal)
        return success_response(GoalResponse.model_validate(goal).model_dump())
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to create goal")


@router.patch("/{goal_id}/complete")
async def complete_goal(
    goal_id: uuid.UUID,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Mark a goal as complete. Triggers XP + score recalculation."""
    try:
        result = await db.execute(
            select(Goal).where(
                and_(
                    Goal.id == goal_id,
                    Goal.user_id == user.id,
                    Goal.deleted_at.is_(None),
                )
            )
        )
        goal = result.scalar_one_or_none()

        if not goal:
            raise HTTPException(status_code=404, detail="Goal not found")

        goal.is_completed = True
        await db.commit()

        # Recalculate True Score
        score = await calculate_true_score(user.id, goal.date, db)

        return success_response(GoalResponse.model_validate(goal).model_dump())
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to complete goal")


@router.delete("/{goal_id}")
async def delete_goal(
    goal_id: uuid.UUID,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Soft-delete a goal (sets deleted_at, never hard deletes)."""
    try:
        result = await db.execute(
            select(Goal).where(
                and_(
                    Goal.id == goal_id,
                    Goal.user_id == user.id,
                    Goal.deleted_at.is_(None),
                )
            )
        )
        goal = result.scalar_one_or_none()

        if not goal:
            raise HTTPException(status_code=404, detail="Goal not found")

        goal.deleted_at = datetime.now(timezone.utc)
        await db.commit()
        return success_response({"deleted": True})
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to delete goal")
