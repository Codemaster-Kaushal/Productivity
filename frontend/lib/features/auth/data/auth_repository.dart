import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase;
  AuthRepository(this._supabase);

  Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kIsWeb
          ? null // Supabase will redirect back to the current origin automatically
          : 'io.supabase.productivity://login-callback',
      scopes: [
        'openid',
        'email',
        'profile',
        'https://www.googleapis.com/auth/calendar.events',
        'https://www.googleapis.com/auth/fitness.activity.read',
        'https://www.googleapis.com/auth/tasks',
      ].join(' '),
      queryParams: {
        'access_type': 'offline',
        'prompt': 'consent',
      },
    );
  }

  Future<void> _saveProviderTokens(Session session) async {
    final providerToken = session.providerToken;
    final providerRefreshToken = session.providerRefreshToken;
    if (providerToken == null) return;

    try {
      await _supabase.from('user_profiles').update({
        'google_access_token': providerToken,
        'google_refresh_token': providerRefreshToken,
        'google_token_expires_at': DateTime.now()
            .add(const Duration(hours: 1))
            .toIso8601String(),
      }).eq('id', session.user.id);
    } catch (e) {
      debugPrint('Error saving provider tokens: $e');
    }
  }

  Future<void> handleAuthCallback(Session session) async {
    await _ensureUserProfile(session.user);
    await _saveProviderTokens(session);
  }

  Future<void> _ensureUserProfile(User user) async {
    final existing = await _supabase
        .from('user_profiles')
        .select('id')
        .eq('id', user.id)
        .maybeSingle();

    if (existing == null) {
      await _supabase.from('user_profiles').insert({
        'id': user.id,
        'display_name': user.userMetadata?['full_name'] ?? 'Student',
      });
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? getCurrentUser() => _supabase.auth.currentUser;

  Stream<AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;
}
