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
    _authSubscription = _repository.authStateChanges.listen((data) {
      final user = data.session?.user;
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(const AuthState.error('Please enter your email and password.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      await _repository.signInWithEmail(email, password);
    } catch (e) {
      emit(AuthState.error(_friendlyError(e.toString())));
    }
  }

  Future<void> signUp(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(const AuthState.error('Please enter your email and password.'));
      return;
    }
    if (password.length < 6) {
      emit(const AuthState.error('Password must be at least 6 characters.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      await _repository.signUpWithEmail(email, password);
    } catch (e) {
      emit(AuthState.error(_friendlyError(e.toString())));
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    emit(const AuthState.unauthenticated());
  }

  String _friendlyError(String raw) {
    if (raw.contains('Invalid login credentials')) {
      return 'Incorrect email or password.';
    }
    if (raw.contains('User already registered')) {
      return 'An account with this email already exists.';
    }
    if (raw.contains('Email not confirmed')) {
      return 'Please confirm your email before signing in.';
    }
    return 'Something went wrong: $raw';
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
