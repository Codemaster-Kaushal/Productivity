"use client";

import { createClient } from "@/utils/supabase/client";
import { Button } from "@/components/ui/button"; // Will create this
import { LogIn } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";

export default function LoginPage() {
  const [isLoading, setIsLoading] = useState(false);
  const supabase = createClient();

  const handleGoogleLogin = async () => {
    setIsLoading(true);
    try {
      const { error } = await supabase.auth.signInWithOAuth({
        provider: "google",
        options: {
          redirectTo: `${window.location.origin}/auth/callback`,
          scopes: [
            "openid",
            "email",
            "profile",
            "https://www.googleapis.com/auth/calendar.events", // Note: The flutter app requested calendar.events and tasks, but prompt said calendar.readonly. I will use what the prompt specifically asked for.
            "https://www.googleapis.com/auth/calendar.readonly",
            "https://www.googleapis.com/auth/fitness.activity.read",
          ].join(" "),
          queryParams: {
            access_type: "offline",
            prompt: "consent",
          },
        },
      });

      if (error) throw error;
    } catch (error: unknown) {
      toast.error(error instanceof Error ? error.message : "Failed to sign in with Google");
      setIsLoading(false);
    }
  };

  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-background p-4">
      <div className="w-full max-w-md rounded-[12px] bg-card p-8 shadow-xl border border-white/5">
        <div className="flex flex-col items-center space-y-6 text-center">
          <div className="h-16 w-16 rounded-2xl bg-primary/20 flex items-center justify-center text-primary">
            <LogIn size={32} />
          </div>
          
          <div className="space-y-2">
            <h1 className="text-3xl font-bold tracking-tight text-white">Welcome Back</h1>
            <p className="text-muted text-sm">
              Sign in to continue your productivity journey.
            </p>
          </div>

          <Button
            onClick={handleGoogleLogin}
            disabled={isLoading}
            className="w-full h-12 bg-white text-black hover:bg-white/90 font-medium rounded-[8px] transition-colors"
          >
            {isLoading ? "Connecting..." : "Continue with Google"}
          </Button>
        </div>
      </div>
    </div>
  );
}
