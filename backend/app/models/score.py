"""DailyScore and XpLog models."""

import uuid
from datetime import date
from sqlalchemy import String, Integer, Date, Boolean, ForeignKey, Uuid, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.models import Base


class DailyScore(Base):
    __tablename__ = "daily_scores"

    id: Mapped[uuid.UUID] = mapped_column(Uuid, primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid, ForeignKey("user_profiles.id"), nullable=False
    )
    date: Mapped[date] = mapped_column(Date, nullable=False)
    true_score: Mapped[int] = mapped_column(Integer, nullable=False)
    verdict: Mapped[str] = mapped_column(String, nullable=False)
    big3_points: Mapped[int | None] = mapped_column(Integer, nullable=True)
    pomodoro_points: Mapped[int | None] = mapped_column(Integer, nullable=True)
    task_points: Mapped[int | None] = mapped_column(Integer, nullable=True)
    journal_points: Mapped[int | None] = mapped_column(Integer, nullable=True)
    active_points: Mapped[int | None] = mapped_column(Integer, nullable=True)
    penalty_points: Mapped[int | None] = mapped_column(Integer, nullable=True)
    focus_badge_earned: Mapped[bool] = mapped_column(
        Boolean, default=False, server_default="0"
    )

    __table_args__ = (
        UniqueConstraint("user_id", "date", name="uq_daily_scores_user_date"),
    )


class XpLog(Base):
    __tablename__ = "xp_log"

    id: Mapped[uuid.UUID] = mapped_column(Uuid, primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid, ForeignKey("user_profiles.id"), nullable=False
    )
    date: Mapped[date] = mapped_column(Date, nullable=False)
    category: Mapped[str] = mapped_column(String, nullable=False)
    xp_earned: Mapped[int] = mapped_column(Integer, nullable=False)

    __table_args__ = (
        UniqueConstraint("user_id", "date", "category", name="uq_xp_log_user_date_category"),
    )
