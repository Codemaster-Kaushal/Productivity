"use client";

import { useTodayGoals, useCompleteGoal } from "@/hooks/api-hooks";
import { Big3Cards } from "@/components/dashboard/widgets";

export default function GoalsPage() {
  const { data: goals = [], isLoading, isError, error } = useTodayGoals();
  const { mutate: completeGoal } = useCompleteGoal();

  if (isLoading) {
    return <div className="p-8 text-center text-muted">Loading goals...</div>;
  }

  return (
    <div className="mx-auto max-w-2xl rounded-[12px] border border-white/10 bg-background/50 p-5 backdrop-blur md:p-8">
      <div className="mb-8 flex flex-col gap-2">
        <h1 className="text-3xl font-bold text-white mb-2">Today&apos;s Goals</h1>
        <p className="text-muted text-sm">Focus on what matters most.</p>
      </div>

      {isError ? (
        <div className="rounded-[12px] border border-accent-coral/30 bg-accent-coral/10 p-4 text-sm text-white">
          <p className="font-medium">Goals could not load.</p>
          <p className="mt-1 text-white/75">
            {error instanceof Error ? error.message : "Start the backend and sign in again."}
          </p>
        </div>
      ) : (
        <Big3Cards goals={goals} onComplete={completeGoal} />
      )}
    </div>
  );
}
