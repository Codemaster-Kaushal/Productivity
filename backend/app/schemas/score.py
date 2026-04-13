"""Score schemas."""

import uuid
from datetime import date
from pydantic import BaseModel


class DailyScoreResponse(BaseModel):
    id: uuid.UUID
    user_id: uuid.UUID
    date: date
    true_score: int
    verdict: str
    big3_points: int | None
    pomodoro_points: int | None
    task_points: int | None
    journal_points: int | None
    active_points: int | None
    penalty_points: int | None
    focus_badge_earned: bool

    model_config = {"from_attributes": True}
