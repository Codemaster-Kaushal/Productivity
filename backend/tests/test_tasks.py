"""Tests for tasks routes."""

import pytest
from datetime import date
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_today_tasks_empty(client: AsyncClient, test_user):
    """GET /tasks/today should return empty list."""
    response = await client.get("/tasks/today")
    assert response.status_code == 200
    assert response.json()["data"] == []


@pytest.mark.asyncio
async def test_create_task(client: AsyncClient, test_user):
    """POST /tasks should create a new task."""
    today = date.today().isoformat()
    response = await client.post(
        "/tasks", json={"title": "Read chapter 5", "date": today}
    )
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"]["title"] == "Read chapter 5"


@pytest.mark.asyncio
async def test_complete_task(client: AsyncClient, test_user):
    """PATCH /tasks/{id}/complete should mark task as complete."""
    today = date.today().isoformat()
    create_resp = await client.post(
        "/tasks", json={"title": "Complete me", "date": today}
    )
    task_id = create_resp.json()["data"]["id"]

    response = await client.patch(f"/tasks/{task_id}/complete")
    assert response.status_code == 200
    assert response.json()["data"]["is_completed"] is True


@pytest.mark.asyncio
async def test_delete_task(client: AsyncClient, test_user):
    """DELETE /tasks/{id} should soft-delete."""
    today = date.today().isoformat()
    create_resp = await client.post(
        "/tasks", json={"title": "Delete me", "date": today}
    )
    task_id = create_resp.json()["data"]["id"]

    response = await client.delete(f"/tasks/{task_id}")
    assert response.status_code == 200
    assert response.json()["data"]["deleted"] is True
