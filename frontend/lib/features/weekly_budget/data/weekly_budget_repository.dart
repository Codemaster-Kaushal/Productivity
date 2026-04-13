import 'package:supabase_flutter/supabase_flutter.dart';

class WeeklyBudgetRepository {
  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  String _weekStart() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return monday.toIso8601String().split('T')[0];
  }

  Future<List<Map<String, dynamic>>> getWeeklyTargets() async {
    try {
      final response = await _supabase
          .from('weekly_targets')
          .select()
          .eq('user_id', _userId)
          .eq('week_start', _weekStart())
          .order('subject');
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  Future<void> setTarget(String subject, int targetSessions) async {
    await _supabase.from('weekly_targets').upsert(
      {
        'user_id': _userId,
        'subject': subject,
        'target_sessions': targetSessions,
        'week_start': _weekStart(),
      },
      onConflict: 'user_id,subject,week_start',
    );
  }

  Future<Map<String, int>> getActualSessionsThisWeek() async {
    final weekStart = _weekStart();
    try {
      // Get pomodoro sessions for this week, joined with goals to get subjects
      final response = await _supabase
          .from('pomodoro_sessions')
          .select('linked_goal_id, goals!inner(subject)')
          .eq('user_id', _userId)
          .gte('started_at', '${weekStart}T00:00:00')
          .not('completed_at', 'is', null);

      final Map<String, int> counts = {};
      for (final row in (response as List)) {
        final goals = row['goals'];
        if (goals != null) {
          final subject = goals['subject'] as String;
          counts[subject] = (counts[subject] ?? 0) + 1;
        }
      }
      return counts;
    } catch (_) {
      return {};
    }
  }

  Future<void> deleteTarget(String subject) async {
    await _supabase
        .from('weekly_targets')
        .delete()
        .eq('user_id', _userId)
        .eq('subject', subject)
        .eq('week_start', _weekStart());
  }
}
