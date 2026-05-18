export interface Goal {
  id: string;
  user_id: string;
  title: string;
  subject: string;
  date: string; // ISO Date string (YYYY-MM-DD)
  is_completed: boolean;
  semester_goal_id: string | null;
  focus_window_start: string | null; // HH:mm:ss format
  focus_window_end: string | null;
  created_at: string; // ISO DateTime string
}

export interface Task {
  id: string;
  user_id: string;
  title: string;
  date: string;
  is_completed: boolean;
  linked_goal_id: string | null;
  created_at: string;
}

export interface PomodoroSession {
  id: string;
  user_id: string;
  linked_goal_id: string | null;
  duration_minutes: number;
  started_at: string;
  completed_at: string | null;
  idempotency_key: string;
}

export interface DailyScore {
  id: string;
  user_id: string;
  date: string;
  true_score: number;
  verdict: string;
  big3_points: number | null;
  pomodoro_points: number | null;
  task_points: number | null;
  journal_points: number | null;
  active_points: number | null;
  penalty_points: number | null;
  focus_badge_earned: boolean;
}

export interface CalendarEvent {
  id: string;
  summary?: string;
  description?: string;
  start?: {
    date?: string;
    dateTime?: string;
  };
  end?: {
    date?: string;
    dateTime?: string;
  };
  htmlLink?: string;
}

export interface ConnectedApiResponse<T> extends ApiResponse<T> {
  connected?: boolean;
}

export interface SemesterGoal {
  id: string;
  user_id: string;
  subject: string;
  title: string;
  semester_label: string;
  start_date: string;
  end_date: string;
  is_active: boolean;
  created_at: string;
  progress_pct: number;
  total_milestones: number;
  completed_milestones: number;
}

export interface Milestone {
  id: string;
  semester_goal_id: string;
  title: string;
  is_completed: boolean;
  completed_at: string | null;
}

export interface UserProfile {
  id: string;
  display_name: string;
  current_streak: number;
  longest_streak: number;
  last_active_date: string | null;
  shield_count: number;
  total_xp: number;
  level: string;
  created_at: string;
}

export interface JournalEntry {
  id: string;
  user_id: string;
  date: string;
  content: string;
  ai_prompts: Record<string, unknown> | null;
  created_at: string;
}

export interface JournalToday {
  entry: JournalEntry | null;
  ai_prompts: {
    prompts: string[];
  };
}

export interface SyncOperation {
  operation_type: string;
  payload: Record<string, unknown>;
  idempotency_key: string;
  created_at: string;
}

export interface ApiResponse<T> {
  success: boolean;
  data: T | null;
  error: string | null;
}

export interface SyncPushResponse {
  synced?: number;
  status?: string;
}
