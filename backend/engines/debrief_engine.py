"""
Sunday Debrief Engine — Pure-Logic Module

Analyzes a student's weekly behavioral data and produces a structured,
data-driven 6-field JSON debrief.  No framework dependency — this module
is called by the FastAPI route layer.
"""

from __future__ import annotations

from typing import Any, Dict, List


# ── Public API ────────────────────────────────────────────────────────────────


def generate_debrief(data: Dict[str, Any]) -> Dict[str, str]:
    """
    Accept a validated weekly payload (as a plain dict) and return the
    6-field debrief dict.
    """
    daily_scores: List[Dict[str, Any]] = data["daily_scores"]
    week_avg: int = data["week_average"]
    last_week_avg: int = data["last_week_average"]
    subject_breakdown: Dict[str, Dict[str, int]] = data["subject_breakdown"]

    best_day = _compute_best_day(daily_scores)
    score_trend = _compute_score_trend(week_avg, last_week_avg)
    subject_gap = _compute_subject_gap(subject_breakdown)
    pattern = _compute_pattern(daily_scores, subject_breakdown)
    suggestion = _compute_suggestion(daily_scores, subject_breakdown, subject_gap)
    highlight = _compute_highlight(daily_scores, subject_breakdown, data)

    return {
        "best_day": best_day,
        "score_trend": score_trend,
        "subject_gap": subject_gap,
        "pattern": pattern,
        "suggestion": suggestion,
        "highlight": highlight,
    }


# ── Field Computations ───────────────────────────────────────────────────────


def _compute_best_day(daily_scores: List[Dict[str, Any]]) -> str:
    """Return the day name with the highest true_score."""
    best = max(daily_scores, key=lambda d: d["true_score"])
    return best["day"]


def _compute_score_trend(week_avg: int, last_week_avg: int) -> str:
    """Format the week-over-week delta as a human-readable string."""
    delta = week_avg - last_week_avg
    if delta > 0:
        return f"up {delta} points from last week"
    elif delta < 0:
        return f"down {abs(delta)} points from last week"
    else:
        return "unchanged from last week"


def _compute_subject_gap(subject_breakdown: Dict[str, Dict[str, int]]) -> str:
    """Return the subject with the fewest big3_days."""
    if not subject_breakdown:
        return "none"
    return min(subject_breakdown, key=lambda s: subject_breakdown[s]["big3_days"])


