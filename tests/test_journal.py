"""Tests for journal routes."""

import pytest
from unittest.mock import patch, AsyncMock
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_today_journal_empty(client: AsyncClient, test_user):
    """GET /journal/today should return prompts even with no entry."""
    with patch(
        "app.routes.journal.generate_journal_prompts",
        new_callable=AsyncMock,
        return_value=["Prompt 1", "Prompt 2", "Prompt 3"],
    ):
        response = await client.get("/journal/today")
        assert response.status_code == 200
        data = response.json()
        assert data["success"] is True


@pytest.mark.asyncio
async def test_create_journal(client: AsyncClient, test_user):
    """POST /journal/today should create today's journal entry."""
    with patch(
        "app.routes.journal.generate_journal_prompts",
        new_callable=AsyncMock,
        return_value=["Prompt 1", "Prompt 2", "Prompt 3"],
    ), patch(
        "app.services.scoring.broadcast_score_update",
        new_callable=AsyncMock,
    ):
        response = await client.post(
            "/journal/today",
            json={"content": "Today I studied really hard and made great progress on my goals."},
        )
        assert response.status_code == 200
        data = response.json()
        assert data["success"] is True
        assert "Today I studied" in data["data"]["content"]
