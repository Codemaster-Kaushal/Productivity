"""Scores routes — True Score queries."""

from datetime import date, timedelta

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import select, and_, desc
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.score import DailyScore
from app.schemas.score import DailyScoreResponse
from app.services.scoring import calculate_true_score
from app.envelope import success_response

router = APIRouter(prefix="/scores", tags=["Scores"])


@router.get("/today")
async def get_today_score(
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Get today's True Score — compute if not yet calculated."""
    try:
        today = date.today()

        result = await db.execute(
            select(DailyScore).where(
                and_(
                    DailyScore.user_id == user.id,
                    DailyScore.date == today,
                )
            )
        )
        score = result.scalar_one_or_none()

        if not score:
            # Compute if null
            score = await calculate_true_score(user.id, today, db)

        return success_response(DailyScoreResponse.model_validate(score).model_dump())
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch today's score")


@router.get("/week")
async def get_week_scores(
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Get last 7 days of scores for chart display."""
    try:
        today = date.today()
        week_ago = today - timedelta(days=6)

        result = await db.execute(
            select(DailyScore)
            .where(
                and_(
                    DailyScore.user_id == user.id,
                    DailyScore.date >= week_ago,
                    DailyScore.date <= today,
                )
            )
            .order_by(DailyScore.date.asc())
        )
        scores = result.scalars().all()
        return success_response(
            [DailyScoreResponse.model_validate(s).model_dump() for s in scores]
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch week scores")


@router.get("/history")
async def get_score_history(
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100),
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Get paginated score history (limit 20 per page by default)."""
    try:
        offset = (page - 1) * limit

        result = await db.execute(
            select(DailyScore)
            .where(DailyScore.user_id == user.id)
            .order_by(desc(DailyScore.date))
            .limit(limit)
            .offset(offset)
        )
        scores = result.scalars().all()
        return success_response(
            {
                "page": page,
                "limit": limit,
                "scores": [
                    DailyScoreResponse.model_validate(s).model_dump() for s in scores
                ],
            }
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch score history")
