"""FastAPI router for the Sunday Debrief endpoint."""

from fastapi import APIRouter

from schemas.debrief_schemas import DebriefInput, DebriefOutput
from engines.debrief_engine import generate_debrief

router = APIRouter(prefix="/api", tags=["Debrief"])


@router.post("/debrief", response_model=DebriefOutput)
async def create_debrief(payload: DebriefInput) -> DebriefOutput:
    """
    Accept a week of behavioral data and return a structured 6-field debrief.

    Pure computation — no database round-trip.
    """
    result = generate_debrief(payload.model_dump())
    return DebriefOutput(**result)
