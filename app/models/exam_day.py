"""ExamDay model."""

import uuid
from datetime import date
from sqlalchemy import Date, ForeignKey, Uuid, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.models import Base


class ExamDay(Base):
    __tablename__ = "exam_days"

    id: Mapped[uuid.UUID] = mapped_column(Uuid, primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid, ForeignKey("user_profiles.id"), nullable=False
    )
    date: Mapped[date] = mapped_column(Date, nullable=False)

    __table_args__ = (
        UniqueConstraint("user_id", "date", name="uq_exam_days_user_date"),
    )
