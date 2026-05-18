import { Navigation } from "@/components/navigation";
import ShaderBackground from "@/components/ui/shader-background";

export default function AppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="relative flex min-h-screen overflow-hidden bg-background">
      <ShaderBackground />
      <div className="fixed inset-0 -z-[9] bg-background/60" />
      <Navigation />
      
      {/* Main Content Area */}
      {/* 
        On mobile: padded bottom for the tab bar.
        On desktop: padded left for the collapsed sidebar (64px).
      */}
      <main className="flex-1 pb-16 md:pb-0 md:pl-[64px] transition-all duration-300">
        <div className="mx-auto max-w-6xl p-4 md:p-8">
          {children}
        </div>
      </main>
    </div>
  );
}
