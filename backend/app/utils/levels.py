"""XP to Level mapping and calculation."""

# Level thresholds: (min_xp, level_name)
LEVEL_THRESHOLDS = [
    (0, "Freshman"),
    (500, "Sophomore"),
    (2000, "Junior"),
    (5000, "Senior"),
    (10000, "Scholar"),
    (25000, "Legend"),
]


def get_level_for_xp(total_xp: int) -> str:
    """Return the level name for a given XP total."""
    level = "Freshman"
    for threshold, name in LEVEL_THRESHOLDS:
        if total_xp >= threshold:
            level = name
        else:
            break
    return level


def get_next_level_info(total_xp: int) -> dict:
    """Return info about the next level milestone."""
    current_level = get_level_for_xp(total_xp)
    for i, (threshold, name) in enumerate(LEVEL_THRESHOLDS):
        if name == current_level and i + 1 < len(LEVEL_THRESHOLDS):
            next_threshold, next_name = LEVEL_THRESHOLDS[i + 1]
            return {
                "current_level": current_level,
                "next_level": next_name,
                "xp_needed": next_threshold - total_xp,
                "progress_pct": round(
                    (total_xp - threshold) / (next_threshold - threshold) * 100, 1
                ),
            }
    return {
        "current_level": current_level,
        "next_level": None,
        "xp_needed": 0,
        "progress_pct": 100.0,
    }
