"""POST /api/semester-wrap route."""

from __future__ import annotations

import logging

from fastapi import APIRouter

from app.envelope import error_response, success_response
from backend.engines.semester_wrap import generate_semester_wrap
from backend.schemas.semester_wrap import SemesterWrapInput

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api", tags=["semester-wrap"])


@router.post("/semester-wrap")
async def semester_wrap(payload: SemesterWrapInput):
    """Generate a Semester Wrap summary card from student data."""
    try:
        result = generate_semester_wrap(payload)
        return success_response(result.model_dump())
    except Exception as exc:
        logger.exception("semester-wrap failed")
        return error_response(str(exc), status_code=500)
