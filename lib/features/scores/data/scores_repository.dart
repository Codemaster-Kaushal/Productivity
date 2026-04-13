import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/daily_score.dart';

class ScoresRepository {
  ScoresRepository();

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<List<DailyScore>> getScores() async {
    final response = await _supabase
        .from('daily_scores')
        .select()
        .eq('user_id', _userId)
        .order('date', ascending: false)
        .limit(30);

    return (response as List).map((row) => DailyScore(
      id: row['id'],
      userId: row['user_id'],
      date: row['date'],
      score: (row['true_score'] as num).toDouble(),
      steps: row['active_points'] ?? 0,
      isActiveDay: (row['true_score'] as num) > 20,
      isStrongDay: row['focus_badge_earned'] ?? false,
      currentStreak: 0,
      createdAt: DateTime.now(),
    )).toList();
  }
}
