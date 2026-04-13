"""Tests for semester goals and milestones routes."""

import pytest
from datetime import date
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_list_semester_goals_empty(client: AsyncClient, test_user):
    """GET /semester-goals should return empty list initially."""
    response = await client.get("/semester-goals")
    assert response.status_code == 200
    assert response.json()["data"] == []


@pytest.mark.asyncio
async def test_create_semester_goal(client: AsyncClient, test_user):
    """POST /semester-goals should create a semester goal."""
    response = await client.post(
        "/semester-goals",
        json={
            "subject": "DSA",
            "title": "Master Algorithms",
            "semester_label": "Spring 2026",
            "start_date": "2026-01-15",
            "end_date": "2026-05-15",
        },
    )
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"]["subject"] == "DSA"


@pytest.mark.asyncio
async def test_create_semester_goal_duplicate_subject(client: AsyncClient, test_user):
    """POST /semester-goals should reject duplicate subject."""
    goal_data = {
        "subject": "Physics",
        "title": "Ace Physics",
        "semester_label": "Spring 2026",
        "start_date": "2026-01-15",
        "end_date": "2026-05-15",
    }
    await client.post("/semester-goals", json=goal_data)

    response = await client.post("/semester-goals", json=goal_data)
    assert response.status_code == 400
