import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CheckinRepository {
  CheckinRepository();

  final Uuid _uuid = const Uuid();

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<void> saveCheckin({
    required int energy,
    required int focus,
    required int mood,
    String? note,
  }) async {
    await _writeReflectionOperation(
      operationType: 'reflection_summary',
      payload: {
        'date': _today,
        'energy': energy,
        'focus': focus,
        'mood': mood,
        'note': note?.trim() ?? '',
      },
    );
  }

  Future<void> saveMetric({
    required String metric,
    required int value,
    String? note,
  }) async {
    await _writeReflectionOperation(
      operationType: 'reflection_metric',
      payload: {
        'date': _today,
        'metric': metric,
        'value': value,
        'note': note?.trim() ?? '',
      },
    );
  }

  Future<void> saveJournalNote(String content) async {
    await _writeReflectionOperation(
      operationType: 'reflection_journal',
      payload: {
        'date': _today,
        'content': content.trim(),
      },
    );
  }

  Future<Map<String, dynamic>?> getTodayCheckin() async {
    try {
      final response = await _supabase
          .from('sync_operations')
          .select('payload, created_at')
          .eq('user_id', _userId)
          .eq('operation_type', 'reflection_summary')
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();
      return response?['payload'] as Map<String, dynamic>?;
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRecentCheckins({int limit = 7}) async {
    try {
      final response = await _supabase
          .from('sync_operations')
          .select('operation_type, payload, created_at')
          .eq('user_id', _userId)
          .like('operation_type', 'reflection%')
          .order('created_at', ascending: false)
          .limit(limit);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  String get _today => DateTime.now().toIso8601String().split('T')[0];

  Future<void> _writeReflectionOperation({
    required String operationType,
    required Map<String, dynamic> payload,
  }) async {
    await _supabase.from('sync_operations').insert({
      'user_id': _userId,
      'operation_type': operationType,
      'payload': payload,
      'idempotency_key': _uuid.v4(),
      'synced_at': DateTime.now().toIso8601String(),
    });
  }
}
