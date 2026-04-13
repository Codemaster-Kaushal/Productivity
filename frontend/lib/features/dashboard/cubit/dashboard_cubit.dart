import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'dashboard_state.dart';
import '../data/dashboard_repository.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _repository;

  DashboardCubit(this._repository) : super(const DashboardState.initial()) {
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    emit(const DashboardState.loading());
    try {
      final score = await _repository.getTodayScore();
      final streak = await _repository.getCurrentStreak();
      final focusMinutes = await _repository.getFocusMinutesToday();
      final completedGoals = await _repository.getCompletedGoalsToday();

      emit(DashboardState.loaded(
        todayScore: score,
        isActiveDay: completedGoals > 0,
        isStrongDay: score >= 80,
        currentStreak: streak,
        focusMinutesToday: focusMinutes,
      ));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const DashboardState.error('Failed to load dashboard.'));
    }
  }
}
