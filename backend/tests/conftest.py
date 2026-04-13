"""Shared test fixtures — async client, test DB, mock user."""

import uuid
import pytest
import pytest_asyncio
from datetime import datetime, timezone
from unittest.mock import AsyncMock, patch

from httpx import AsyncClient, ASGITransport
from sqlalchemy import event
from sqlalchemy.ext.asyncio import (
    create_async_engine,
    async_sessionmaker,
    AsyncSession,
)

from app.models import Base
from app.models.user import UserProfile
# Import all models so they register with Base.metadata
from app.models.goal import Goal  # noqa: F401
from app.models.task import Task  # noqa: F401
from app.models.pomodoro import PomodoroSession  # noqa: F401
from app.models.journal import JournalEntry  # noqa: F401
from app.models.score import DailyScore, XpLog  # noqa: F401
from app.models.semester import SemesterGoal, Milestone  # noqa: F401
from app.models.exam_day import ExamDay  # noqa: F401
from app.models.sync import SyncOperation  # noqa: F401

from app.main import app
from app.database import get_db
from app.dependencies import get_current_user

# Test database — in-memory SQLite with aiosqlite
TEST_DATABASE_URL = "sqlite+aiosqlite:///:memory:"

test_engine = create_async_engine(TEST_DATABASE_URL, echo=False)
test_session_factory = async_sessionmaker(
    test_engine, class_=AsyncSession, expire_on_commit=False
)

# Fixed test user ID
TEST_USER_ID = uuid.UUID("12345678-1234-1234-1234-123456789abc")


# Patch SQLAlchemy UUID type to work with SQLite (stores as string)
from sqlalchemy.dialects.postgresql import UUID as PG_UUID
from sqlalchemy import String, TypeDecorator


class UUIDString(TypeDecorator):
    """Platform-independent UUID type. Uses String for SQLite."""
    impl = String(36)
    cache_ok = True

    def process_bind_param(self, value, dialect):
        if value is not None:
            return str(value)
        return value

    def process_result_value(self, value, dialect):
        if value is not None:
            return uuid.UUID(value)
        return value


# Monkey-patch for SQLite compatibility in tests
import sqlalchemy.dialects.sqlite.base as sqlite_base
_orig_get_column_specification = sqlite_base.SQLiteTypeCompiler.visit_UUID if hasattr(sqlite_base.SQLiteTypeCompiler, 'visit_UUID') else None


@pytest_asyncio.fixture(autouse=True)
async def setup_database():
    """Create all tables before each test and drop after."""
    # Replace UUID columns with String for SQLite
    from sqlalchemy.dialects.postgresql import UUID
    from sqlalchemy import String as SA_String

    # Create tables with type adaptation
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield
    async with test_engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)


@pytest_asyncio.fixture
async def db_session():
    """Yield a test database session."""
    async with test_session_factory() as session:
        yield session


@pytest_asyncio.fixture
async def test_user(db_session: AsyncSession):
    """Create and return a test UserProfile."""
    user = UserProfile(
        id=TEST_USER_ID,
        display_name="Test Student",
        current_streak=0,
        longest_streak=0,
        shield_count=0,
        total_xp=0,
        level="Freshman",
    )
    db_session.add(user)
    await db_session.commit()
    await db_session.refresh(user)
    return user


async def override_get_db():
    """Override the get_db dependency for tests."""
    async with test_session_factory() as session:
        yield session


async def override_get_current_user():
    """Override auth to return the test user."""
    async with test_session_factory() as session:
        from sqlalchemy import select
        result = await session.execute(
            select(UserProfile).where(UserProfile.id == TEST_USER_ID)
        )
        user = result.scalar_one_or_none()
        if user is None:
            user = UserProfile(
                id=TEST_USER_ID,
                display_name="Test Student",
                current_streak=0,
                longest_streak=0,
                shield_count=0,
                total_xp=0,
                level="Freshman",
            )
            session.add(user)
            await session.commit()
            await session.refresh(user)
        return user


# Apply dependency overrides
app.dependency_overrides[get_db] = override_get_db
app.dependency_overrides[get_current_user] = override_get_current_user


@pytest_asyncio.fixture
async def client():
    """Yield an httpx AsyncClient for testing."""
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac
