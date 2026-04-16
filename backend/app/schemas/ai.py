from pydantic import BaseModel


class CoachRequest(BaseModel):
    message: str | None = None
