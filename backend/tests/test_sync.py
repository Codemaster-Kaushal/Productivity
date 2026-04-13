"""Tests for sync routes."""

import uuid
import pytest
from datetime import datetime, timezone
from unittest.mock import patch, AsyncMock
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_sync_push(client: AsyncClient, test_user):
    """POST /sync/push should process operations."""
    with patch(
        "app.services.scoring.broadcast_score_update",
        new_callable=AsyncMock,
    ):
        operations = [
            {
                "operation_type": "ADD_TASK",
                "payload": {
                    "title": "Synced task",
                    "date": datetime.now(timezone.utc).date().isoformat(),
                },
                "idempotency_key": str(uuid.uuid4()),
                "created_at": datetime.now(timezone.utc).isoformat(),
            }
        ]

        response = await client.post(
            "/sync/push", json={"operations": operations}
        )
        assert response.status_code == 200
        data = response.json()
        assert data["success"] is True
        assert data["data"]["synced"] == 1


@pytest.mark.asyncio
async def test_sync_pull(client: AsyncClient, test_user):
    """GET /sync/pull should return operations after timestamp."""
    after = "2020-01-01T00:00:00Z"
    response = await client.get("/sync/pull", params={"after": after})
    assert response.status_code == 200
    assert response.json()["success"] is True
