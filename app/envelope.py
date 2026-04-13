"""Standard API response envelope."""

from typing import Any, Generic, TypeVar
from pydantic import BaseModel

T = TypeVar("T")


class ApiResponse(BaseModel, Generic[T]):
    """Standard response wrapper: { success, data, error }."""
    success: bool
    data: T | None = None
    error: str | None = None


def success_response(data: Any = None) -> dict:
    """Return a successful envelope."""
    return {"success": True, "data": data, "error": None}


def error_response(error: str, status_code: int = 400) -> dict:
    """Return an error envelope (the caller should set the HTTP status)."""
    return {"success": False, "data": None, "error": error}
