"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { LayoutDashboard, Target, Timer, Book, TrendingUp } from "lucide-react";
import { cn } from "@/components/ui/button";

const navItems = [
  { name: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
  { name: "Goals", href: "/goals", icon: Target },
  { name: "Focus", href: "/pomodoro", icon: Timer },
  { name: "Journal", href: "/journal", icon: Book },
  { name: "Progress", href: "/progress", icon: TrendingUp },
];

export function Navigation() {
  const pathname = usePathname();

  return (
    <>
      {/* Mobile Bottom Tab Bar (<768px) */}
      <nav className="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-card/95 border-t border-white/10 flex items-center justify-around z-50 backdrop-blur">
        {navItems.map((item) => {
          const isActive = pathname.startsWith(item.href);
          return (
            <Link
              key={item.name}
              href={item.href}
              className="flex flex-col items-center justify-center w-full h-full"
            >
              <div
                className={cn(
                  "p-2 rounded-xl transition-colors",
                  isActive ? "bg-primary text-white" : "text-muted hover:text-white"
                )}
              >
                <item.icon size={24} />
              </div>
            </Link>
          );
        })}
      </nav>

      {/* Desktop Sidebar (≥768px) */}
      <nav className="hidden md:flex flex-col fixed top-0 left-0 h-full w-[64px] hover:w-[200px] bg-card/90 border-r border-white/10 transition-all duration-300 z-50 group overflow-hidden backdrop-blur">
        <div className="flex items-center justify-center h-16 w-[64px] shrink-0 border-b border-white/5">
          <div className="w-8 h-8 rounded-lg bg-primary/20 text-primary flex items-center justify-center font-bold">
            P
          </div>
        </div>

        <div className="flex-1 py-4 flex flex-col gap-2">
          {navItems.map((item) => {
            const isActive = pathname.startsWith(item.href);
            return (
              <Link
                key={item.name}
                href={item.href}
                className={cn(
                  "flex items-center h-12 px-3 mx-2 rounded-xl transition-colors whitespace-nowrap",
                  isActive
                    ? "bg-primary text-white"
                    : "text-muted hover:bg-white/5 hover:text-white"
                )}
              >
                <item.icon size={24} className="shrink-0" />
                <span className="ml-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                  {item.name}
                </span>
              </Link>
            );
          })}
        </div>
      </nav>
    </>
  );
}
