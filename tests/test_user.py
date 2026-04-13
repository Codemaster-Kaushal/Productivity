"""Tests for user profile routes."""

import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_profile(client: AsyncClient, test_user):
    """GET /user/profile should return the user's profile."""
    response = await client.get("/user/profile")
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"]["display_name"] == "Test Student"
    assert data["data"]["level"] == "Freshman"


@pytest.mark.asyncio
async def test_update_profile(client: AsyncClient, test_user):
    """PATCH /user/profile should update display name."""
    response = await client.patch(
        "/user/profile", json={"display_name": "Updated Name"}
    )
    assert response.status_code == 200
    data = response.json()
    assert data["success"] is True
    assert data["data"]["display_name"] == "Updated Name"
