"use client";

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "@/lib/api";
import type { Goal } from "@/types";

export function useTodayGoals() {
  return useQuery({
    queryKey: ["goals", "today"],
    queryFn: () => api.goals.getToday(),
    staleTime: 30_000,
  });
}

export function useTodayScores() {
  return useQuery({
    queryKey: ["scores", "today"],
    queryFn: () => api.scores.getToday(),
    staleTime: 30_000,
  });
}

export function useProfile() {
  return useQuery({
    queryKey: ["profile"],
    queryFn: () => api.user.getProfile(),
    staleTime: 60_000,
  });
}

export function useStreakStatus() {
  return useQuery({
    queryKey: ["streaks"],
    queryFn: () => api.streaks.getStatus(),
    staleTime: 60_000,
  });
}

export function useCompleteGoal() {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: (goalId: string) => api.goals.complete(goalId),
    onMutate: async (goalId) => {
      await queryClient.cancelQueries({ queryKey: ["goals", "today"] });
      const previous = queryClient.getQueryData<Goal[]>(["goals", "today"]);
      
      queryClient.setQueryData<Goal[]>(["goals", "today"], (old) =>
        old?.map((g) => g.id === goalId ? { ...g, is_completed: true } : g)
      );
      
      return { previous };
    },
    onError: (_, __, context) => {
      queryClient.setQueryData(["goals", "today"], context?.previous);
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ["goals", "today"] });
      queryClient.invalidateQueries({ queryKey: ["scores", "today"] });
    },
  });
}
