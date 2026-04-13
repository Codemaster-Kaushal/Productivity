import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendsRepository {
  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rng = Random();
    return List.generate(6, (_) => chars[rng.nextInt(chars.length)]).join();
  }

  Future<String> getOrCreateMyCode() async {
    try {
      final existing = await _supabase
          .from('public_profiles')
          .select('username_code')
          .eq('user_id', _userId)
          .maybeSingle();

      if (existing != null) return existing['username_code'];

      // Get display name
      final profile = await _supabase
          .from('user_profiles')
          .select('display_name')
          .eq('id', _userId)
          .single();

      final code = _generateCode();
      await _supabase.from('public_profiles').insert({
        'user_id': _userId,
        'username_code': code,
        'display_name': profile['display_name'] ?? 'Student',
        'current_streak': 0,
      });
      return code;
    } catch (_) {
      return '???';
    }
  }

  Future<void> addFriendByCode(String code) async {
    // Find the user with this code
    final target = await _supabase
        .from('public_profiles')
        .select('user_id')
        .eq('username_code', code.toUpperCase())
        .maybeSingle();

    if (target == null) throw Exception('Code not found');
    if (target['user_id'] == _userId) throw Exception('That\'s your own code!');

    await _supabase.from('friendships').upsert(
      {
        'requester_id': _userId,
        'addressee_id': target['user_id'],
        'status': 'accepted',
      },
      onConflict: 'requester_id,addressee_id',
    );
  }

  Future<List<Map<String, dynamic>>> getFriendsBoard() async {
    try {
      // Get all accepted friendships
      final friendships = await _supabase
          .from('friendships')
          .select('requester_id, addressee_id')
          .or('requester_id.eq.$_userId,addressee_id.eq.$_userId')
          .eq('status', 'accepted');

      final friendIds = <String>{};
      for (final f in (friendships as List)) {
        final req = f['requester_id'] as String;
        final addr = f['addressee_id'] as String;
        friendIds.add(req == _userId ? addr : req);
      }

      if (friendIds.isEmpty) return [];

      // Get their public profiles
      final profiles = await _supabase
          .from('public_profiles')
          .select('username_code, display_name, current_streak')
          .inFilter('user_id', friendIds.toList())
          .eq('is_public', true)
          .order('current_streak', ascending: false);

      return List<Map<String, dynamic>>.from(profiles);
    } catch (_) {
      return [];
    }
  }
}
