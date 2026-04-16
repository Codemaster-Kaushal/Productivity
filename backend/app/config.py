"""Application configuration loaded from environment variables."""

from pathlib import Path
from pydantic_settings import BaseSettings
from functools import lru_cache

# Support .env in the backend dir or the project root
_backend_env = Path(__file__).resolve().parent.parent / ".env"
_root_env = Path(__file__).resolve().parent.parent.parent / ".env"
_env_file = str(_backend_env) if _backend_env.exists() else str(_root_env)


class Settings(BaseSettings):
    # Database
    database_url: str = "postgresql+asyncpg://postgres:password@localhost:5432/productivity"

    # Supabase
    supabase_url: str = ""
    supabase_key: str = ""
    supabase_anon_key: str = ""  # alias for supabase_key
    supabase_service_key: str = ""
    supabase_jwt_secret: str = ""

    # OpenAI
    openai_api_key: str = ""
    openai_model: str = "gpt-4o"

    # Google OAuth
    google_client_id: str = ""
    google_client_secret: str = ""

    # Sentry
    sentry_dsn: str = ""

    # App
    app_env: str = "development"

    model_config = {"env_file": _env_file, "env_file_encoding": "utf-8", "extra": "ignore"}

    @property
    def effective_supabase_key(self) -> str:
        """Return whichever Supabase anon key is set."""
        return self.supabase_key or self.supabase_anon_key


@lru_cache
def get_settings() -> Settings:
    return Settings()
