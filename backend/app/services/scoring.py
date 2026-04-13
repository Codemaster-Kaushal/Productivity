"""Scoring engine — True Score calculation, streak updates, XP awards."""

import uuid
from datetime import date, timedelta, datetime

from sqlalchemy import select, func, and_, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.user import UserProfile
from app.models.goal import Goal
from app.models.task import Task
from app.models.pomodoro import PomodoroSession
from app.models.journal import JournalEntry
from app.models.score import DailyScore, XpLog
from app.models.exam_day import ExamDay
from app.utils.levels import get_level_for_xp
from app.services.realtime import broadcast_score_update


# ───────── Verdict Mapping ─────────

def _get_verdict(score: int) -> str:
    if score >= 90:
        return "Legendary"
    elif score >= 75:
        return "Excellent"
    elif score >= 60:
        return "Good"
    elif score >= 40:
        return "Okay"
    elif score >= 20:
        return "Needs Work"
    else:
        return "Rough Day"


# ───────── XP Award Helper ─────────

async def award_xp(
    user_id: uuid.UUID,
    target_date: date,
    category: str,
    xp: int,
    db: AsyncSession,
) -> None:
    """Upsert XP into xp_log and update user_profiles.total_xp and level."""
    if xp <= 0:
        return

    # Check if entry exists
    existing = await db.execute(
        select(XpLog).where(
            and_(
                XpLog.user_id == user_id,
                XpLog.date == target_date,
                XpLog.category == category,
            )
        )
    )
    xp_entry = existing.scalar_one_or_none()

    if xp_entry:
        xp_entry.xp_earned = xp
    else:
        xp_entry = XpLog(
            user_id=user_id,
            date=target_date,
            category=category,
            xp_earned=xp,
        )
        db.add(xp_entry)

    await db.flush()

    # Update total_xp on profile
    result = await db.execute(
        select(UserProfile).where(UserProfile.id == user_id)
    )
    profile = result.scalar_one()

    # Sum all XP for this user
    xp_result = await db.execute(
        select(func.coalesce(func.sum(XpLog.xp_earned), 0)).where(
            XpLog.user_id == user_id
        )
    )
    total = xp_result.scalar()
    profile.total_xp = total
    profile.level = get_level_for_xp(total)


# ───────── Exam Day Check ─────────

async def check_exam_day(
    user_id: uuid.UUID, target_date: date, db: AsyncSession
) -> bool:
    result = await db.execute(
        select(ExamDay).where(
            and_(ExamDay.user_id == user_id, ExamDay.date == target_date)
        )
    )
    return result.scalar_one_or_none() is not None


# ───────── Streak Update ─────────

async def update_streak(
    user_id: uuid.UUID,
    target_date: date,
    threshold_met: bool,
    db: AsyncSession,
) -> None:
    """Update streak based on threshold, shields, and exam days."""
    result = await db.execute(
        select(UserProfile).where(UserProfile.id == user_id)
    )
    profile = result.scalar_one()

    is_exam_day = await check_exam_day(user_id, target_date, db)
    if is_exam_day:
        return  # neutral — do nothing

    yesterday = target_date - timedelta(days=1)
    yesterday_was_exam = await check_exam_day(user_id, yesterday, db)

    if threshold_met:
        if profile.last_active_date in (yesterday, target_date) or yesterday_was_exam:
            profile.current_streak += 1
        else:
            profile.current_streak = 1  # reset — gap detected
        profile.last_active_date = target_date
        profile.longest_streak = max(profile.longest_streak, profile.current_streak)

        # Award shields at milestone streaks
        if profile.current_streak == 7:
            profile.shield_count = min(profile.shield_count + 1, 3)
        elif profile.current_streak == 30:
            profile.shield_count = min(profile.shield_count + 2, 3)
    else:
        if profile.shield_count > 0:
            profile.shield_count -= 1  # burn a shield, streak survives
        else:
            profile.current_streak = 0  # no shields left — reset


# ───────── True Score Calculation ─────────

