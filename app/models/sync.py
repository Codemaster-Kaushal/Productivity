"""SyncOperation model."""

import uuid
from datetime import datetime
from sqlalchemy import String, DateTime, ForeignKey, Uuid, JSON, text
from sqlalchemy.orm import Mapped, mapped_column

from app.models import Base


class SyncOperation(Base):
    __tablename__ = "sync_operations"

    id: Mapped[uuid.UUID] = mapped_column(Uuid, primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(
        Uuid, ForeignKey("user_profiles.id"), nullable=False
    )
    operation_type: Mapped[str] = mapped_column(String, nullable=False)
    payload: Mapped[dict] = mapped_column(JSON, nullable=False)
    idempotency_key: Mapped[uuid.UUID] = mapped_column(
        Uuid, unique=True, nullable=False
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=text("CURRENT_TIMESTAMP")
    )
    synced_at: Mapped[datetime | None] = mapped_column(
        DateTime(timezone=True), nullable=True
    )
