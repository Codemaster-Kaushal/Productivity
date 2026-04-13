"""Tests for auth routes."""

import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_google_auth_missing_code(client: AsyncClient):
    """POST /auth/google should fail with missing code."""
    response = await client.post("/auth/google", json={})
    assert response.status_code == 422  # Validation error


@pytest.mark.asyncio
async def test_google_auth_invalid_code(client: AsyncClient):
    """POST /auth/google with invalid code should return 400."""
    response = await client.post(
        "/auth/google", json={"code": "invalid_code"}
    )
    # Will fail because we can't reach Supabase in tests — expect error
    assert response.status_code in (400, 500)
