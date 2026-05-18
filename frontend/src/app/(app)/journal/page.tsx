"use client";

import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { toast } from "sonner";

export default function JournalPage() {
  const queryClient = useQueryClient();
  const [draft, setDraft] = useState<string | null>(null);

  const { data: journalData } = useQuery({
    queryKey: ["journal", "today"],
    queryFn: () => api.journal.getToday(),
  });

  const content = draft ?? journalData?.entry?.content ?? "";

  const { mutate: submitJournal, isPending } = useMutation({
    mutationFn: (text: string) => api.journal.submit({ content: text }),
    onSuccess: () => {
      toast.success("Journal saved!");
      queryClient.invalidateQueries({ queryKey: ["journal", "today"] });
      queryClient.invalidateQueries({ queryKey: ["scores", "today"] });
    },
    onError: (err: unknown) => {
      toast.error(err instanceof Error ? err.message : "Failed to save journal");
    }
  });

  const prompts = journalData?.ai_prompts?.prompts || [
    "What was the most meaningful thing you accomplished today?",
    "What challenged you today and how did you handle it?",
    "What are you grateful for right now?"
  ];

  return (
    <div className="max-w-xl mx-auto py-8">
      <h1 className="text-3xl font-bold text-white mb-6">Daily Reflection</h1>
      
      <div className="bg-card border border-white/5 rounded-[12px] p-6 mb-8">
        <h2 className="text-lg font-medium text-white mb-4">AI Prompts</h2>
        <ul className="space-y-3">
          {prompts.map((prompt: string, i: number) => (
            <li key={i} className="flex gap-3 text-sm text-muted">
              <span className="text-primary font-bold">{i + 1}.</span>
              {prompt}
            </li>
          ))}
        </ul>
      </div>

      <div className="space-y-4">
        <textarea
          value={content}
          onChange={(e) => setDraft(e.target.value)}
          placeholder="Write your thoughts here..."
          className="w-full h-64 bg-card border border-white/10 rounded-[12px] p-4 text-white placeholder:text-muted focus:outline-none focus:border-primary resize-none transition-colors"
        />
        
        <Button 
          onClick={() => submitJournal(content)}
          disabled={isPending || content.trim() === ""}
          className="w-full h-12 bg-primary text-white hover:bg-primary/90"
        >
          {isPending ? "Saving..." : "Save Entry"}
        </Button>
      </div>
    </div>
  );
}
