from datetime import date
from pydantic import BaseModel


class TaskCalendarSyncRequest(BaseModel):
    title: str
    date: date
    task_id: str | None = None
    notes: str | None = None
