"""Offline sync routes — operation-log sync."""

import uuid
from datetime import date, datetime, timezone

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import select, and_
from sqlalchemy.ext.asyncio import AsyncSession
import sentry_sdk

from app.dependencies import get_current_user
from app.database import get_db
from app.models.user import UserProfile
from app.models.sync import SyncOperation as SyncOperationModel
from app.models.goal import Goal
from app.models.task import Task
from app.models.pomodoro import PomodoroSession
from app.models.journal import JournalEntry
from app.schemas.sync import SyncPushRequest, SyncOperationIn
from app.services.scoring import calculate_true_score
from app.envelope import success_response

router = APIRouter(prefix="/sync", tags=["Sync"])


# ─── Operation Handlers ───

async def handle_complete_goal(payload: dict, user_id: uuid.UUID, db: AsyncSession):
    goal_id = uuid.UUID(payload["goal_id"])
    result = await db.execute(
        select(Goal).where(and_(Goal.id == goal_id, Goal.user_id == user_id))
    )
    goal = result.scalar_one_or_none()
    if goal:
        goal.is_completed = True


async def handle_add_task(payload: dict, user_id: uuid.UUID, db: AsyncSession):
    task = Task(
        user_id=user_id,
        title=payload["title"],
        date=date.fromisoformat(payload["date"]),
        linked_goal_id=uuid.UUID(payload["linked_goal_id"]) if payload.get("linked_goal_id") else None,
    )
    db.add(task)


async def handle_complete_task(payload: dict, user_id: uuid.UUID, db: AsyncSession):
    task_id = uuid.UUID(payload["task_id"])
    result = await db.execute(
        select(Task).where(and_(Task.id == task_id, Task.user_id == user_id))
    )
    task = result.scalar_one_or_none()
    if task:
        task.is_completed = True


async def handle_log_pomodoro(payload: dict, user_id: uuid.UUID, db: AsyncSession):
    # Check idempotency
    idem_key = uuid.UUID(payload["idempotency_key"])
    existing = await db.execute(
        select(PomodoroSession).where(PomodoroSession.idempotency_key == idem_key)
    )
    if existing.scalar_one_or_none():
        return  # Already exists

    session = PomodoroSession(
        user_id=user_id,
        linked_goal_id=uuid.UUID(payload["linked_goal_id"]) if payload.get("linked_goal_id") else None,
        duration_minutes=payload.get("duration_minutes", 25),
        started_at=datetime.fromisoformat(payload["started_at"]),
        completed_at=datetime.fromisoformat(payload["completed_at"]) if payload.get("completed_at") else None,
        idempotency_key=idem_key,
    )
    db.add(session)


async def handle_submit_journal(payload: dict, user_id: uuid.UUID, db: AsyncSession):
    entry_date = date.fromisoformat(payload["date"])
    result = await db.execute(
        select(JournalEntry).where(
            and_(JournalEntry.user_id == user_id, JournalEntry.date == entry_date)
        )
    )
    entry = result.scalar_one_or_none()
    if entry:
        entry.content = payload["content"]
    else:
        entry = JournalEntry(
            user_id=user_id,
            date=entry_date,
            content=payload["content"],
        )
        db.add(entry)


OPERATION_HANDLERS = {
    "COMPLETE_GOAL": handle_complete_goal,
    "ADD_TASK": handle_add_task,
    "COMPLETE_TASK": handle_complete_task,
    "LOG_POMODORO": handle_log_pomodoro,
    "SUBMIT_JOURNAL": handle_submit_journal,
}


async def mark_operation_synced(idempotency_key: uuid.UUID, db: AsyncSession):
    result = await db.execute(
        select(SyncOperationModel).where(
            SyncOperationModel.idempotency_key == idempotency_key
        )
    )
    op = result.scalar_one_or_none()
    if op:
        op.synced_at = datetime.now(timezone.utc)


# ─── Routes ───

@router.post("/push")
async def sync_push(
    body: SyncPushRequest,
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Receive batch of offline operations from client and replay in order."""
    try:
        operations = sorted(body.operations, key=lambda x: x.created_at)

        for op in operations:
            # Check idempotency key — if already processed, skip silently
            existing = await db.execute(
                select(SyncOperationModel).where(
                    SyncOperationModel.idempotency_key == op.idempotency_key
                )
            )
            if existing.scalar_one_or_none():
                continue  # already applied — idempotent

            # Store the operation
            sync_op = SyncOperationModel(
                user_id=user.id,
                operation_type=op.operation_type,
                payload=op.payload,
                idempotency_key=op.idempotency_key,
            )
            db.add(sync_op)

            # Execute the handler
            handler = OPERATION_HANDLERS.get(op.operation_type)
            if handler:
                await handler(op.payload, user.id, db)
                await mark_operation_synced(op.idempotency_key, db)

        await db.flush()

        # Recompute today's True Score
        await calculate_true_score(user.id, date.today(), db)

        return success_response(
            {"synced": len(operations), "status": "ok"}
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        await db.rollback()
        raise HTTPException(status_code=500, detail="Failed to process sync push")


@router.get("/pull")
async def sync_pull(
    after: datetime = Query(..., description="Return changes after this timestamp"),
    user: UserProfile = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """Return all synced operations since a given timestamp."""
    try:
        result = await db.execute(
            select(SyncOperationModel)
            .where(
                and_(
                    SyncOperationModel.user_id == user.id,
                    SyncOperationModel.synced_at.isnot(None),
                    SyncOperationModel.synced_at > after,
                )
            )
            .order_by(SyncOperationModel.synced_at.asc())
        )
        operations = result.scalars().all()

        return success_response(
            [
                {
                    "operation_type": op.operation_type,
                    "payload": op.payload,
                    "synced_at": op.synced_at.isoformat() if op.synced_at else None,
                }
                for op in operations
            ]
        )
    except Exception as e:
        sentry_sdk.capture_exception(e)
        raise HTTPException(status_code=500, detail="Failed to fetch sync data")