async def calculate_true_score(
    user_id: uuid.UUID, target_date: date, db: AsyncSession
) -> DailyScore:
    """Calculate and upsert the True Score for a user on a given date."""

    # 1. Fetch goals (non-deleted)
    goals_result = await db.execute(
        select(Goal).where(
            and_(
                Goal.user_id == user_id,
                Goal.date == target_date,
                Goal.deleted_at.is_(None),
            )
        )
    )
    goals = goals_result.scalars().all()

    completed_big3 = sum(1 for g in goals if g.is_completed)
    incomplete_big3 = len(goals) - completed_big3

    # 2. Fetch completed pomodoro sessions linked to goals
    linked_pomo_result = await db.execute(
        select(func.count()).select_from(PomodoroSession).where(
            and_(
                PomodoroSession.user_id == user_id,
                PomodoroSession.completed_at.isnot(None),
                PomodoroSession.linked_goal_id.isnot(None),
                func.date(PomodoroSession.started_at) == target_date,
            )
        )
    )
    linked_pomodoros = linked_pomo_result.scalar() or 0

    # 3. Fetch tasks (non-deleted)
    tasks_result = await db.execute(
        select(Task).where(
            and_(
                Task.user_id == user_id,
                Task.date == target_date,
                Task.deleted_at.is_(None),
            )
        )
    )
    tasks = tasks_result.scalars().all()
    completed_tasks = sum(1 for t in tasks if t.is_completed)
    total_tasks = len(tasks)

    # 4. Check journal entry
    journal_result = await db.execute(
        select(JournalEntry).where(
            and_(
                JournalEntry.user_id == user_id,
                JournalEntry.date == target_date,
            )
        )
    )
    journal = journal_result.scalar_one_or_none()

    # 5. Calculate points
    big3_points = completed_big3 * 30  # max 90
    pomodoro_points = min(linked_pomodoros * 10, 30)
    task_points = min(completed_tasks * 5, 25)
    journal_points = 10 if journal and len(journal.content) >= 20 else 0
    active_points = 0  # steps data comes from client — default 0 for now
    penalty_points = incomplete_big3 * 20

    raw = big3_points + pomodoro_points + task_points + journal_points + active_points - penalty_points
    true_score = max(0, min(100, raw))

    # 6. Verdict
    verdict = _get_verdict(true_score)

    # 7. Focus badge: any completed goal with >= 2 linked completed pomodoros
    focus_badge_earned = False
    for goal in goals:
        if goal.is_completed:
            pomo_count_result = await db.execute(
                select(func.count()).select_from(PomodoroSession).where(
                    and_(
                        PomodoroSession.linked_goal_id == goal.id,
                        PomodoroSession.completed_at.isnot(None),
                    )
                )
            )
            if (pomo_count_result.scalar() or 0) >= 2:
                focus_badge_earned = True
                break

    # 8. Upsert daily_scores (dialect-agnostic)
    existing_score = await db.execute(
        select(DailyScore).where(
            and_(DailyScore.user_id == user_id, DailyScore.date == target_date)
        )
    )
    score_entry = existing_score.scalar_one_or_none()

    if score_entry:
        score_entry.true_score = true_score
        score_entry.verdict = verdict
        score_entry.big3_points = big3_points
        score_entry.pomodoro_points = pomodoro_points
        score_entry.task_points = task_points
        score_entry.journal_points = journal_points
        score_entry.active_points = active_points
        score_entry.penalty_points = penalty_points
        score_entry.focus_badge_earned = focus_badge_earned
    else:
        score_entry = DailyScore(
            user_id=user_id,
            date=target_date,
            true_score=true_score,
            verdict=verdict,
            big3_points=big3_points,
            pomodoro_points=pomodoro_points,
            task_points=task_points,
            journal_points=journal_points,
            active_points=active_points,
            penalty_points=penalty_points,
            focus_badge_earned=focus_badge_earned,
        )
        db.add(score_entry)

    await db.flush()

    # 9. Update streak
    task_completion_rate = completed_tasks / total_tasks if total_tasks > 0 else 0
    threshold_met = completed_big3 >= 2 and task_completion_rate >= 0.5
    await update_streak(user_id, target_date, threshold_met, db)

    # 10. Award XP
    await award_xp(user_id, target_date, "big3", completed_big3 * 25, db)
    if focus_badge_earned:
        await award_xp(user_id, target_date, "focus_badge", 15, db)
    if journal_points > 0:
        await award_xp(user_id, target_date, "journal", 10, db)
    await award_xp(user_id, target_date, "task", completed_tasks * 5, db)

    await db.commit()

    # 11. Broadcast via Supabase Realtime (best effort)
    try:
        await broadcast_score_update(str(user_id), true_score, verdict)
    except Exception:
        pass  # non-critical — don't fail the request

    # 12. Return the DailyScore
    score_result = await db.execute(
        select(DailyScore).where(
            and_(DailyScore.user_id == user_id, DailyScore.date == target_date)
        )
    )
    return score_result.scalar_one()
