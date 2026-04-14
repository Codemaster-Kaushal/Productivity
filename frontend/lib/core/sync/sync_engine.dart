import 'dart:async';
import '../database/database_service.dart';
import '../database/app_database.dart' as db;
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/sync_operation.dart';
import '../network/dio_client.dart';

class SyncEngine {
  final DioClient _dio;
  Timer? _debounceTimer;

  SyncEngine(this._dio);

  // Call this after every user mutation
  Future<void> enqueue(SyncOperation operation) async {
    final database = DatabaseService().db;
    final userId = Supabase.instance.client.auth.currentSession?.user.id ?? '';
    await database.into(database.syncOperations).insertOnConflictUpdate(
      db.SyncOperationsCompanion.insert(
        id: operation.id,
        userId: userId,
        operationType: "${operation.method}_${operation.collection}",
        payload: operation.payload,
        idempotencyKey: operation.id,
        createdAt: operation.createdAt,
        syncedAt: Value(operation.syncedAt),
      )
    );
    _scheduleSyncDebounced();
  }

  // Debounced — only fires 30 seconds after last mutation
  void _scheduleSyncDebounced() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(seconds: 30), () => flush());
  }

  // Also call on app foreground and app background events
  Future<void> flush() async {
    final database = DatabaseService().db;
    final pendingRows = await (database.select(database.syncOperations)..where((o) => o.syncedAt.isNull())).get();
    
    if (pendingRows.isEmpty) return;

    final pending = pendingRows.map((o) => SyncOperation(
      id: o.id,
      collection: o.operationType.split('_').last,
      method: o.operationType.split('_').first,
      payload: o.payload,
      createdAt: o.createdAt,
      syncedAt: o.syncedAt,
    )).toList();

    try {
      await _dio.post('/sync/push', data: {
        'operations': pending.map((op) => op.toJson()).toList(),
      });
      // Mark all as synced
      for (var op in pending) {
        await (database.update(database.syncOperations)..where((o) => o.id.equals(op.id))).write(
          db.SyncOperationsCompanion(syncedAt: Value(DateTime.now())),
        );
      }
    } catch (_) {
      // Silent fail — operations stay in queue, retry next cycle
    }
  }
}
