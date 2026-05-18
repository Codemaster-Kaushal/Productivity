"use client";

import { useEffect } from "react";
import { useSyncStore } from "@/store/syncStore";

export function SyncProvider({ children }: { children: React.ReactNode }) {
  const flush = useSyncStore((state) => state.flush);

  useEffect(() => {
    // Flush on window focus and blur
    const handleFocusBlur = () => {
      flush();
    };

    window.addEventListener("focus", handleFocusBlur);
    window.addEventListener("blur", handleFocusBlur);

    // Flush every 30 seconds
    const interval = setInterval(() => {
      flush();
    }, 30 * 1000);

    // Initial flush on load
    flush();

    return () => {
      window.removeEventListener("focus", handleFocusBlur);
      window.removeEventListener("blur", handleFocusBlur);
      clearInterval(interval);
    };
  }, [flush]);

  return <>{children}</>;
}
