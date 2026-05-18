"use client";

import { useQuery } from "@tanstack/react-query";
import { api } from "@/lib/api";

export default function SemesterPage() {
  const { data: goals = [], isLoading } = useQuery({
    queryKey: ["semester-goals"],
    queryFn: () => api.semester.getGoals(),
  });

  if (isLoading) {
    return <div className="p-8 text-center text-muted">Loading semester goals...</div>;
  }

  return (
    <div className="max-w-2xl mx-auto py-8">
      <h1 className="text-3xl font-bold text-white mb-8">Semester Goals</h1>
      
      <div className="space-y-4">
        {goals.map((goal) => (
          <div key={goal.id} className="bg-card border border-white/5 rounded-[12px] p-6">
            <h2 className="text-xl font-bold text-white mb-1">{goal.title}</h2>
            <p className="text-sm text-muted mb-4">{goal.subject} • {goal.semester_label}</p>
            
            <div className="w-full h-2 bg-white/5 rounded-full overflow-hidden mb-2">
              <div 
                className="h-full bg-accent-teal transition-all duration-500 ease-out"
                style={{ width: `${goal.progress_pct}%` }}
              />
            </div>
            <div className="flex justify-between text-xs text-muted">
              <span>{goal.completed_milestones} / {goal.total_milestones} Milestones</span>
              <span>{goal.progress_pct.toFixed(0)}%</span>
            </div>
          </div>
        ))}

        {goals.length === 0 && (
          <div className="p-8 text-center text-muted border border-white/5 rounded-[12px]">
            No semester goals active.
          </div>
        )}
      </div>
    </div>
  );
}
