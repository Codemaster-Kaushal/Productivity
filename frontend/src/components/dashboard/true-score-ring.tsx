"use client";

import { motion } from "framer-motion";
import { useEffect, useState } from "react";

interface TrueScoreRingProps {
  score: number;
  verdict: string;
}

export function TrueScoreRing({ score, verdict }: TrueScoreRingProps) {
  const [displayScore, setDisplayScore] = useState(0);

  // Animation values
  const radius = 120;
  const strokeWidth = 24;
  const circumference = 2 * Math.PI * radius;
  const strokeDashoffset = circumference - (score / 100) * circumference;

  const getColor = (val: number) => {
    if (val >= 85) return "#00B894"; // teal
    if (val >= 70) return "#55EFC4"; // light teal
    if (val >= 50) return "#FDCB6E"; // amber
    if (val >= 30) return "#E17055"; // coral
    return "#D63031"; // red
  };

  const color = getColor(score);

  useEffect(() => {
    let startTimestamp: number;
    const duration = 1200; // 1.2s

    const step = (timestamp: number) => {
      if (!startTimestamp) startTimestamp = timestamp;
      const progress = Math.min((timestamp - startTimestamp) / duration, 1);
      setDisplayScore(Math.floor(progress * score));
      if (progress < 1) {
        window.requestAnimationFrame(step);
      }
    };
    window.requestAnimationFrame(step);
  }, [score]);

  return (
    <div className="relative flex flex-col items-center justify-center py-8">
      <div className="relative w-72 h-72">
        <svg
          className="w-full h-full -rotate-90 transform"
          viewBox="0 0 300 300"
        >
          {/* Background Ring */}
          <circle
            cx="150"
            cy="150"
            r={radius}
            stroke="rgba(255,255,255,0.05)"
            strokeWidth={strokeWidth}
            fill="none"
          />
          {/* Animated Foreground Ring */}
          <motion.circle
            cx="150"
            cy="150"
            r={radius}
            stroke={color}
            strokeWidth={strokeWidth}
            fill="none"
            strokeLinecap="round"
            initial={{ strokeDashoffset: circumference }}
            animate={{ strokeDashoffset }}
            transition={{ duration: 1.2, ease: "easeOut" }}
            style={{ strokeDasharray: circumference }}
          />
        </svg>

        <div className="absolute inset-0 flex flex-col items-center justify-center">
          <span className="text-6xl font-bold tracking-tighter" style={{ color }}>
            {displayScore}
          </span>
          <span className="text-muted text-sm uppercase tracking-widest mt-1">
            True Score
          </span>
        </div>
      </div>

      <motion.div
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 1.5, duration: 0.3 }}
        className="mt-6 flex flex-col items-center gap-2"
      >
        <span className="text-xl font-medium text-white">{verdict}</span>
      </motion.div>
    </div>
  );
}
