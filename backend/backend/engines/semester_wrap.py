"""Semester Wrap Engine — pure-function, deterministic, no AI calls.

Every field is computed from the raw student data so that the output is
fully testable and reproducible.
"""

from __future__ import annotations

from statistics import mean

from backend.schemas.semester_wrap import SemesterWrapInput, SemesterWrapOutput


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _avg(scores: list[int]) -> int:
    """Return the rounded integer mean, or 0 for an empty list."""
    return round(mean(scores)) if scores else 0


def _top_subject(completions: dict[str, int]) -> str:
    """Subject with the most Big 3 completions."""
    return max(completions, key=completions.get)  # type: ignore[arg-type]


def _neglected_subject(completions: dict[str, int]) -> str:
    """Subject with the fewest Big 3 completions."""
    return min(completions, key=completions.get)  # type: ignore[arg-type]


def _milestone_summary(completed: int, total: int, goals: int) -> str:
    return (
        f"Completed {completed} of {total} milestones "
        f"across {goals} Semester Goal{'s' if goals != 1 else ''}."
    )


def _honest_observation(
    weekday_scores: list[int],
    weekend_scores: list[int],
) -> str:
    """Identify the biggest weekday-vs-weekend behavioral pattern."""
    wd_avg = _avg(weekday_scores)
    we_avg = _avg(weekend_scores)

    if not weekend_scores:
        return (
            f"You logged scores on {len(weekday_scores)} weekdays "
            "but recorded zero weekend sessions. "
            "Your semester was a Monday-to-Friday operation."
        )
    if not weekday_scores:
        return (
            f"You logged scores on {len(weekend_scores)} weekend days "
            "but recorded zero weekday sessions."
        )

    gap = abs(wd_avg - we_avg)

    if gap <= 5:
        return (
            f"Weekday average {wd_avg}, weekend average {we_avg} — "
            f"only a {gap}-point gap. Consistency was your real strength this semester."
        )
    if wd_avg > we_avg:
        return (
            f"Your weekend True Scores averaged {we_avg} — "
            f"{gap} points below your weekday average of {wd_avg}. "
            f"Consistency {len(weekday_scores)} days a week, not 7, "
            "was your actual pattern."
        )
    return (
        f"Your weekday True Scores averaged {wd_avg} — "
        f"{gap} points below your weekend average of {we_avg}. "
        "You peaked on days off but dipped during the regular week."
    )


def _shareable_headline(
    avg_score: int,
    streak: int,
    top_subj: str,
) -> str:
    """Build a punchy, first-person headline (≤ 12 words)."""
    return f"{avg_score} avg True Score. {streak}-day streak. {top_subj} finally cracked."


def _closing_line(total_focus_badges: int) -> str:
    if total_focus_badges == 0:
        return "Zero Focus Badges — next semester, the badge counter starts moving."
    if total_focus_badges < 10:
        return (
            f"{total_focus_badges} Focus Badge{'s' if total_focus_badges != 1 else ''} "
            "— a start, but the bar is set for next semester."
        )
    return (
        f"{total_focus_badges} Focus Badges in one semester means you showed up "
        "to do the real work more often than not."
    )


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def generate_semester_wrap(data: SemesterWrapInput) -> SemesterWrapOutput:
    """Produce a complete Semester Wrap from raw student data."""

    scores = [d.true_score for d in data.daily_scores]
    weekday_scores = [d.true_score for d in data.daily_scores if d.is_weekday]
    weekend_scores = [d.true_score for d in data.daily_scores if not d.is_weekday]

    avg_score = _avg(scores)
    top_subj = _top_subject(data.subject_completions)
    neglected_subj = _neglected_subject(data.subject_completions)

    return SemesterWrapOutput(
        shareable_headline=_shareable_headline(avg_score, data.best_streak, top_subj),
        semester_label=data.semester_label,
        average_true_score=avg_score,
        best_streak=data.best_streak,
        total_focus_badges=data.total_focus_badges,
        top_subject=top_subj,
        neglected_subject=neglected_subj,
        milestone_summary=_milestone_summary(
            data.milestones_completed,
            data.milestones_total,
            data.semester_goals_count,
        ),
        honest_observation=_honest_observation(weekday_scores, weekend_scores),
        closing_line=_closing_line(data.total_focus_badges),
    )
