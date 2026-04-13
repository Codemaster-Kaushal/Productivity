"""Goal model."""

import uuid
from datetime import date, time, datetime
from sqlalchemy import String, Date, Time, Boolean, DateTime, ForeignKey, Uuid, text
from sqlalchemy.orm import Mapped, mapped_column

from app.models import Base


class Goal(Base):
    __tablename__ = "goals"

    id: Mapped[uuid.UUID] = mapped_column(Uuid, primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid, ForeignKey("user_profiles.id"), nullable=False
    )
    title: Mapped[str] = mapped_column(String, nullable=False)
    subject: Mapped[str] = mapped_column(String, nullable=False)
    date: Mapped[date] = mapped_column(Date, nullable=False)
    is_completed: Mapped[bool] = mapped_column(Boolean, default=False, server_default="0")
    semester_goal_id: Mapped[uuid.UUID | None] = mapped_column(
        Uuid, ForeignKey("semester_goals.id"), nullable=True
    )
    focus_window_start: Mapped[time | None] = mapped_column(Time, nullable=True)
    focus_window_end: Mapped[time | None] = mapped_column(Time, nullable=True)
    deleted_at: Mapped[datetime | None] = mapped_column(
        DateTime(timezone=True), nullable=True
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP")
    )
