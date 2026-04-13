"""Tests for pomodoro routes."""

import uuid
import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_start_pomodoro(client: AsyncClient, test_user):
    """POST /pomodoro/start should create a session."""
    idem_key = str(uuid.uuid4())
    response = await client.post(
        "/pomodoro/start",
        json={"idempotency_key": idem_key, "duration_minutes": 25},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"]["duration_minutes"] == 25


@pytest.mark.asyncio
async def test_start_pomodoro_idempotent(client: AsyncClient, test_user):
    """POST /pomodoro/start with same idempotency key should return existing."""
    idem_key = str(uuid.uuid4())

    resp1 = await client.post(
        "/pomodoro/start", json={"idempotency_key": idem_key}
    )
    resp2 = await client.post(
        "/pomodoro/start", json={"idempotency_key": idem_key}
    )

    assert resp1.json()["data"]["id"] == resp2.json()["data"]["id"]


@pytest.mark.asyncio
async def test_complete_pomodoro(client: AsyncClient, test_user):
    """POST /pomodoro/{id}/complete should mark session as completed."""
    idem_key = str(uuid.uuid4())
    start_resp = await client.post(
        "/pomodoro/start", json={"idempotency_key": idem_key}
    )
    session_id = start_resp.json()["data"]["id"]

    response = await client.post(f"/pomodoro/{session_id}/complete")
    assert response.status_code == 200
    assert response.json()["data"]["completed_at"] is not None


@pytest.mark.asyncio
async def test_get_today_pomodoros(client: AsyncClient, test_user):
    """GET /pomodoro/today should return today's sessions."""
    response = await client.get("/pomodoro/today")
    assert response.status_code == 200
    assert response.json()["success"] is True
