"""User profile routes."""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.schemas.user import UserProfileResponse, UserProfileUpdate
from app.envelope import success_response, error_response

router = APIRouter(prefix="/user", tags=["User"])


@router.get("/profile")
async def get_profile(
    user: UserProfile = Depends(get_current_user),
):
    """Get the current user's profile with streak, XP, and level."""
    try:
        return success_response(UserProfileResponse.model_validate(user).model_dump())
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch profile")


@router.patch("/profile")
async def update_profile(
    body: UserProfileUpdate,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Update the user's display name."""
    try:
        # Re-fetch user within this session to avoid cross-session issues
        result = await db.execute(
            select(UserProfile).where(UserProfile.id == user.id)
        )
        profile = result.scalar_one_or_none()
        if not profile:
            raise HTTPException(status_code=404, detail="User profile not found")

        profile.display_name = body.display_name
        await db.commit()
        await db.refresh(profile)
        return success_response(UserProfileResponse.model_validate(profile).model_dump())
    except HTTPException:
        raise
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to update profile")
