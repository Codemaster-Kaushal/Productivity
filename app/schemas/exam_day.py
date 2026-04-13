"""Exam day schemas."""

from datetime import date
from pydantic import BaseModel


class ExamDayCreate(BaseModel):
    date: date


class ExamDayResponse(BaseModel):
    date: date

    model_config = {"from_attributes": True}
