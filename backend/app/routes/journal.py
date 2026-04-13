"""Journal routes with AI prompt generation."""

from datetime import date

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, and_
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.journal import JournalEntry
from app.models.goal import Goal
from app.schemas.journal import JournalCreate, JournalResponse
from app.services.ai import generate_journal_prompts
from app.services.scoring import calculate_true_score
from app.envelope import success_response

router = APIRouter(prefix="/journal", tags=["Journal"])


@router.post("/today")
async def create_or_update_journal(
    body: JournalCreate,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Create or update today's journal entry."""
    try:
        today = date.today()

        # Check if entry already exists
        result = await db.execute(
            select(JournalEntry).where(
                and_(
                    JournalEntry.user_id == user.id,
                    JournalEntry.date == today,
                )
            )
        )
        entry = result.scalar_one_or_none()

        if entry:
            # Update existing
            entry.content = body.content
        else:
            # Generate AI prompts for the new entry
            goals_result = await db.execute(
                select(Goal.title).where(
                    and_(
                        Goal.user_id == user.id,
                        Goal.date == today,
                        Goal.deleted_at.is_(None),
                    )
                )
            )
            goal_titles = [row[0] for row in goals_result.all()]

            try:
                ai_prompts = await generate_journal_prompts(goal_titles, user.display_name)
            except Exception:
                ai_prompts = [
                    "What was the most meaningful thing you accomplished today?",
                    "What challenged you today and how did you handle it?",
                    "What are you grateful for right now?",
                ]

            entry = JournalEntry(
                user_id=user.id,
                date=today,
                content=body.content,
                ai_prompts={"prompts": ai_prompts},
            )
            db.add(entry)

        await db.commit()
        await db.refresh(entry)

        # Recalculate True Score
        await calculate_true_score(user.id, today, db)

        return success_response(JournalResponse.model_validate(entry).model_dump())
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to save journal entry")


@router.get("/today")
async def get_today_journal(
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Get today's journal entry and AI prompts."""
    try:
        today = date.today()
        result = await db.execute(
            select(JournalEntry).where(
                and_(
                    JournalEntry.user_id == user.id,
                    JournalEntry.date == today,
                )
            )
        )
        entry = result.scalar_one_or_none()

        if not entry:
            # Generate prompts even if no entry exists yet
            goals_result = await db.execute(
                select(Goal.title).where(
                    and_(
                        Goal.user_id == user.id,
                        Goal.date == today,
                        Goal.deleted_at.is_(None),
                    )
                )
            )
            goal_titles = [row[0] for row in goals_result.all()]

            try:
                ai_prompts = await generate_journal_prompts(goal_titles, user.display_name)
            except Exception:
                ai_prompts = [
                    "What was the most meaningful thing you accomplished today?",
                    "What challenged you today and how did you handle it?",
                    "What are you grateful for right now?",
                ]

            return success_response({
                "entry": None,
                "ai_prompts": {"prompts": ai_prompts},
            })

        return success_response(JournalResponse.model_validate(entry).model_dump())
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch journal entry")
