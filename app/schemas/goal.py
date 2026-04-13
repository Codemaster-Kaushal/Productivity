"""Goal schemas."""

import uuid
from datetime import date, time, datetime
from pydantic import BaseModel


class GoalCreate(BaseModel):
    title: str
    subject: str
    date: date
    semester_goal_id: uuid.UUID | None = None
    focus_window_start: time | None = None
    focus_window_end: time | None = None


class GoalResponse(BaseModel):
    id: uuid.UUID
    user_id: uuid.UUID
    title: str
    subject: str
    date: date
    is_completed: bool
    semester_goal_id: uuid.UUID | None
    focus_window_start: time | None
    focus_window_end: time | None
    created_at: datetime

    model_config = {"from_attributes": True}
