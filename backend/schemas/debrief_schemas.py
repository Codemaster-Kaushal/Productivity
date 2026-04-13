"""Pydantic models for the Sunday Debrief Engine."""

from __future__ import annotations

from typing import Dict, List

from pydantic import BaseModel, Field


# ── Input Models ──────────────────────────────────────────────────────────────


class DailyScore(BaseModel):
    """A single day's score and associated subject tags."""

    date: str = Field(..., description="ISO date string, e.g. 2026-03-16")
    day: str = Field(..., description="Day name, e.g. Monday")
    true_score: int = Field(..., ge=0, le=100, description="True Score for the day (0-100)")
    subject_tags: List[str] = Field(default_factory=list, description="Subject tags linked to Big 3 tasks")


class SubjectStats(BaseModel):
    """Per-subject statistics for the week."""

    big3_days: int = Field(..., ge=0, description="Number of days this subject appeared in Big 3")
    pomodoro_sessions: int = Field(..., ge=0, description="Total pomodoro sessions for this subject")


class DebriefInput(BaseModel):
    """Full weekly payload sent to the debrief engine."""

    user_id: str
    week_start: str
    week_end: str
    daily_scores: List[DailyScore] = Field(..., min_length=1, max_length=7)
    week_average: int
    last_week_average: int
    subject_breakdown: Dict[str, SubjectStats]
    current_streak: int = Field(..., ge=0)
    focus_badges_earned: int = Field(..., ge=0)
    active_days: int = Field(..., ge=0, le=7)


# ── Output Model ──────────────────────────────────────────────────────────────


class DebriefOutput(BaseModel):
    """The 6-field JSON debrief contract."""

    best_day: str = Field(..., description="Day name with the highest True Score")
    score_trend: str = Field(..., description="Honest trend statement with numeric delta")
    subject_gap: str = Field(..., description="Subject with fewest Big 3 completions")
    pattern: str = Field(..., description="2-sentence behavioral observation grounded in data")
    suggestion: str = Field(..., description="1 specific actionable sentence")
    highlight: str = Field(..., description="1 sentence naming the best specific thing")
