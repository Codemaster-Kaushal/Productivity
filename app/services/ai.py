"""AI service — Anthropic Claude integration for journal prompts and weekly debrief."""

import anthropic
from app.config import get_settings


async def generate_journal_prompts(user_goals: list[str], user_name: str) -> list[str]:
    """Generate 3 reflective journal prompts using Claude based on user's goals."""
    settings = get_settings()
    client = anthropic.AsyncAnthropic(api_key=settings.anthropic_api_key)

    goals_text = "\n".join(f"- {g}" for g in user_goals) if user_goals else "No goals set today."

    message = await client.messages.create(
        model="claude-opus-4-6",
        max_tokens=500,
        messages=[
            {
                "role": "user",
                "content": (
                    f"You are a reflective journaling coach for a student named {user_name}. "
                    f"Their goals for today are:\n{goals_text}\n\n"
                    "Generate exactly 3 short, thoughtful journal prompts to help them reflect on their day. "
                    "Return ONLY a JSON array of 3 strings, no other text. Example: "
                    '["prompt1", "prompt2", "prompt3"]'
                ),
            }
        ],
    )

    import json
    try:
        prompts = json.loads(message.content[0].text)
        if isinstance(prompts, list) and len(prompts) == 3:
            return prompts
    except (json.JSONDecodeError, IndexError, KeyError):
        pass

    # Fallback prompts
    return [
        "What was the most meaningful thing you accomplished today?",
        "What challenged you today and how did you handle it?",
        "What are you grateful for right now?",
    ]


async def generate_sunday_debrief(
    user_name: str, week_scores: list[dict]
) -> str:
    """Generate a weekly debrief summary using Claude."""
    settings = get_settings()
    client = anthropic.AsyncAnthropic(api_key=settings.anthropic_api_key)

    scores_text = "\n".join(
        f"- {s['date']}: Score {s['true_score']}/100 ({s['verdict']})"
        for s in week_scores
    )

    message = await client.messages.create(
        model="claude-opus-4-6",
        max_tokens=800,
        messages=[
            {
                "role": "user",
                "content": (
                    f"You are a supportive academic coach for a student named {user_name}. "
                    f"Here are their daily productivity scores from this week:\n{scores_text}\n\n"
                    "Write a brief, encouraging weekly debrief (3-4 paragraphs) that:\n"
                    "1. Highlights their best day and what they likely did well\n"
                    "2. Identifies patterns or areas for improvement\n"
                    "3. Gives one specific, actionable tip for next week\n"
                    "Keep the tone warm, motivational, and student-friendly."
                ),
            }
        ],
    )

    return message.content[0].text
