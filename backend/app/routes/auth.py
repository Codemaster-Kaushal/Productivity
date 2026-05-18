"""Auth routes for Google OAuth via Supabase."""

from datetime import datetime, timedelta, timezone

import sentry_sdk
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import get_settings
from app.database import get_db
from app.envelope import success_response
from app.models.user import UserProfile

router = APIRouter(prefix="/auth", tags=["Auth"])


class GoogleAuthRequest(BaseModel):
    code: str
    redirect_url: str = ""


@router.post("/google")
async def google_auth(
    request: GoogleAuthRequest,
    db: AsyncSession = Depends(get_db),
):
    """Exchange Google OAuth code for a Supabase session and store Google tokens."""
    try:
        settings = get_settings()

        from supabase._async.client import create_client

        supabase = await create_client(
            settings.supabase_url,
            settings.effective_supabase_key,
        )

        response = await supabase.auth.exchange_code_for_session(
            {"auth_code": request.code}
        )
        session = response.session
        user = response.user

        provider_token = getattr(session, "provider_token", None)
        provider_refresh_token = getattr(session, "provider_refresh_token", None)
        expires_in = getattr(session, "expires_in", None)

        if user and provider_token:
            result = await db.execute(
                select(UserProfile).where(UserProfile.id == user.id)
            )
            profile = result.scalar_one_or_none()
            if profile:
                profile.google_access_token = provider_token
                if provider_refresh_token:
                    profile.google_refresh_token = provider_refresh_token
                if expires_in:
                    profile.google_token_expires_at = (
                        datetime.now(timezone.utc) + timedelta(seconds=int(expires_in))
                    )
                await db.commit()

        return success_response(
            {
                "access_token": session.access_token,
                "refresh_token": session.refresh_token,
                "user": {
                    "id": str(user.id),
                    "email": user.email,
                },
            }
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=400, detail=str(e))
