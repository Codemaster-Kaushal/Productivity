"use client";

import { useQuery } from "@tanstack/react-query";
import dayjs from "dayjs";
import { Activity, CalendarDays, CheckCircle2, ExternalLink, PlugZap } from "lucide-react";
import { api } from "@/lib/api";
import type { CalendarEvent } from "@/types";

function formatEventTime(event: CalendarEvent) {
  const start = event.start?.dateTime ?? event.start?.date;

  if (!start) {
    return "Any time";
  }

  if (event.start?.date) {
    return "All day";
  }

  return dayjs(start).format("h:mm A");
}

function ConnectHint({ label }: { label: string }) {
  return (
    <div className="mt-4 rounded-[8px] border border-dashed border-white/15 bg-white/[0.03] p-3 text-sm text-muted">
      <div className="flex items-center gap-2 text-white">
        <PlugZap size={16} className="text-accent-amber" />
        Connect Google to sync {label}.
      </div>
      <p className="mt-1 text-xs leading-5">
        Sign in with Google and allow Calendar plus fitness activity access.
      </p>
    </div>
  );
}

export function CalendarWidget() {
  const { data, isLoading, isError } = useQuery({
    queryKey: ["calendar", "today"],
    queryFn: () => api.calendar.getToday(),
    staleTime: 5 * 60 * 1000,
  });

  const events = data?.data ?? [];

  return (
    <section className="rounded-[12px] border border-white/10 bg-card/85 p-4 backdrop-blur">
      <div className="flex items-center justify-between gap-3">
        <div>
          <h2 className="text-lg font-semibold text-white">Today</h2>
          <p className="text-sm text-muted">{dayjs().format("dddd, MMM D")}</p>
        </div>
        <div className="rounded-[8px] bg-primary/20 p-2 text-primary">
          <CalendarDays size={20} />
        </div>
      </div>

      <div className="mt-4 space-y-3">
        {isLoading && <p className="text-sm text-muted">Loading calendar...</p>}
        {isError && <p className="text-sm text-accent-coral">Calendar could not load.</p>}
        {!isLoading && !isError && events.length === 0 && (
          <p className="text-sm text-muted">No events on your calendar today.</p>
        )}
        {events.slice(0, 4).map((event) => (
          <a
            key={event.id}
            href={event.htmlLink}
            target="_blank"
            rel="noreferrer"
            className="flex items-center gap-3 rounded-[8px] bg-white/[0.04] p-3 transition-colors hover:bg-white/[0.07]"
          >
            <span className="w-16 shrink-0 text-xs font-medium text-accent-teal">
              {formatEventTime(event)}
            </span>
            <span className="min-w-0 flex-1 truncate text-sm text-white">
              {event.summary || "Untitled event"}
            </span>
            {event.htmlLink && <ExternalLink size={14} className="shrink-0 text-muted" />}
          </a>
        ))}
      </div>

      {data?.connected === false && <ConnectHint label="calendar events" />}
    </section>
  );
}

export function StepCounterWidget() {
  const { data, isLoading, isError } = useQuery({
    queryKey: ["calendar", "steps", "today"],
    queryFn: () => api.calendar.getTodaySteps(),
    staleTime: 5 * 60 * 1000,
  });

  const steps = data?.data ?? 0;
  const goal = 8000;
  const progress = Math.min((steps / goal) * 100, 100);

  return (
    <section className="rounded-[12px] border border-white/10 bg-card/85 p-4 backdrop-blur">
      <div className="flex items-center justify-between gap-3">
        <div>
          <h2 className="text-lg font-semibold text-white">Steps</h2>
          <p className="text-sm text-muted">Synced from Google Fit</p>
        </div>
        <div className="rounded-[8px] bg-accent-teal/15 p-2 text-accent-teal">
          <Activity size={20} />
        </div>
      </div>

      <div className="mt-5">
        <div className="flex items-end gap-2">
          <span className="text-4xl font-bold text-white">
            {isLoading ? "--" : steps.toLocaleString()}
          </span>
          <span className="pb-1 text-sm text-muted">/ {goal.toLocaleString()}</span>
        </div>
        {isError && <p className="mt-2 text-sm text-accent-coral">Step count could not load.</p>}

        <div className="mt-4 h-2 overflow-hidden rounded-full bg-white/10">
          <div
            className="h-full rounded-full bg-accent-teal transition-all duration-500"
            style={{ width: `${progress}%` }}
          />
        </div>
        <div className="mt-3 flex items-center gap-2 text-xs text-muted">
          <CheckCircle2 size={14} className="text-accent-teal" />
          {Math.max(goal - steps, 0).toLocaleString()} steps left today
        </div>
      </div>

      {data?.connected === false && <ConnectHint label="fitness activity" />}
    </section>
  );
}
