"""Productivity — FastAPI Application Entry Point."""

from contextlib import asynccontextmanager

import sentry_sdk
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.config import get_settings
from app.routes.auth import router as auth_router
from app.routes.user import router as user_router
from app.routes.goals import router as goals_router
from app.routes.tasks import router as tasks_router
from app.routes.pomodoro import router as pomodoro_router
from app.routes.journal import router as journal_router
from app.routes.scores import router as scores_router
from app.routes.semester import router as semester_router, milestone_router
from app.routes.streaks import router as streaks_router, exam_router
from app.routes.sync import router as sync_router


settings = get_settings()

# Sentry initialization
if settings.sentry_dsn:
    sentry_sdk.init(
        dsn=settings.sentry_dsn,
        traces_sample_rate=0.2,
        profiles_sample_rate=0.1,
    )


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application startup/shutdown lifecycle."""
    yield


app = FastAPI(
    title="Productivity API",
    description="Gamified study app backend — True Score, streaks, XP, and AI-powered journaling.",
    version="1.0.0",
    lifespan=lifespan,
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Register all routers
app.include_router(auth_router)
app.include_router(user_router)
app.include_router(goals_router)
app.include_router(tasks_router)
app.include_router(pomodoro_router)
app.include_router(journal_router)
app.include_router(scores_router)
app.include_router(semester_router)
app.include_router(milestone_router)
app.include_router(streaks_router)
app.include_router(exam_router)
app.include_router(sync_router)


@app.get("/")
async def root():
    return {"status": "ok", "app": "Productivity API", "version": "1.0.0"}


@app.get("/health")
async def health_check():
    return {"status": "healthy"}
