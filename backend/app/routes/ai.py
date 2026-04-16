from datetime import date

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import and_, func, select
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.database import get_db
from app.dependencies import get_current_user
from app.models.goal import Goal
from app.models.journal import JournalEntry
from app.models.pomodoro import PomodoroSession
from app.models.task import Task
from app.models.user import UserProfile
from app.schemas.ai import CoachRequest
from app.services.ai import generate_coach_message
from app.services.google_service import GoogleService
from app.envelope import success_response

router = APIRouter(prefix="/ai", tags=["AI"])


@router.post("/coach")
async def coach_message(
    body: CoachRequest,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    try:
        today = date.today()

        goals_result = await db.execute(
            select(Goal).where(
                and_(
                    Goal.user_id == user.id,
                    Goal.date == today,
                    Goal.deleted_at.is_(None),
                )
            )
        )
        goals = goals_result.scalars().all()

        tasks_result = await db.execute(
            select(Task).where(
                and_(
                    Task.user_id == user.id,
                    Task.date == today,
                    Task.deleted_at.is_(None),
                )
            )
        )
        tasks = tasks_result.scalars().all()

        pomodoro_count_result = await db.execute(
            select(func.count()).select_from(PomodoroSession).where(
                and_(
                    PomodoroSession.user_id == user.id,
                    PomodoroSession.completed_at.is_not(None),
                    func.date(PomodoroSession.started_at) == today,
                )
            )
        )
        pomodoro_count = pomodoro_count_result.scalar() or 0

        focus_minutes_result = await db.execute(
            select(func.coalesce(func.sum(PomodoroSession.duration_minutes), 0)).where(
                and_(
                    PomodoroSession.user_id == user.id,
                    PomodoroSession.completed_at.is_not(None),
                    func.date(PomodoroSession.started_at) == today,
                )
            )
        )
        focus_minutes = focus_minutes_result.scalar() or 0

        journal_result = await db.execute(
            select(JournalEntry).where(
                and_(
                    JournalEntry.user_id == user.id,
                    JournalEntry.date == today,
                )
            )
        )
        journal_entry = journal_result.scalar_one_or_none()

        google_service = GoogleService()
        steps_today = await google_service.get_todays_steps(str(user.id), db)

        completed_goals = sum(1 for goal in goals if goal.is_completed)
        completed_tasks = sum(1 for task in tasks if task.is_completed)
        incomplete_goals = len(goals) - completed_goals
        journal_points = 10 if journal_entry and len(journal_entry.content) >= 20 else 0
        active_points = min((steps_today // 1000) * 10, 20)
        reflection_score = max(
            0,
            min(
                100,
                completed_goals * 30
                + min(pomodoro_count * 10, 30)
                + min(completed_tasks * 5, 25)
                + journal_points
                + active_points
                - incomplete_goals * 20,
            ),
        )

        context = {
            "reflection_score": reflection_score,
            "current_streak": user.current_streak,
            "completed_goals": completed_goals,
            "total_goals": len(goals),
            "completed_tasks": completed_tasks,
            "total_tasks": len(tasks),
            "focus_minutes": focus_minutes,
            "steps_today": steps_today,
            "journal_present": journal_entry is not None,
        }

        message = await generate_coach_message(
            user_name=user.display_name,
            context=context,
            user_message=body.message,
        )

        return success_response({"message": message, **context})
    except Exception as exc:
        sentry_sdk.capture_exception(exc)
        raise HTTPException(status_code=500, detail="Failed to generate coach insight")
