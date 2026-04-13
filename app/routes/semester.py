"""Semester goals and milestones routes."""

import uuid
from datetime import datetime, timezone

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, and_, func
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.semester import SemesterGoal, Milestone
from app.schemas.semester import (
    SemesterGoalCreate,
    SemesterGoalResponse,
    MilestoneResponse,
)
from app.services.scoring import award_xp
from app.envelope import success_response

router = APIRouter(prefix="/semester-goals", tags=["Semester Goals"])


@router.get("")
async def list_semester_goals(
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """List active semester goals with progress percentage."""
    try:
        result = await db.execute(
            select(SemesterGoal).where(
                and_(
                    SemesterGoal.user_id == user.id,
                    SemesterGoal.is_active == True,
                )
            )
        )
        goals = result.scalars().all()

        response = []
        for goal in goals:
            # Calculate progress
            total_result = await db.execute(
                select(func.count()).select_from(Milestone).where(
                    Milestone.semester_goal_id == goal.id
                )
            )
            total = total_result.scalar() or 0

            completed_result = await db.execute(
                select(func.count()).select_from(Milestone).where(
                    and_(
                        Milestone.semester_goal_id == goal.id,
                        Milestone.is_completed == True,
                    )
                )
            )
            completed = completed_result.scalar() or 0

            progress_pct = (completed / total * 100) if total > 0 else 0

            goal_data = SemesterGoalResponse.model_validate(goal).model_dump()
            goal_data["progress_pct"] = round(progress_pct, 1)
            goal_data["total_milestones"] = total
            goal_data["completed_milestones"] = completed
            response.append(goal_data)

        return success_response(response)
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch semester goals")


@router.post("")
async def create_semester_goal(
    body: SemesterGoalCreate,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Create a semester goal. Max 1 per subject."""
    try:
        # Check existing active goal for this subject
        existing = await db.execute(
            select(SemesterGoal).where(
                and_(
                    SemesterGoal.user_id == user.id,
                    SemesterGoal.subject == body.subject,
                    SemesterGoal.is_active == True,
                )
            )
        )
        if existing.scalar_one_or_none():
            raise HTTPException(
                status_code=400,
                detail=f"Active semester goal for subject '{body.subject}' already exists",
            )

        goal = SemesterGoal(
            user_id=user.id,
            subject=body.subject,
            title=body.title,
            semester_label=body.semester_label,
            start_date=body.start_date,
            end_date=body.end_date,
        )
        db.add(goal)
        await db.commit()
        await db.refresh(goal)
        return success_response(
            SemesterGoalResponse.model_validate(goal).model_dump()
        )
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to create semester goal")


# ───────── Milestones ─────────

milestone_router = APIRouter(prefix="/milestones", tags=["Milestones"])


@milestone_router.patch("/{milestone_id}/complete")
async def complete_milestone(
    milestone_id: uuid.UUID,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Complete a milestone and award XP."""
    try:
        result = await db.execute(
            select(Milestone).where(Milestone.id == milestone_id)
        )
        milestone = result.scalar_one_or_none()

        if not milestone:
            raise HTTPException(status_code=404, detail="Milestone not found")

        # Verify the milestone's semester goal belongs to the user
        goal_result = await db.execute(
            select(SemesterGoal).where(
                and_(
                    SemesterGoal.id == milestone.semester_goal_id,
                    SemesterGoal.user_id == user.id,
                )
            )
        )
        if not goal_result.scalar_one_or_none():
            raise HTTPException(status_code=403, detail="Not authorized")

        if milestone.is_completed:
            raise HTTPException(status_code=400, detail="Milestone already completed")

        milestone.is_completed = True
        milestone.completed_at = datetime.now(timezone.utc)

        # Award milestone XP
        from datetime import date as date_type
        await award_xp(user.id, date_type.today(), "milestone", 50, db)

        await db.commit()
        await db.refresh(milestone)
        return success_response(
            MilestoneResponse.model_validate(milestone).model_dump()
        )
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to complete milestone")
