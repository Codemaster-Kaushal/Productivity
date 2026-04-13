"""Auth routes — Google OAuth via Supabase."""

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import sentry_sdk

from app.config import get_settings
from app.envelope import success_response, error_response

router = APIRouter(prefix="/auth", tags=["Auth"])


class GoogleAuthRequest(BaseModel):
    code: str
    redirect_url: str = ""


@router.post("/google")
async def google_auth(request: GoogleAuthRequest):
    """Exchange Google OAuth code for a Supabase session."""
    try:
        settings = get_settings()

        # Use supabase-py to exchange the code
        from supabase._async.client import create_client

        supabase = await create_client(settings.supabase_url, settings.supabase_key)

        # Exchange the authorization code for a session
        response = await supabase.auth.exchange_code_for_session(
            {"auth_code": request.code}
        )

        return success_response(
            {
                "access_token": response.session.access_token,
                "refresh_token": response.session.refresh_token,
                "user": {
                    "id": str(response.user.id),
                    "email": response.user.email,
                },
            }
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=400, detail=str(e))
