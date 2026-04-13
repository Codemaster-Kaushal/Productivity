"""Tests for the Sunday Debrief Engine."""

import sys
import os

# Ensure the backend package is importable
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

import pytest
from engines.debrief_engine import generate_debrief


# ── Shared fixture ────────────────────────────────────────────────────────────

SAMPLE_INPUT = {
    "user_id": "test-uuid-001",
    "week_start": "2026-03-16",
    "week_end": "2026-03-22",
    "daily_scores": [
        {"date": "2026-03-16", "day": "Monday",    "true_score": 82, "subject_tags": ["DSA", "Physics"]},
        {"date": "2026-03-17", "day": "Tuesday",   "true_score": 45, "subject_tags": ["ML"]},
        {"date": "2026-03-18", "day": "Wednesday", "true_score": 91, "subject_tags": ["DSA", "DSA", "Physics"]},
        {"date": "2026-03-19", "day": "Thursday",  "true_score": 38, "subject_tags": ["Physics"]},
        {"date": "2026-03-20", "day": "Friday",    "true_score": 70, "subject_tags": ["DSA", "ML"]},
        {"date": "2026-03-21", "day": "Saturday",  "true_score": 20, "subject_tags": []},
        {"date": "2026-03-22", "day": "Sunday",    "true_score": 55, "subject_tags": ["Physics"]},
    ],
    "week_average": 57,
    "last_week_average": 63,
    "subject_breakdown": {
        "DSA":     {"big3_days": 4, "pomodoro_sessions": 8},
        "Physics": {"big3_days": 3, "pomodoro_sessions": 3},
        "ML":      {"big3_days": 2, "pomodoro_sessions": 2},
    },
    "current_streak": 14,
    "focus_badges_earned": 2,
    "active_days": 5,
}


@pytest.fixture
def debrief():
    return generate_debrief(SAMPLE_INPUT)


# ── Tests ─────────────────────────────────────────────────────────────────────


def test_best_day(debrief):
    """Wednesday had the highest score (91)."""
    assert debrief["best_day"] == "Wednesday"


def test_score_trend(debrief):
    """Week average 57 vs last week 63 → down 6 points."""
    assert "down 6 points" in debrief["score_trend"]


def test_subject_gap(debrief):
    """ML had the fewest big3_days (2)."""
    assert debrief["subject_gap"] == "ML"


def test_output_has_all_six_keys(debrief):
    """The debrief must contain exactly the 6 required keys, all non-empty."""
    required = {"best_day", "score_trend", "subject_gap", "pattern", "suggestion", "highlight"}
    assert set(debrief.keys()) == required
    for key in required:
        assert isinstance(debrief[key], str) and len(debrief[key]) > 0, f"{key} is empty"


def test_pattern_references_data(debrief):
    """Pattern must mention at least 2 concrete data points (numbers or day names)."""
    text = debrief["pattern"]
    # Check for at least 2 day names or numeric values
    day_names = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
    subject_names = {"DSA", "Physics", "ML"}
    references = [w for w in text.split() if w.strip("(),.-") in day_names | subject_names or w.strip("(),.-").isdigit()]
    assert len(references) >= 2, f"Pattern lacks data references: {text}"


def test_highlight_is_specific(debrief):
    """Highlight must reference a day name or subject."""
    text = debrief["highlight"]
    day_names = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
    subject_names = {"DSA", "Physics", "ML"}
    found = any(name in text for name in day_names | subject_names)
    assert found, f"Highlight is too generic: {text}"


def test_suggestion_references_subject(debrief):
    """Suggestion must reference a subject name."""
    text = debrief["suggestion"]
    subject_names = {"DSA", "Physics", "ML"}
    found = any(name in text for name in subject_names)
    assert found, f"Suggestion does not reference any subject: {text}"


def test_no_generic_phrases(debrief):
    """Debrief must never contain banned generic phrases."""
    banned = ["great job", "keep it up", "you're doing amazing", "try to sleep more", "stay hydrated"]
    full_text = " ".join(debrief.values()).lower()
    for phrase in banned:
        assert phrase not in full_text, f"Found banned phrase '{phrase}' in debrief"


# ── Edge case: single day input ──────────────────────────────────────────────

def test_single_day_input():
    """Engine should handle a payload with only 1 day."""
    single_day = {
        "user_id": "test-uuid-002",
        "week_start": "2026-03-16",
        "week_end": "2026-03-16",
        "daily_scores": [
            {"date": "2026-03-16", "day": "Monday", "true_score": 72, "subject_tags": ["DSA"]},
        ],
        "week_average": 72,
        "last_week_average": 72,
        "subject_breakdown": {"DSA": {"big3_days": 1, "pomodoro_sessions": 2}},
        "current_streak": 1,
        "focus_badges_earned": 0,
        "active_days": 1,
    }
    result = generate_debrief(single_day)
    assert result["best_day"] == "Monday"
    assert "unchanged" in result["score_trend"]
    assert len(result) == 6


# ── Edge case: all days have equal scores ────────────────────────────────────

def test_equal_scores():
    """When all days score the same, engine should still produce valid output."""
    flat_data = {
        "user_id": "test-uuid-003",
        "week_start": "2026-03-16",
        "week_end": "2026-03-22",
        "daily_scores": [
            {"date": f"2026-03-{16+i}", "day": day, "true_score": 50, "subject_tags": ["DSA"]}
            for i, day in enumerate(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"])
        ],
        "week_average": 50,
        "last_week_average": 50,
        "subject_breakdown": {"DSA": {"big3_days": 7, "pomodoro_sessions": 14}},
        "current_streak": 7,
        "focus_badges_earned": 1,
        "active_days": 7,
    }
    result = generate_debrief(flat_data)
    assert len(result) == 6
    for v in result.values():
        assert isinstance(v, str) and len(v) > 0
