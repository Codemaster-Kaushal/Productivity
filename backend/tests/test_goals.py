"""Tests for goals routes."""

import pytest
from datetime import date
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_today_goals_empty(client: AsyncClient, test_user):
    """GET /goals/today should return empty list when no goals."""
    response = await client.get("/goals/today")
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"] == []


@pytest.mark.asyncio
async def test_create_goal(client: AsyncClient, test_user):
    """POST /goals should create a new goal."""
    today = date.today().isoformat()
    response = await client.post(
        "/goals",
        json={"title": "Study DSA", "subject": "DSA", "date": today},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"]["title"] == "Study DSA"
    assert data["data"]["is_completed"] is False


@pytest.mark.asyncio
async def test_create_goal_max_3(client: AsyncClient, test_user):
    """POST /goals should enforce maximum of 3 goals per day."""
    today = date.today().isoformat()
    for i in range(3):
        await client.post(
            "/goals",
            json={"title": f"Goal {i+1}", "subject": "Math", "date": today},
        )

    # 4th goal should fail
    response = await client.post(
        "/goals",
        json={"title": "Goal 4", "subject": "Math", "date": today},
    )
    assert response.status_code == 400


@pytest.mark.asyncio
async def test_complete_goal(client: AsyncClient, test_user):
    """PATCH /goals/{id}/complete should mark goal as complete."""
    today = date.today().isoformat()
    create_resp = await client.post(
        "/goals",
        json={"title": "Study Physics", "subject": "Physics", "date": today},
    )
    goal_id = create_resp.json()["data"]["id"]

    response = await client.patch(f"/goals/{goal_id}/complete")
    assert response.status_code == 200
    assert response.json()["data"]["is_completed"] is True


@pytest.mark.asyncio
async def test_delete_goal(client: AsyncClient, test_user):
    """DELETE /goals/{id} should soft-delete the goal."""
    today = date.today().isoformat()
    create_resp = await client.post(
        "/goals",
        json={"title": "Delete me", "subject": "Test", "date": today},
    )
    goal_id = create_resp.json()["data"]["id"]

    response = await client.delete(f"/goals/{goal_id}")
    assert response.status_code == 200
    assert response.json()["data"]["deleted"] is True

    # Should no longer appear in today's goals
    get_resp = await client.get("/goals/today")
    goals = get_resp.json()["data"]
    assert all(g["id"] != goal_id for g in goals)
