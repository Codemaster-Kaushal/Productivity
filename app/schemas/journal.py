"""Journal schemas."""

import uuid
from datetime import date, datetime
from pydantic import BaseModel, field_validator


class JournalCreate(BaseModel):
    content: str

    @field_validator("content")
    @classmethod
    def content_not_empty(cls, v: str) -> str:
        if not v.strip():
            raise ValueError("Journal content cannot be empty")
        return v


class JournalResponse(BaseModel):
    id: uuid.UUID
    user_id: uuid.UUID
    date: date
    content: str
    ai_prompts: dict | None
    created_at: datetime

    model_config = {"from_attributes": True}
