"use client";

import { useTodayGoals, useTodayScores, useProfile, useStreakStatus, useCompleteGoal } from "@/hooks/api-hooks";
import { TrueScoreRing } from "@/components/dashboard/true-score-ring";
import { MomentumBar, Greeting, StreakWidget, Big3Cards } from "@/components/dashboard/widgets";
import { CalendarWidget, StepCounterWidget } from "@/components/dashboard/connected-widgets";

export default function DashboardPage() {
  const { data: goals = [], isError: goalsError } = useTodayGoals();
  const { data: score, isError: scoreError } = useTodayScores();
  const { data: profile } = useProfile();
  const { data: streaks } = useStreakStatus();
  const { mutate: completeGoal } = useCompleteGoal();

  const completedGoals = goals.filter((g) => g.is_completed).length;
  const currentScore = score?.true_score || 0;
  const verdict = score?.verdict || "Getting Started";

  return (
    <div className="mx-auto grid w-full max-w-6xl gap-6 lg:grid-cols-[minmax(0,1fr)_360px]">
      <section className="rounded-[12px] border border-white/10 bg-background/50 p-4 backdrop-blur md:p-6">
        <MomentumBar completed={completedGoals} total={3} />
        <Greeting name={profile?.display_name || "Student"} />

        {scoreError ? (
          <div className="rounded-[12px] border border-accent-coral/30 bg-accent-coral/10 p-4 text-sm text-white">
            True Score could not load. Make sure the backend is running and you are signed in.
          </div>
        ) : (
          <TrueScoreRing score={currentScore} verdict={verdict} />
        )}

        <StreakWidget
          streak={streaks?.current_streak || 0}
          shields={streaks?.shield_count || 0}
        />

        {goalsError ? (
          <div className="rounded-[12px] border border-accent-coral/30 bg-accent-coral/10 p-4 text-sm text-white">
            Goals could not load. Check `NEXT_PUBLIC_API_URL` and start the backend on port 8000.
          </div>
        ) : (
          <Big3Cards goals={goals} onComplete={completeGoal} />
        )}
      </section>

      <aside className="grid content-start gap-4">
        <CalendarWidget />
        <StepCounterWidget />
      </aside>
    </div>
  );
}
