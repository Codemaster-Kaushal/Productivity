import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'goals_state.dart';
import '../data/goals_repository.dart';

class GoalsCubit extends Cubit<GoalsState> {
  final GoalsRepository _repository;

  GoalsCubit(this._repository) : super(const GoalsState.initial()) {
    loadTodayGoals();
  }

  Future<void> loadTodayGoals() async {
    emit(const GoalsState.loading());
    try {
      final goals = await _repository.getTodayGoals();
      emit(GoalsState.loaded(goals));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const GoalsState.error('Failed to load goals. Please try again.'));
    }
  }

  Future<void> createGoal(String title, String subject) async {
    try {
      await _repository.createGoal(title: title, subject: subject);
      await loadTodayGoals();
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
    }
  }

  Future<void> completeGoal(String goalId) async {
    try {
      await _repository.completeGoal(goalId);
      await loadTodayGoals();
    } catch (_) {}
  }

  Future<void> uncompleteGoal(String goalId) async {
    try {
      await _repository.uncompleteGoal(goalId);
      await loadTodayGoals();
    } catch (_) {}
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      await _repository.deleteGoal(goalId);
      await loadTodayGoals();
    } catch (_) {}
  }
}
