"""Pydantic models for the Semester Wrap Engine."""

from __future__ import annotations

from pydantic import BaseModel, Field


class DailyScore(BaseModel):
    """A single day's True Score record."""

    date: str = Field(..., description="ISO date string, e.g. '2026-05-14'")
    true_score: int = Field(..., ge=0, le=100)
    is_weekday: bool


class SemesterWrapInput(BaseModel):
    """Everything the engine needs to produce a Semester Wrap."""

    semester_label: str = Field(..., description="e.g. 'Spring 2026'")
    daily_scores: list[DailyScore] = Field(..., min_length=1)
    best_streak: int = Field(..., ge=0)
    total_focus_badges: int = Field(..., ge=0)
    subject_completions: dict[str, int] = Field(
        ..., description="Subject name -> Big 3 completion count"
    )
    milestones_completed: int = Field(..., ge=0)
    milestones_total: int = Field(..., ge=0)
    semester_goals_count: int = Field(..., ge=1)


class SemesterWrapOutput(BaseModel):
    """The shareable Semester Wrap card payload."""

    shareable_headline: str
    semester_label: str
    average_true_score: int
    best_streak: int
    total_focus_badges: int
    top_subject: str
    neglected_subject: str
    milestone_summary: str
    honest_observation: str
    closing_line: str
