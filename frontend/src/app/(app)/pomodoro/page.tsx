"use client";

import { useEffect } from "react";
import { usePomodoroStore } from "@/store/pomodoroStore";
import { Button } from "@/components/ui/button";
import { Play, Pause, RotateCcw } from "lucide-react";
import { cn } from "@/components/ui/button";

export default function PomodoroPage() {
  const { isRunning, secondsLeft, sessionCount, start, pause, reset, tick } = usePomodoroStore();

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (isRunning) {
      interval = setInterval(() => {
        tick();
      }, 1000);
    }
    return () => clearInterval(interval);
  }, [isRunning, tick]);

  const minutes = Math.floor(secondsLeft / 60);
  const seconds = secondsLeft % 60;
  const timeStr = `${minutes.toString().padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`;

  return (
    <div className="flex flex-col items-center justify-center min-h-[60vh] max-w-md mx-auto py-8">
      <h1 className="text-3xl font-bold text-white mb-2">Focus Mode</h1>
      <p className="text-muted text-sm mb-12">Sessions completed: {sessionCount}</p>

      <div className="relative w-64 h-64 flex items-center justify-center mb-12">
        <svg className="absolute inset-0 w-full h-full -rotate-90" viewBox="0 0 100 100">
          <circle 
            cx="50" cy="50" r="45" 
            stroke="currentColor" 
            strokeWidth="4" 
            fill="none" 
            className="text-white/5" 
          />
          <circle 
            cx="50" cy="50" r="45" 
            stroke="currentColor" 
            strokeWidth="4" 
            fill="none" 
            className={cn("transition-all duration-1000", isRunning ? "text-primary" : "text-muted")}
            strokeDasharray={283}
            strokeDashoffset={283 - (283 * (secondsLeft / (25 * 60)))}
            strokeLinecap="round"
          />
        </svg>
        <div className="text-5xl font-bold tracking-tighter text-white tabular-nums">
          {timeStr}
        </div>
      </div>

      <div className="flex items-center gap-4">
        <Button 
          className="h-14 w-14 rounded-full border border-white/10 bg-card hover:bg-white/5 flex items-center justify-center transition-colors"
          onClick={reset}
        >
          <RotateCcw className="text-white" size={24} />
        </Button>
        
        {isRunning ? (
          <Button 
            className="h-20 w-20 rounded-full bg-accent-coral hover:bg-accent-coral/90 flex items-center justify-center"
            onClick={pause}
          >
            <Pause className="text-white" size={32} />
          </Button>
        ) : (
          <Button 
            className="h-20 w-20 rounded-full bg-primary hover:bg-primary/90 flex items-center justify-center"
            onClick={() => start()}
          >
            <Play className="text-white ml-2" size={32} />
          </Button>
        )}
      </div>
    </div>
  );
}
