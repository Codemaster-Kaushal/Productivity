"""Pomodoro schemas."""

import uuid
from datetime import datetime
from pydantic import BaseModel


class PomodoroStart(BaseModel):
    linked_goal_id: uuid.UUID | None = None
    duration_minutes: int = 25
    idempotency_key: uuid.UUID


class PomodoroResponse(BaseModel):
    id: uuid.UUID
    user_id: uuid.UUID
    linked_goal_id: uuid.UUID | None
    duration_minutes: int
    started_at: datetime
    completed_at: datetime | None
    idempotency_key: uuid.UUID

    model_config = {"from_attributes": True}
