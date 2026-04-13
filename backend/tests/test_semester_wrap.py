"""Unit tests for the Semester Wrap Engine."""

from __future__ import annotations

import pytest

from backend.engines.semester_wrap import generate_semester_wrap
from backend.schemas.semester_wrap import DailyScore, SemesterWrapInput


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------

def _make_input(**overrides) -> SemesterWrapInput:
    """Build a SemesterWrapInput with sensible defaults, overridable."""
    defaults = dict(
        semester_label="Spring 2026",
        daily_scores=[
            DailyScore(date="2026-01-06", true_score=80, is_weekday=True),
            DailyScore(date="2026-01-07", true_score=72, is_weekday=True),
            DailyScore(date="2026-01-08", true_score=65, is_weekday=True),
            DailyScore(date="2026-01-09", true_score=90, is_weekday=True),
            DailyScore(date="2026-01-10", true_score=78, is_weekday=True),
            DailyScore(date="2026-01-11", true_score=40, is_weekday=False),
            DailyScore(date="2026-01-12", true_score=35, is_weekday=False),
        ],
        best_streak=23,
        total_focus_badges=31,
        subject_completions={"DSA": 42, "ML": 12, "OS": 28},
        milestones_completed=4,
        milestones_total=5,
        semester_goals_count=3,
    )
    defaults.update(overrides)
    return SemesterWrapInput(**defaults)


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

class TestSemesterWrapOutput:

    def test_basic_output_has_all_keys(self):
        result = generate_semester_wrap(_make_input())
        payload = result.model_dump()
        expected_keys = {
            "shareable_headline",
            "semester_label",
            "average_true_score",
            "best_streak",
            "total_focus_badges",
            "top_subject",
            "neglected_subject",
            "milestone_summary",
            "honest_observation",
            "closing_line",
        }
        assert set(payload.keys()) == expected_keys

    def test_average_score_calculation(self):
        result = generate_semester_wrap(_make_input())
        # (80+72+65+90+78+40+35) / 7 = 460 / 7 ≈ 65.71 → 66
        assert result.average_true_score == 66

    def test_top_and_neglected_subject(self):
        result = generate_semester_wrap(_make_input())
        assert result.top_subject == "DSA"
        assert result.neglected_subject == "ML"

    def test_milestone_summary_format(self):
        result = generate_semester_wrap(_make_input())
        assert result.milestone_summary == (
            "Completed 4 of 5 milestones across 3 Semester Goals."
        )

    def test_milestone_summary_singular_goal(self):
        result = generate_semester_wrap(_make_input(semester_goals_count=1))
        assert "1 Semester Goal." in result.milestone_summary

    def test_honest_observation_references_numbers(self):
        result = generate_semester_wrap(_make_input())
        obs = result.honest_observation
        # weekday avg ≈ 77, weekend avg ≈ 38
        # The observation must contain at least two numbers
        import re
        numbers_found = re.findall(r"\d+", obs)
        assert len(numbers_found) >= 2, (
            f"honest_observation should reference specific numbers: {obs}"
        )

    def test_shareable_headline_under_12_words(self):
        result = generate_semester_wrap(_make_input())
        word_count = len(result.shareable_headline.split())
        assert word_count <= 12, (
            f"Headline has {word_count} words: '{result.shareable_headline}'"
        )

    def test_closing_line_zero_badges(self):
        result = generate_semester_wrap(_make_input(total_focus_badges=0))
        assert "Zero Focus Badges" in result.closing_line

    def test_closing_line_low_badges(self):
        result = generate_semester_wrap(_make_input(total_focus_badges=5))
        assert "5 Focus Badges" in result.closing_line

    def test_semester_label_passthrough(self):
        result = generate_semester_wrap(_make_input(semester_label="Fall 2025"))
        assert result.semester_label == "Fall 2025"

    def test_best_streak_passthrough(self):
        result = generate_semester_wrap(_make_input(best_streak=14))
        assert result.best_streak == 14

    def test_no_weekend_scores(self):
        """When student has zero weekend data, observation should note that."""
        scores = [
            DailyScore(date=f"2026-01-{d:02d}", true_score=70, is_weekday=True)
            for d in range(6, 11)
        ]
        result = generate_semester_wrap(_make_input(daily_scores=scores))
        assert "zero weekend" in result.honest_observation.lower()
