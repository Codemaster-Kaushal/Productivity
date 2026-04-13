import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/semester_goal.dart';

class SemesterRepository {
  SemesterRepository();

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<List<SemesterGoal>> getGoals() async {
    final response = await _supabase
        .from('semester_goals')
        .select()
        .eq('user_id', _userId)
        .order('created_at', ascending: false);

    return (response as List).map((row) => SemesterGoal(
      id: row['id'],
      userId: row['user_id'],
      subject: row['subject'],
      title: row['title'],
      semesterLabel: row['semester_label'],
      startDate: row['start_date'],
      endDate: row['end_date'],
      isActive: row['is_active'] ?? true,
      createdAt: DateTime.parse(row['created_at']),
    )).toList();
  }

  Future<void> createGoal({
    required String subject,
    required String title,
    required String semesterLabel,
    required String startDate,
    required String endDate,
  }) async {
    await _supabase.from('semester_goals').insert({
      'user_id': _userId,
      'subject': subject,
      'title': title,
      'semester_label': semesterLabel,
      'start_date': startDate,
      'end_date': endDate,
      'is_active': true,
    });
  }

  Future<void> toggleActive(String goalId, bool isActive) async {
    await _supabase
        .from('semester_goals')
        .update({'is_active': isActive})
        .eq('id', goalId);
  }

  Future<void> deleteGoal(String goalId) async {
    await _supabase
        .from('semester_goals')
        .delete()
        .eq('id', goalId);
  }
}
