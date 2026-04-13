import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/journal_entry.dart';

class JournalRepository {
  JournalRepository();

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<List<JournalEntry>> getEntries() async {
    final response = await _supabase
        .from('journal_entries')
        .select()
        .eq('user_id', _userId)
        .order('date', ascending: false)
        .limit(30);

    return (response as List).map((row) => JournalEntry(
      id: row['id'],
      userId: row['user_id'],
      content: row['content'],
      moodScore: 5, // journal_entries table doesn't have mood_score column, default to 5
      date: row['date'],
      createdAt: DateTime.parse(row['created_at']),
    )).toList();
  }

  Future<void> saveEntry(String content, int moodScore) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    await _supabase.from('journal_entries').insert({
      'user_id': _userId,
      'date': today,
      'content': content,
    });
  }
}
