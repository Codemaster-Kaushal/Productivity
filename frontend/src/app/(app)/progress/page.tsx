"use client";

import { useQuery } from "@tanstack/react-query";
import { api } from "@/lib/api";
import { TrueScoreRing } from "@/components/dashboard/true-score-ring";
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from "recharts";
import dayjs from "dayjs";

export default function ProgressPage() {
  const { data: weekScores = [], isLoading, isError, error } = useQuery({
    queryKey: ["scores", "week"],
    queryFn: () => api.scores.getWeek(),
  });

  if (isLoading) {
    return <div className="p-8 text-center text-muted">Loading progress...</div>;
  }

  const chartData = weekScores.map((score) => ({
    name: dayjs(score.date).format("dd"),
    score: score.true_score,
  }));

  const latestScore = weekScores[weekScores.length - 1];

  return (
    <div className="mx-auto max-w-4xl rounded-[12px] border border-white/10 bg-background/50 p-5 backdrop-blur md:p-8">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-white">Progress</h1>
        <p className="mt-2 text-sm text-muted">Your True Score trend for the last seven days.</p>
      </div>

      {isError && (
        <div className="mb-6 rounded-[12px] border border-accent-coral/30 bg-accent-coral/10 p-4 text-sm text-white">
          <p className="font-medium">Progress could not load.</p>
          <p className="mt-1 text-white/75">
            {error instanceof Error ? error.message : "Start the backend and sign in again."}
          </p>
        </div>
      )}
      
      {latestScore && (
        <div className="mb-12">
          <TrueScoreRing score={latestScore.true_score} verdict={latestScore.verdict} />
        </div>
      )}

      <div className="bg-card/85 border border-white/10 rounded-[12px] p-6">
        <h2 className="text-lg font-medium text-white mb-6">Last 7 Days</h2>
        <div className="h-64 w-full">
          {chartData.length > 0 ? (
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={chartData}>
                <XAxis dataKey="name" stroke="#B2BEC3" fontSize={12} tickLine={false} axisLine={false} />
                <YAxis stroke="#B2BEC3" fontSize={12} tickLine={false} axisLine={false} />
                <Tooltip
                  cursor={{ fill: "rgba(255,255,255,0.05)" }}
                  contentStyle={{ backgroundColor: "#2D2A3E", border: "none", borderRadius: "8px", color: "#fff" }}
                />
                <Bar dataKey="score" fill="#6C5CE7" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          ) : (
            <div className="flex h-full items-center justify-center text-sm text-muted">
              No score history yet.
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
