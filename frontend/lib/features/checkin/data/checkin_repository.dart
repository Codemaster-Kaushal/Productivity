import 'package:supabase_flutter/supabase_flutter.dart';

class CheckinRepository {
  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<void> saveCheckin({
    required int energy,
    required int focus,
    required int mood,
    String? note,
  }) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final content = note?.isNotEmpty == true
        ? note!
        : 'Check-in: Energy $energy, Focus $focus, Mood $mood';

    await _supabase.from('journal_entries').upsert(
      {
        'user_id': _userId,
        'date': today,
        'content': content,
        'energy': energy,
        'focus': focus,
        'mood': mood,
        'entry_type': 'checkin',
      },
      onConflict: 'user_id,date',
      ignoreDuplicates: false,
    );
  }

  Future<Map<String, dynamic>?> getTodayCheckin() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    try {
      final response = await _supabase
          .from('journal_entries')
          .select()
          .eq('user_id', _userId)
          .eq('date', today)
          .eq('entry_type', 'checkin')
          .maybeSingle();
      return response;
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRecentCheckins({int limit = 7}) async {
    try {
      final response = await _supabase
          .from('journal_entries')
          .select()
          .eq('user_id', _userId)
          .eq('entry_type', 'checkin')
          .order('date', ascending: false)
          .limit(limit);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }
}
