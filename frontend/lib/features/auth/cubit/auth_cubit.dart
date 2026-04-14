import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/auth_repository.dart';
part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState.initial()) {
    _checkCurrentUser();
    _listenToAuthChanges();
  }

  final AuthRepository _repository;
  StreamSubscription? _authSubscription;

  void _checkCurrentUser() {
    final user = _repository.getCurrentUser();
    if (user != null) {
      emit(AuthState.authenticated(user));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  void _listenToAuthChanges() {
    _authSubscription = _repository.authStateChanges.listen((data) async {
      final session = data.session;
      final user = session?.user;

      if (user != null && session != null) {
        // Save provider tokens whenever auth state changes
        await _repository.handleAuthCallback(session);
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthState.loading());
    try {
      await _repository.signInWithGoogle();
      // State update comes via stream listener above
    } catch (e) {
      emit(const AuthState.error('Sign in failed. Please try again.'));
    }
  }

  Future<void> signUp(String email, String password) async {
    // Email/password sign‑up is deprecated; inform the user.
    emit(const AuthState.error('Sign‑up via email/password is no longer supported. Please use Google sign‑in.'));
  }

  Future<void> signOut() async {
    await _repository.signOut();
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
