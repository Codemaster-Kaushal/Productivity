"""Tests for streaks and exam days routes."""

import pytest
from datetime import date, timedelta
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_streak_status(client: AsyncClient, test_user):
    """GET /streaks/status should return streak info."""
    response = await client.get("/streaks/status")
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"]["current_streak"] == 0
    assert data["data"]["shield_count"] == 0


@pytest.mark.asyncio
async def test_create_exam_day(client: AsyncClient, test_user):
    """POST /exam-days should mark a date as exam day."""
    exam_date = (date.today() + timedelta(days=7)).isoformat()
    response = await client.post("/exam-days", json={"date": exam_date})
    assert response.status_code == 200
    assert response.json()["data"]["created"] is True


@pytest.mark.asyncio
async def test_create_exam_day_duplicate(client: AsyncClient, test_user):
    """POST /exam-days should reject duplicate dates."""
    exam_date = (date.today() + timedelta(days=10)).isoformat()
    await client.post("/exam-days", json={"date": exam_date})

    response = await client.post("/exam-days", json={"date": exam_date})
    assert response.status_code == 400


@pytest.mark.asyncio
async def test_delete_exam_day(client: AsyncClient, test_user):
    """DELETE /exam-days/{date} should unmark the exam day."""
    exam_date = (date.today() + timedelta(days=14)).isoformat()
    await client.post("/exam-days", json={"date": exam_date})

    response = await client.delete(f"/exam-days/{exam_date}")
    assert response.status_code == 200
    assert response.json()["data"]["deleted"] is True
