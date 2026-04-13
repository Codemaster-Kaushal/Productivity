"""Productivity Backend — FastAPI Application."""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes.debrief_router import router as debrief_router

app = FastAPI(
    title="Productivity API",
    description="Backend for the Productivity gamified study app",
    version="0.1.0",
)

# CORS — allow Flutter frontend during local development
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(debrief_router)


@app.get("/health")
async def health_check():
    return {"status": "ok"}
