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
}
