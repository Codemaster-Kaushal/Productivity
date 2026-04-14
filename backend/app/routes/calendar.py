from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.services.google_service import GoogleService

router = APIRouter(tags=["Calendar"])

@router.get("/calendar/today")
async def get_today_events(
    current_user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    google_service = GoogleService()
    events = await google_service.get_todays_events(str(current_user.id), db)
    return {"success": True, "data": events, "error": None}
