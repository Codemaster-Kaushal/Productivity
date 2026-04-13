"""Pomodoro session routes."""

import uuid
from datetime import date, datetime, timezone

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, and_, func
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.pomodoro import PomodoroSession
from app.models.goal import Goal
from app.schemas.pomodoro import PomodoroStart, PomodoroResponse
from app.services.scoring import calculate_true_score
from app.envelope import success_response

router = APIRouter(prefix="/pomodoro", tags=["Pomodoro"])


@router.post("/start")
async def start_pomodoro(
    body: PomodoroStart,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Start a new Pomodoro session. Uses idempotency_key to prevent duplicates."""
    try:
        # Check idempotency — if already exists, return the existing session
        existing = await db.execute(
            select(PomodoroSession).where(
                PomodoroSession.idempotency_key == body.idempotency_key
            )
        )
        existing_session = existing.scalar_one_or_none()
        if existing_session:
            return success_response(
                PomodoroResponse.model_validate(existing_session).model_dump()
            )

        session = PomodoroSession(
            user_id=user.id,
            linked_goal_id=body.linked_goal_id,
            duration_minutes=body.duration_minutes,
            started_at=datetime.now(timezone.utc),
            idempotency_key=body.idempotency_key,
        )
        db.add(session)
        await db.commit()
        await db.refresh(session)
        return success_response(
            PomodoroResponse.model_validate(session).model_dump()
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to start pomodoro session")


@router.post("/{session_id}/complete")
async def complete_pomodoro(
    session_id: uuid.UUID,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Complete a Pomodoro session. Auto-links to goal if within focus window."""
    try:
        result = await db.execute(
            select(PomodoroSession).where(
                and_(
                    PomodoroSession.id == session_id,
                    PomodoroSession.user_id == user.id,
                )
            )
        )
        session = result.scalar_one_or_none()

        if not session:
            raise HTTPException(status_code=404, detail="Pomodoro session not found")
        if session.completed_at:
            raise HTTPException(status_code=400, detail="Session already completed")

        now = datetime.now(timezone.utc)
        session.completed_at = now

        # Auto-link to a goal if within its focus window and not already linked
        if not session.linked_goal_id:
            current_time = now.time()
            goals_result = await db.execute(
                select(Goal).where(
                    and_(
                        Goal.user_id == user.id,
                        Goal.date == date.today(),
                        Goal.deleted_at.is_(None),
                        Goal.focus_window_start.isnot(None),
                        Goal.focus_window_end.isnot(None),
                    )
                )
            )
            goals = goals_result.scalars().all()
            for goal in goals:
                if goal.focus_window_start <= current_time <= goal.focus_window_end:
                    session.linked_goal_id = goal.id
                    break

        await db.commit()

        # Recalculate True Score
        session_date = session.started_at.date()
        await calculate_true_score(user.id, session_date, db)

        await db.refresh(session)
        return success_response(
            PomodoroResponse.model_validate(session).model_dump()
        )
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to complete pomodoro session")


@router.get("/today")
async def get_today_pomodoros(
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Get today's Pomodoro sessions."""
    try:
        today = date.today()
        result = await db.execute(
            select(PomodoroSession).where(
                and_(
                    PomodoroSession.user_id == user.id,
                    func.date(PomodoroSession.started_at) == today,
                )
            )
        )
        sessions = result.scalars().all()
        return success_response(
            [PomodoroResponse.model_validate(s).model_dump() for s in sessions]
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch pomodoro sessions")
