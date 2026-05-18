import { create } from "zustand";
import { persist } from "zustand/middleware";
import { SyncOperation } from "@/types";
import { api } from "@/lib/api";

interface SyncState {
  queue: SyncOperation[];
  isSyncing: boolean;
  enqueue: (operation: Omit<SyncOperation, "created_at" | "idempotency_key">) => string;
  dequeue: (idempotencyKeys: string[]) => void;
  flush: () => Promise<void>;
}

export const useSyncStore = create<SyncState>()(
  persist(
    (set, get) => ({
      queue: [],
      isSyncing: false,

      enqueue: (op) => {
        const idempotency_key = crypto.randomUUID();
        const operation: SyncOperation = {
          ...op,
          idempotency_key,
          created_at: new Date().toISOString(),
        };

        set((state) => ({ queue: [...state.queue, operation] }));
        return idempotency_key;
      },

      dequeue: (keys) => {
        set((state) => ({
          queue: state.queue.filter((op) => !keys.includes(op.idempotency_key)),
        }));
      },

      flush: async () => {
        const { queue, isSyncing, dequeue } = get();
        if (isSyncing || queue.length === 0) return;

        set({ isSyncing: true });

        try {
          // Send all pending operations to the backend
          const response = await api.sync.push({ operations: queue });
          
          // On success, dequeue the items that were successfully pushed
          // The backend currently just returns { synced: N, status: 'ok' }
          // Assuming all were successful if response succeeds without throwing
          if (response && response.status === "ok") {
            dequeue(queue.map(op => op.idempotency_key));
          }
        } catch (error) {
          console.error("Offline sync flush failed:", error);
        } finally {
          set({ isSyncing: false });
        }
      },
    }),
    {
      name: "productivity-sync-queue",
    }
  )
);
