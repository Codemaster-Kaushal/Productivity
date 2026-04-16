import json

import httpx

from app.config import get_settings


async def generate_journal_prompts(user_goals: list[str], user_name: str) -> list[str]:
    goals_text = "\n".join(f"- {goal}" for goal in user_goals) if user_goals else "- No goals set today."
    response_text = await _call_openai(
        instructions=(
            "You are a reflective journaling coach. Return only a JSON array of exactly "
            "three concise prompts."
        ),
        input_text=(
            f"Student name: {user_name}\n"
            f"Today's goals:\n{goals_text}\n\n"
            "Generate three thoughtful prompts that help the student reflect honestly "
            "without sounding generic."
        ),
        max_output_tokens=220,
    )

    try:
        parsed = json.loads(response_text)
        if isinstance(parsed, list) and len(parsed) == 3:
            return [str(item) for item in parsed]
    except json.JSONDecodeError:
        pass

    return [
        "What mattered most in the work you finished today?",
        "Where did you lose momentum, and what triggered it?",
        "What is one small adjustment that would make tomorrow feel easier?",
    ]


async def generate_sunday_debrief(user_name: str, week_scores: list[dict]) -> str:
    scores_text = "\n".join(
        f"- {score['date']}: {score['true_score']}/100 ({score['verdict']})"
        for score in week_scores
    )

    return await _call_openai(
        instructions=(
            "You are a supportive academic coach. Write in a grounded, motivating tone "
            "with practical advice."
        ),
        input_text=(
            f"Student name: {user_name}\n"
            f"Weekly score summary:\n{scores_text}\n\n"
            "Write a short weekly debrief with strengths, patterns, and one clear next step."
        ),
        max_output_tokens=420,
    )


async def generate_coach_message(
    *,
    user_name: str,
    context: dict,
    user_message: str | None = None,
) -> str:
    fallback = _fallback_coach_message(context, user_message=user_message)
    settings = get_settings()
    if not settings.openai_api_key:
        return fallback

    context_json = json.dumps(context, ensure_ascii=True)
    default_message = "Give me today's motivation and one practical next move."
    input_text = (
        f"Student name: {user_name}\n"
        f"Live context: {context_json}\n"
        f"User message: {user_message or default_message}\n\n"
        "Respond like a personal coach who has access to the student's daily performance data. "
        "Be specific, warm, and concise. Keep it to one short paragraph plus one actionable next step."
    )

    try:
        response_text = await _call_openai(
            instructions=(
                "You are Celestial Coach, a disciplined but encouraging performance coach. "
                "Use the provided data directly. Do not invent metrics that are not in the context."
            ),
            input_text=input_text,
            max_output_tokens=240,
        )
        return response_text or fallback
    except Exception:
        return fallback


async def _call_openai(
    *,
    instructions: str,
    input_text: str,
    max_output_tokens: int,
) -> str:
    settings = get_settings()
    if not settings.openai_api_key:
        return ""

    async with httpx.AsyncClient(timeout=30.0) as client:
        response = await client.post(
            "https://api.openai.com/v1/chat/completions",
            headers={
                "Authorization": f"Bearer {settings.openai_api_key}",
                "Content-Type": "application/json",
            },
            json={
                "model": settings.openai_model,
                "messages": [
                    {"role": "system", "content": instructions},
                    {"role": "user", "content": input_text},
                ],
                "max_tokens": max_output_tokens,
            },
        )

    response.raise_for_status()
    payload = response.json()
    try:
        return payload["choices"][0]["message"]["content"].strip()
    except (KeyError, IndexError, TypeError):
        return ""


def _fallback_coach_message(context: dict, user_message: str | None = None) -> str:
    score = int(context.get("reflection_score", 0))
    completed_goals = int(context.get("completed_goals", 0))
    total_goals = int(context.get("total_goals", 0))
    steps_today = int(context.get("steps_today", 0))

    if user_message:
        return (
            f"You asked for guidance while sitting at a reflection score of {score}. "
            f"You have closed {completed_goals} of {total_goals} focus goals and logged "
            f"{steps_today} steps so far. Pick the single unfinished item with the biggest payoff, "
            "finish one clean block on it, and then ask again with what changed."
        )

    if score >= 80:
        return (
            f"Your reflection score is {score}, which means the structure of the day is working. "
            "Protect the momentum: finish one more small task, then stop on purpose instead of drifting."
        )

    if score >= 50:
        return (
            f"Your reflection score is {score}, so the day still has room to turn upward. "
            f"You already completed {completed_goals} of {total_goals} focus goals. "
            "Choose the easiest unfinished win and close it in the next 20 minutes."
        )

    return (
        f"Your reflection score is {score}, so this is the moment to simplify. "
        "Forget perfection. Do one focused session, complete one visible task, and let the day recover from there."
    )
