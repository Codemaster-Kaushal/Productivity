"use client";

import { Flame, ShieldCheck, CheckCircle2, Circle } from "lucide-react";
import { cn } from "@/components/ui/button";
import dayjs from "dayjs";
import type { Goal } from "@/types";

export function MomentumBar({ completed, total }: { completed: number; total: number }) {
  const percentage = total > 0 ? (completed / total) * 100 : 0;
  return (
    <div className="w-full h-[6px] bg-white/5 rounded-full overflow-hidden mb-6">
      <div 
        className="h-full bg-primary transition-all duration-500 ease-out"
        style={{ width: `${percentage}%` }}
      />
    </div>
  );
}

export function Greeting({ name }: { name: string }) {
  const dateStr = dayjs().format("dddd, MMMM D");
  return (
    <div className="mb-8">
      <h1 className="text-3xl font-bold text-white mb-1">Good morning, {name}</h1>
      <p className="text-muted text-sm">{dateStr}</p>
    </div>
  );
}

export function StreakWidget({ streak, shields }: { streak: number; shields: number }) {
  return (
    <div className="flex items-center gap-4 bg-card/85 border border-white/10 p-4 rounded-[12px] shadow-sm my-6 backdrop-blur">
      <div className="flex items-center gap-2">
        <Flame className="text-accent-coral" size={24} />
        <span className="text-2xl font-bold text-white">{streak}</span>
        <span className="text-muted text-sm ml-1">Day Streak</span>
      </div>
      <div className="flex-1" />
      <div className="flex items-center gap-2 text-accent-teal">
        <ShieldCheck size={20} />
        <span className="font-semibold">{shields}</span>
      </div>
    </div>
  );
}

export function Big3Cards({ goals, onComplete }: { goals: Goal[]; onComplete: (id: string) => void }) {
  return (
    <div className="my-8">
      <h2 className="text-lg font-semibold text-white mb-4">The Big 3</h2>
      <div className="flex flex-col gap-3">
        {goals.map((goal) => (
          <div 
            key={goal.id} 
            className={cn(
              "p-4 rounded-[12px] border transition-all flex items-center gap-4 cursor-pointer",
              goal.is_completed ? "bg-white/5 border-white/5 opacity-60" : "bg-card/85 border-white/10 hover:border-primary/60 hover:bg-card"
            )}
            onClick={() => !goal.is_completed && onComplete(goal.id)}
          >
            <div className="shrink-0 text-primary">
              {goal.is_completed ? <CheckCircle2 size={24} /> : <Circle size={24} />}
            </div>
            <div className="flex-1">
              <h3 className={cn("font-medium", goal.is_completed ? "line-through text-muted" : "text-white")}>
                {goal.title}
              </h3>
              <p className="text-xs text-muted mt-1">{goal.subject}</p>
            </div>
          </div>
        ))}
        {goals.length === 0 && (
          <div className="p-6 rounded-[12px] bg-card/85 border border-white/10 text-center text-muted text-sm backdrop-blur">
            No goals set for today. Plan your Big 3!
          </div>
        )}
      </div>
    </div>
  );
}
