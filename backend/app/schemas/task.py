"""Task schemas."""

import uuid
from datetime import date, datetime
from pydantic import BaseModel


class TaskCreate(BaseModel):
    title: str
    date: date
    linked_goal_id: uuid.UUID | None = None


class TaskResponse(BaseModel):
    id: uuid.UUID
    user_id: uuid.UUID
    title: str
    date: date
    is_completed: bool
    linked_goal_id: uuid.UUID | None
    created_at: datetime

    model_config = {"from_attributes": True}