def _compute_pattern(
    daily_scores: List[Dict[str, Any]],
    subject_breakdown: Dict[str, Dict[str, int]],
) -> str:
    """
    Surface a non-obvious behavioral pattern referencing ≥ 2 data points.

    Strategy priority:
    1. High-score days share a common subject tag  →  subject-performance link
    2. Score drops correlate with zero-tag days    →  empty-day effect
    3. Weekday vs weekend gap                     →  consistency pattern
    """

    # --- Strategy 1: subject tag dominance on top days ---
    sorted_days = sorted(daily_scores, key=lambda d: d["true_score"], reverse=True)
    top_days = sorted_days[: min(3, len(sorted_days))]

    # Count subject appearances across top days
    tag_counts: Dict[str, int] = {}
    for day in top_days:
        for tag in day.get("subject_tags", []):
            tag_counts[tag] = tag_counts.get(tag, 0) + 1

    if tag_counts:
        dominant_tag = max(tag_counts, key=lambda t: tag_counts[t])
        dominant_count = tag_counts[dominant_tag]
        top_day_names = [d["day"] for d in top_days if dominant_tag in d.get("subject_tags", [])]

        if dominant_count >= 2 and len(top_day_names) >= 2:
            days_str = " and ".join(top_day_names[:2])
            scores_str = " and ".join(
                str(d["true_score"]) for d in top_days if dominant_tag in d.get("subject_tags", [])
            )
            return (
                f"Your top-scoring days ({days_str}, scores {scores_str}) all included {dominant_tag} sessions. "
                f"{dominant_tag} appears to anchor your focus — days without it averaged lower."
            )

    # --- Strategy 2: empty-tag days correlate with low scores ---
    empty_days = [d for d in daily_scores if not d.get("subject_tags")]
    tagged_days = [d for d in daily_scores if d.get("subject_tags")]

    if empty_days and tagged_days:
        avg_empty = sum(d["true_score"] for d in empty_days) / len(empty_days)
        avg_tagged = sum(d["true_score"] for d in tagged_days) / len(tagged_days)

        if avg_tagged - avg_empty >= 15:
            empty_names = ", ".join(d["day"] for d in empty_days)
            return (
                f"Days with no subject tags ({empty_names}) averaged a score of {avg_empty:.0f}, "
                f"while tagged days averaged {avg_tagged:.0f}. "
                f"Having at least one planned subject seems to lift your score by ~{avg_tagged - avg_empty:.0f} points."
            )

    # --- Strategy 3: weekday vs weekend gap ---
    weekdays = [d for d in daily_scores if d["day"] in ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")]
    weekend = [d for d in daily_scores if d["day"] in ("Saturday", "Sunday")]

    if weekdays and weekend:
        avg_wd = sum(d["true_score"] for d in weekdays) / len(weekdays)
        avg_we = sum(d["true_score"] for d in weekend) / len(weekend)
        gap = abs(avg_wd - avg_we)

        if avg_wd > avg_we:
            return (
                f"Your weekday average ({avg_wd:.0f}) outpaced your weekend average ({avg_we:.0f}) by {gap:.0f} points. "
                f"Weekend scores dragged your weekly average down — structured weekend blocks could close this gap."
            )
        else:
            return (
                f"Your weekend average ({avg_we:.0f}) beat your weekday average ({avg_wd:.0f}) by {gap:.0f} points. "
                f"Weekdays may need more planned deep-work blocks to match your weekend rhythm."
            )

    # Fallback (shouldn't normally reach here)
    best = max(daily_scores, key=lambda d: d["true_score"])
    worst = min(daily_scores, key=lambda d: d["true_score"])
    return (
        f"Your scores ranged from {worst['true_score']} ({worst['day']}) to {best['true_score']} ({best['day']}). "
        f"That {best['true_score'] - worst['true_score']}-point spread suggests inconsistent daily structure."
    )


def _compute_suggestion(
    daily_scores: List[Dict[str, Any]],
    subject_breakdown: Dict[str, Dict[str, int]],
    subject_gap: str,
) -> str:
    """
    One specific, actionable change referencing a subject or time-of-day.
    """
    # Find high-score days that included the gap subject
    gap_days = [
        d for d in daily_scores
        if subject_gap in d.get("subject_tags", [])
    ]

    if gap_days:
        # The gap subject was attempted on some days — suggest replicating the best one
        best_gap_day = max(gap_days, key=lambda d: d["true_score"])
        return (
            f"Replicate your {best_gap_day['day']} setup for {subject_gap} — "
            f"that was your strongest {subject_gap} day (score {best_gap_day['true_score']}), "
            f"so schedule a second {subject_gap} block on the same day pattern next week."
        )

    # Gap subject never appeared — suggest adding it to the best day
    best = max(daily_scores, key=lambda d: d["true_score"])
    return (
        f"Add a {subject_gap} session to your {best['day']}s — your highest-scoring day (score {best['true_score']}) "
        f"has room for one more subject block."
    )


def _compute_highlight(
    daily_scores: List[Dict[str, Any]],
    subject_breakdown: Dict[str, Dict[str, int]],
    data: Dict[str, Any],
) -> str:
    """
    Identify the single best thing the student did this week.

    Priority:
    1. Multi-session focus block on a single subject in one day
    2. Longest active streak milestone
    3. Highest single-day score
    """

    # --- Priority 1: best single-subject day (most tag repetitions) ---
    best_focus_day = None
    best_focus_count = 0
    best_focus_subject = ""

    for day in daily_scores:
        tags = day.get("subject_tags", [])
        if not tags:
            continue
        # Count each tag
        tag_freq: Dict[str, int] = {}
        for t in tags:
            tag_freq[t] = tag_freq.get(t, 0) + 1
        for subj, count in tag_freq.items():
            if count > best_focus_count:
                best_focus_count = count
                best_focus_day = day
                best_focus_subject = subj

    if best_focus_day and best_focus_count >= 2:
        return (
            f"{best_focus_count}-session focus block on {best_focus_subject} {best_focus_day['day']} "
            f"(score {best_focus_day['true_score']}) was your strongest single-subject effort this week."
        )

    # --- Priority 2: streak milestone ---
    streak = data.get("current_streak", 0)
    if streak >= 7:
        return f"Maintaining a {streak}-day active streak shows real consistency — that's {streak // 7} full weeks without a break."

    # --- Priority 3: highest single-day score ---
    best = max(daily_scores, key=lambda d: d["true_score"])
    return f"Scoring {best['true_score']} on {best['day']} was your peak this week — a solid anchor day."
