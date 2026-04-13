import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardRepository {
  DashboardRepository();

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<double> getTodayScore() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('daily_scores')
          .select('true_score')
          .eq('user_id', _userId)
          .eq('date', today)
          .maybeSingle();

      if (response != null) {
        return (response['true_score'] as num).toDouble();
      }
    } catch (_) {}
    return 0.0;
  }

  Future<int> getCurrentStreak() async {
    try {
      final response = await _supabase
          .from('user_profiles')
          .select('current_streak')
          .eq('id', _userId)
          .single();
      return response['current_streak'] ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<int> getFocusMinutesToday() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('pomodoro_sessions')
          .select('duration_minutes')
          .eq('user_id', _userId)
          .gte('started_at', '${today}T00:00:00')
          .not('completed_at', 'is', null);

      int total = 0;
      for (final row in (response as List)) {
        total += (row['duration_minutes'] as num).toInt();
      }
      return total;
    } catch (_) {
      return 0;
    }
  }

  Future<int> getCompletedGoalsToday() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('goals')
          .select('id')
          .eq('user_id', _userId)
          .eq('date', today)
          .eq('is_completed', true)
          .isFilter('deleted_at', null);
      return (response as List).length;
    } catch (_) {
      return 0;
    }
  }

  Future<int> getTotalGoalsToday() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('goals')
          .select('id')
          .eq('user_id', _userId)
          .eq('date', today)
          .isFilter('deleted_at', null);
      return (response as List).length;
    } catch (_) {
      return 0;
    }
  }
}
