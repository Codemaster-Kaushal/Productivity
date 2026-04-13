import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/goal.dart';

class GoalsRepository {
  GoalsRepository();

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<List<Goal>> getTodayGoals() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await _supabase
        .from('goals')
        .select()
        .eq('user_id', _userId)
        .eq('date', today)
        .isFilter('deleted_at', null)
        .order('created_at');

    return (response as List).map((row) => Goal(
      id: row['id'],
      userId: row['user_id'],
      title: row['title'],
      subject: row['subject'],
      date: row['date'],
      isCompleted: row['is_completed'] ?? false,
      semesterGoalId: row['semester_goal_id'],
      focusWindowStart: row['focus_window_start'],
      focusWindowEnd: row['focus_window_end'],
      createdAt: DateTime.parse(row['created_at']),
    )).toList();
  }

  Future<void> createGoal({
    required String title,
    required String subject,
    String? semesterGoalId,
  }) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    await _supabase.from('goals').insert({
      'user_id': _userId,
      'title': title,
      'subject': subject,
      'date': today,
      'is_completed': false,
      if (semesterGoalId != null) 'semester_goal_id': semesterGoalId,
    });
  }

  Future<void> completeGoal(String goalId) async {
    await _supabase
        .from('goals')
        .update({'is_completed': true})
        .eq('id', goalId);
  }

  Future<void> uncompleteGoal(String goalId) async {
    await _supabase
        .from('goals')
        .update({'is_completed': false})
        .eq('id', goalId);
  }

  Future<void> deleteGoal(String goalId) async {
    await _supabase
        .from('goals')
        .update({'deleted_at': DateTime.now().toIso8601String()})
        .eq('id', goalId);
  }
}
