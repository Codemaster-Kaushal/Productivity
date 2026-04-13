"""Sync schemas."""

import uuid
from datetime import datetime
from pydantic import BaseModel


class SyncOperationIn(BaseModel):
    operation_type: str
    payload: dict
    idempotency_key: uuid.UUID
    created_at: datetime


class SyncPushRequest(BaseModel):
    operations: list[SyncOperationIn]


class SyncPullItem(BaseModel):
    operation_type: str
    payload: dict
    synced_at: datetime
