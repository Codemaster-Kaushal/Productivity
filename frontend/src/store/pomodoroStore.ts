import { create } from "zustand";
import { api } from "@/lib/api";

export interface PomodoroStore {
  isRunning: boolean;
  secondsLeft: number;
  linkedGoalId: string | null;
  selectedSound: string | null;
  sessionCount: number;
  start: (goalId?: string) => void;
  pause: () => void;
  reset: () => void;
  tick: () => void;
}

const DEFAULT_MINUTES = 25;
const DEFAULT_SECONDS = DEFAULT_MINUTES * 60;

export const usePomodoroStore = create<PomodoroStore>((set, get) => ({
  isRunning: false,
  secondsLeft: DEFAULT_SECONDS,
  linkedGoalId: null,
  selectedSound: null,
  sessionCount: 0,
  start: (goalId?: string) => {
    set({ isRunning: true, linkedGoalId: goalId ?? get().linkedGoalId });
  },
  pause: () => set({ isRunning: false }),
  reset: () => set({ isRunning: false, secondsLeft: DEFAULT_SECONDS }),
  tick: () => {
    const { isRunning, secondsLeft, sessionCount, linkedGoalId } = get();
    if (!isRunning) return;

    if (secondsLeft <= 1) {
      // Timer finished
      // We automatically complete the session
      // For simplicity, we just use the current time minus 25 mins as start
      // In a real app, we'd log the start time.
      const now = new Date();
      const startedAt = new Date(now.getTime() - DEFAULT_MINUTES * 60 * 1000);
      
      api.pomodoro.start({
        linked_goal_id: linkedGoalId,
        duration_minutes: DEFAULT_MINUTES,
        idempotency_key: crypto.randomUUID(),
        started_at: startedAt.toISOString()
      }).then((session) => {
        return api.pomodoro.complete(session.id);
      }).catch(err => {
        console.error("Failed to complete pomodoro:", err);
      });

      set({ 
        isRunning: false, 
        secondsLeft: DEFAULT_SECONDS, 
        sessionCount: sessionCount + 1 
      });
      return;
    }

    set({ secondsLeft: secondsLeft - 1 });
  },
}));
