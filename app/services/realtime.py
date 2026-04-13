"""Supabase Realtime broadcast helper."""

import httpx
from app.config import get_settings


async def broadcast_score_update(
    user_id: str, true_score: int, verdict: str
) -> None:
    """Broadcast a score update to the user's Supabase Realtime channel."""
    settings = get_settings()

    if not settings.supabase_url or not settings.supabase_service_key:
        return  # Skip if not configured

    url = f"{settings.supabase_url}/realtime/v1/api/broadcast"

    payload = {
        "channel": f"scores:{user_id}",
        "event": "score_update",
        "payload": {
            "user_id": user_id,
            "true_score": true_score,
            "verdict": verdict,
        },
    }

    headers = {
        "apikey": settings.supabase_service_key,
        "Authorization": f"Bearer {settings.supabase_service_key}",
        "Content-Type": "application/json",
    }

    async with httpx.AsyncClient() as client:
        await client.post(url, json=payload, headers=headers, timeout=5.0)
