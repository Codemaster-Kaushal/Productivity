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

  Future<int> getShieldCount() async {
    try {
      final response = await _supabase
          .from('user_profiles')
          .select('shield_count')
          .eq('id', _userId)
          .single();
      return response['shield_count'] ?? 0;
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

  Future<int> getPomodoroCountToday() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('pomodoro_sessions')
          .select('id')
          .eq('user_id', _userId)
          .gte('started_at', '${today}T00:00:00')
          .not('completed_at', 'is', null);
      return (response as List).length;
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

  Future<int> getCompletedTasksToday() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('tasks')
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

  Future<List<double>> getLast7Scores() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 6));
    final startDate = sevenDaysAgo.toIso8601String().split('T')[0];

    try {
      final response = await _supabase
          .from('daily_scores')
          .select('date, true_score')
          .eq('user_id', _userId)
          .gte('date', startDate)
          .order('date');

      // Build a 7-element list with -1 for missing days
      final Map<String, double> scoreMap = {};
      for (final row in (response as List)) {
        scoreMap[row['date']] = (row['true_score'] as num).toDouble();
      }

      final List<double> scores = [];
      for (int i = 0; i < 7; i++) {
        final date = sevenDaysAgo.add(Duration(days: i));
        final dateStr = date.toIso8601String().split('T')[0];
        scores.add(scoreMap[dateStr] ?? -1);
      }
      return scores;
    } catch (_) {
      return List.filled(7, -1);
    }
  }

  Future<Map<String, int>> getSubjectDistribution() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('goals')
          .select('subject')
          .eq('user_id', _userId)
          .eq('date', today)
          .isFilter('deleted_at', null);

      final Map<String, int> distribution = {};
      for (final row in (response as List)) {
        final subject = row['subject'] as String;
        distribution[subject] = (distribution[subject] ?? 0) + 1;
      }
      return distribution;
    } catch (_) {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getUpcomingDeadlines() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('user_id', _userId)
          .eq('is_completed', false)
          .isFilter('deleted_at', null)
          .not('due_date', 'is', null)
          .gte('due_date', today)
          .order('due_date')
          .limit(5);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }
}
