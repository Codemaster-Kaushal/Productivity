"""UserProfile model."""

import uuid
from datetime import date, datetime
from sqlalchemy import String, Integer, Date, DateTime, Uuid, text
from sqlalchemy.orm import Mapped, mapped_column

from app.models import Base


class UserProfile(Base):
    __tablename__ = "user_profiles"

    id: Mapped[uuid.UUID] = mapped_column(Uuid, primary_key=True)
    display_name: Mapped[str] = mapped_column(String, nullable=False)
    current_streak: Mapped[int] = mapped_column(Integer, default=0, server_default="0")
    longest_streak: Mapped[int] = mapped_column(Integer, default=0, server_default="0")
    last_active_date: Mapped[date | None] = mapped_column(Date, nullable=True)
    shield_count: Mapped[int] = mapped_column(Integer, default=0, server_default="0")
    total_xp: Mapped[int] = mapped_column(Integer, default=0, server_default="0")
    level: Mapped[str] = mapped_column(String, default="Freshman", server_default="Freshman")
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP")
    )
