import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/pomodoro_session.dart';

class PomodoroRepository {
  PomodoroRepository();

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<void> saveSession(PomodoroSession session) async {
    await _supabase.from('pomodoro_sessions').insert({
      'user_id': _userId,
      'linked_goal_id': session.goalId == 'general' ? null : session.goalId,
      'duration_minutes': session.durationMinutes,
      'started_at': session.startTime.toIso8601String(),
      'completed_at': session.endTime?.toIso8601String(),
      'idempotency_key': session.id,
    });
  }

  Future<List<PomodoroSession>> getTodaySessions() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await _supabase
        .from('pomodoro_sessions')
        .select()
        .eq('user_id', _userId)
        .gte('started_at', '${today}T00:00:00')
        .not('completed_at', 'is', null)
        .order('started_at', ascending: false);

    return (response as List).map((row) => PomodoroSession(
      id: row['id'],
      userId: row['user_id'],
      goalId: row['linked_goal_id'] ?? 'general',
      durationMinutes: row['duration_minutes'] ?? 25,
      startTime: DateTime.parse(row['started_at']),
      endTime: row['completed_at'] != null ? DateTime.parse(row['completed_at']) : null,
      isCompleted: row['completed_at'] != null,
      date: today,
      createdAt: DateTime.parse(row['started_at']),
    )).toList();
  }

  Future<int> getTodayFocusMinutes() async {
    final sessions = await getTodaySessions();
    return sessions.fold<int>(0, (int sum, s) => sum + s.durationMinutes);
  }

  Future<int> getCurrentStreak() async {
    try {
      final response = await _supabase
          .from('user_profiles')
          .select('current_streak')
          .eq('id', _userId)
          .single();
      return (response['current_streak'] as num?)?.toInt() ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<List<int>> getLast7FocusMinutes() async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 6));

    try {
      final response = await _supabase
          .from('pomodoro_sessions')
          .select('duration_minutes, started_at, completed_at')
          .eq('user_id', _userId)
          .gte('started_at', '${start.toIso8601String().split('T')[0]}T00:00:00')
          .not('completed_at', 'is', null)
          .order('started_at');

      final totals = List<int>.filled(7, 0);
      for (final row in response as List) {
        final startedAt = DateTime.parse(row['started_at'] as String);
        final dayIndex = startedAt
            .difference(DateTime(start.year, start.month, start.day))
            .inDays;
        if (dayIndex >= 0 && dayIndex < totals.length) {
          totals[dayIndex] += (row['duration_minutes'] as num?)?.toInt() ?? 0;
        }
      }
      return totals;
    } catch (_) {
      return List<int>.filled(7, 0);
    }
  }
}
