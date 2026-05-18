import { NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const next = searchParams.get("next") ?? "/dashboard";

  if (code) {
    try {
      // Send the code to the FastAPI backend as required
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/auth/google`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ code }),
      });

      if (response.ok) {
        const result = await response.json();
        
        if (result.success && result.data?.access_token && result.data?.refresh_token) {
          const supabase = await createClient();
          
          // Set the session using the tokens returned by the backend
          const { error } = await supabase.auth.setSession({
            access_token: result.data.access_token,
            refresh_token: result.data.refresh_token,
          });

          if (!error) {
            return NextResponse.redirect(`${origin}${next}`);
          } else {
            console.error("Supabase setSession error:", error);
          }
        } else {
          console.error("Backend response invalid:", result);
        }
      } else {
        const errorText = await response.text();
        console.error("Backend exchange failed:", response.status, errorText);
      }
    } catch (err) {
      console.error("Callback error:", err);
    }
  }

  // fallback to login page if something goes wrong
  return NextResponse.redirect(`${origin}/login?error=AuthFailed`);
}
