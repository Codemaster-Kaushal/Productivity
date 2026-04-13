"""Streaks and exam days routes."""

import uuid
from datetime import date

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, and_, func
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.exam_day import ExamDay
from app.schemas.exam_day import ExamDayCreate, ExamDayResponse
from app.envelope import success_response

router = APIRouter(prefix="/streaks", tags=["Streaks"])
exam_router = APIRouter(prefix="/exam-days", tags=["Exam Days"])


@router.get("/status")
async def get_streak_status(
    user: UserProfile = Depends(get_current_user),
):
    """Get current streak, shields, and longest streak."""
    try:
        return success_response(
            {
                "current_streak": user.current_streak,
                "longest_streak": user.longest_streak,
                "shield_count": user.shield_count,
                "last_active_date": str(user.last_active_date) if user.last_active_date else None,
            }
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch streak status")


# ───────── Exam Days ─────────

@exam_router.post("")
async def create_exam_day(
    body: ExamDayCreate,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Mark a date as an exam day. Max 14 per semester."""
    try:
        # Count existing exam days
        count_result = await db.execute(
            select(func.count()).select_from(ExamDay).where(
                ExamDay.user_id == user.id
            )
        )
        current_count = count_result.scalar() or 0

        if current_count >= 14:
            raise HTTPException(
                status_code=400,
                detail="Maximum 14 exam days per semester reached",
            )

        # Check for duplicate
        existing = await db.execute(
            select(ExamDay).where(
                and_(
                    ExamDay.user_id == user.id,
                    ExamDay.date == body.date,
                )
            )
        )
        if existing.scalar_one_or_none():
            raise HTTPException(status_code=400, detail="Date already marked as exam day")

        exam_day = ExamDay(user_id=user.id, date=body.date)
        db.add(exam_day)
        await db.commit()
        return success_response({"date": str(body.date), "created": True})
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to create exam day")


@exam_router.delete("/{exam_date}")
async def delete_exam_day(
    exam_date: date,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Unmark a date as an exam day."""
    try:
        result = await db.execute(
            select(ExamDay).where(
                and_(
                    ExamDay.user_id == user.id,
                    ExamDay.date == exam_date,
                )
            )
        )
        exam_day = result.scalar_one_or_none()

        if not exam_day:
            raise HTTPException(status_code=404, detail="Exam day not found")

        await db.delete(exam_day)
        await db.commit()
        return success_response({"deleted": True})
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to delete exam day")
