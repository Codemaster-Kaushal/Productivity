"""Semester goal and milestone schemas."""

import uuid
from datetime import date, datetime
from pydantic import BaseModel


class SemesterGoalCreate(BaseModel):
    subject: str
    title: str
    semester_label: str
    start_date: date
    end_date: date


class MilestoneCreate(BaseModel):
    title: str


class SemesterGoalResponse(BaseModel):
    id: uuid.UUID
    user_id: uuid.UUID
    subject: str
    title: str
    semester_label: str
    start_date: date
    end_date: date
    is_active: bool
    created_at: datetime
    progress_pct: float = 0.0
    total_milestones: int = 0
    completed_milestones: int = 0

    model_config = {"from_attributes": True}


class MilestoneResponse(BaseModel):
    id: uuid.UUID
    semester_goal_id: uuid.UUID
    title: str
    is_completed: bool
    completed_at: datetime | None

    model_config = {"from_attributes": True}
