"""Tests for scores routes."""

import pytest
from unittest.mock import patch, AsyncMock
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_today_score(client: AsyncClient, test_user):
    """GET /scores/today should compute and return today's score."""
    with patch(
        "app.services.scoring.broadcast_score_update",
        new_callable=AsyncMock,
    ):
        response = await client.get("/scores/today")
        assert response.status_code == 200
        data = response.json()
        assert data["success"] is True
        assert "true_score" in data["data"]
        assert "verdict" in data["data"]


@pytest.mark.asyncio
async def test_get_week_scores(client: AsyncClient, test_user):
    """GET /scores/week should return last 7 days."""
    response = await client.get("/scores/week")
    assert response.status_code == 200
    assert response.json()["success"] is True


@pytest.mark.asyncio
async def test_get_score_history(client: AsyncClient, test_user):
    """GET /scores/history should return paginated results."""
    response = await client.get("/scores/history?page=1&limit=5")
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert "scores" in data["data"]
    assert data["data"]["page"] == 1
