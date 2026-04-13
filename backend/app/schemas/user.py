"""User schemas."""

import uuid
from datetime import date, datetime
from pydantic import BaseModel


class UserProfileResponse(BaseModel):
    id: uuid.UUID
    display_name: str
    current_streak: int
    longest_streak: int
    last_active_date: date | None
    shield_count: int
    total_xp: int
    level: str
    created_at: datetime

    model_config = {"from_attributes": True}


class UserProfileUpdate(BaseModel):
    display_name: str
