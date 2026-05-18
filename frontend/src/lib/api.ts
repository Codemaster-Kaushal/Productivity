import { createClient } from "@/utils/supabase/client";
import type {
  ApiResponse,
  CalendarEvent,
  ConnectedApiResponse,
  DailyScore,
  Goal,
  JournalEntry,
  JournalToday,
  PomodoroSession,
  SemesterGoal,
  SyncPushResponse,
  Task,
  UserProfile,
} from "@/types";
import { useSyncStore } from "@/store/syncStore";

const API_BASE = process.env.NEXT_PUBLIC_API_URL;

async function fetchApi<T>(endpoint: string, options: RequestInit = {}): Promise<T> {
  const supabase = createClient();
  const { data: { session } } = await supabase.auth.getSession();

  const headers = new Headers(options.headers);
  if (session?.access_token) {
    headers.set("Authorization", `Bearer ${session.access_token}`);
  }
  if (!headers.has("Content-Type")) {
    headers.set("Content-Type", "application/json");
  }

  const method = options.method || "GET";
  let idempotencyKey: string | null = null;
  const isMutation = ["POST", "PATCH", "DELETE", "PUT"].includes(method);

  // Skip sync tracking for /sync/push itself to avoid infinite loops
  if (isMutation && !endpoint.includes("/sync/push")) {
    try {
      const payload = options.body ? JSON.parse(options.body as string) : {};
      idempotencyKey = useSyncStore.getState().enqueue({
        operation_type: `${method} ${endpoint}`,
        payload,
      });
    } catch {
      // Ignore parsing errors for non-JSON bodies
    }
  }

  try {
    const response = await fetch(`${API_BASE}${endpoint}`, {
      ...options,
      headers,
    });

    if (!response.ok) {
      const text = await response.text();
      throw new Error(`API Error: ${response.status} - ${text}`);
    }

    const result: ApiResponse<T> = await response.json();
    if (!result.success) {
      throw new Error(result.error || "Unknown API error");
    }

    if (idempotencyKey) {
      useSyncStore.getState().dequeue([idempotencyKey]);
    }

    return result.data as T;
  } catch (err) {
    // If we fail (e.g., network error), we leave the operation in the queue
    throw err;
  }
}

async function fetchApiEnvelope<T>(
  endpoint: string,
  options: RequestInit = {}
): Promise<ConnectedApiResponse<T>> {
  const supabase = createClient();
  const { data: { session } } = await supabase.auth.getSession();

  const headers = new Headers(options.headers);
  if (session?.access_token) {
    headers.set("Authorization", `Bearer ${session.access_token}`);
  }
  if (!headers.has("Content-Type")) {
    headers.set("Content-Type", "application/json");
  }

  const response = await fetch(`${API_BASE}${endpoint}`, {
    ...options,
    headers,
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`API Error: ${response.status} - ${text}`);
  }

  const result: ConnectedApiResponse<T> = await response.json();
  if (!result.success) {
    throw new Error(result.error || "Unknown API error");
  }

  return result;
}

function normalizeJournalToday(data: JournalToday | JournalEntry): JournalToday {
  if ("entry" in data) {
    return data;
  }

  return {
    entry: data,
    ai_prompts: (data.ai_prompts as JournalToday["ai_prompts"] | null) ?? {
      prompts: [],
    },
  };
}

export const api = {
  goals: {
    getToday: () => fetchApi<Goal[]>("/goals/today"),
    create: (data: Partial<Goal>) => fetchApi<Goal>("/goals", { method: "POST", body: JSON.stringify(data) }),
    complete: (goalId: string) => fetchApi<Goal>(`/goals/${goalId}/complete`, { method: "PATCH" }),
    delete: (goalId: string) => fetchApi<{ deleted: boolean }>(`/goals/${goalId}`, { method: "DELETE" }),
  },
  tasks: {
    getToday: () => fetchApi<Task[]>("/tasks/today"),
    create: (data: Partial<Task>) => fetchApi<Task>("/tasks", { method: "POST", body: JSON.stringify(data) }),
    complete: (taskId: string) => fetchApi<Task>(`/tasks/${taskId}/complete`, { method: "PATCH" }),
    delete: (taskId: string) => fetchApi<{ deleted: boolean }>(`/tasks/${taskId}`, { method: "DELETE" }),
  },
  pomodoro: {
    getToday: () => fetchApi<PomodoroSession[]>("/pomodoro/today"),
    start: (data: Partial<PomodoroSession>) => fetchApi<PomodoroSession>("/pomodoro/start", { method: "POST", body: JSON.stringify(data) }),
    complete: (sessionId: string) => fetchApi<PomodoroSession>(`/pomodoro/${sessionId}/complete`, { method: "POST" }),
  },
  journal: {
    getToday: async () => normalizeJournalToday(
      await fetchApi<JournalToday | JournalEntry>("/journal/today")
    ),
    submit: (data: Partial<JournalEntry>) => fetchApi<JournalEntry>("/journal/today", { method: "POST", body: JSON.stringify(data) }),
  },
  scores: {
    getToday: () => fetchApi<DailyScore>("/scores/today"),
    getWeek: () => fetchApi<DailyScore[]>("/scores/week"),
    getHistory: (page: number = 1) => fetchApi<{ page: number; limit: number; scores: DailyScore[] }>(`/scores/history?page=${page}`),
  },
  semester: {
    getGoals: () => fetchApi<SemesterGoal[]>("/semester-goals"),
    createGoal: (data: Partial<SemesterGoal>) => fetchApi<SemesterGoal>("/semester-goals", { method: "POST", body: JSON.stringify(data) }),
    completeMilestone: (milestoneId: string) => fetchApi<SemesterGoal>(`/milestones/${milestoneId}/complete`, { method: "PATCH" }),
  },
  user: {
    getProfile: () => fetchApi<UserProfile>("/user/profile"),
    updateProfile: (data: Partial<UserProfile>) => fetchApi<UserProfile>("/user/profile", { method: "PATCH", body: JSON.stringify(data) }),
  },
  streaks: {
    getStatus: () => fetchApi<{ current_streak: number; shield_count: number }>("/streaks/status"),
  },
  calendar: {
    getToday: () => fetchApiEnvelope<CalendarEvent[]>("/calendar/today"),
    getMonth: (month: string) => fetchApiEnvelope<CalendarEvent[]>(`/calendar/month?month=${month}`),
    getTodaySteps: () => fetchApiEnvelope<number>("/calendar/steps/today"),
  },
  sync: {
    push: (data: unknown) => fetchApi<SyncPushResponse>("/sync/push", { method: "POST", body: JSON.stringify(data) }),
  }
};
