import 'dart:math';
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
      final results = await Future.wait([
        _repository.getTodayScore(),        // 0
        _repository.getCurrentStreak(),     // 1
        _repository.getFocusMinutesToday(), // 2
        _repository.getCompletedGoalsToday(), // 3
        _repository.getTotalGoalsToday(),   // 4
        _repository.getLast7Scores(),       // 5
        _repository.getPomodoroCountToday(), // 6
        _repository.getCompletedTasksToday(), // 7
        _repository.getShieldCount(),       // 8
        _repository.getSubjectDistribution(), // 9
      ]);

      final score = results[0] as double;
      final streak = results[1] as int;
      final focusMinutes = results[2] as int;
      final completedGoals = results[3] as int;
      final totalGoals = results[4] as int;
      final last7Scores = results[5] as List<double>;
      final pomodoroCount = results[6] as int;
      final taskCount = results[7] as int;
      final shieldCount = results[8] as int;
      final subjectDistribution = results[9] as Map<String, int>;

      // Momentum formula from PRD
      final momentumPct = min(
        100.0,
        (completedGoals * 30 + min(pomodoroCount * 10, 30) + min(taskCount * 5, 25)) / 85.0 * 100.0,
      );

      emit(DashboardState.loaded(
        todayScore: score,
        isActiveDay: completedGoals > 0,
        isStrongDay: score >= 80,
        currentStreak: streak,
        focusMinutesToday: focusMinutes,
        last7Scores: last7Scores,
        completedBig3: completedGoals,
        totalBig3: totalGoals,
        pomodoroCount: pomodoroCount,
        taskCount: taskCount,
        shieldCount: shieldCount,
        momentumPct: momentumPct,
        subjectDistribution: subjectDistribution,
      ));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const DashboardState.error('Failed to load dashboard.'));
    }
  }
}
