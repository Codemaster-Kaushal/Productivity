import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.loading() = _Loading;
  const factory DashboardState.loaded({
    required double todayScore,
    required bool isActiveDay,
    required bool isStrongDay,
    required int currentStreak,
    required int focusMinutesToday,
    @Default([]) List<double> last7Scores,
    @Default(0) int completedBig3,
    @Default(0) int totalBig3,
    @Default(0) int pomodoroCount,
    @Default(0) int taskCount,
    @Default(0) int shieldCount,
    @Default(0.0) double momentumPct,
    @Default({}) Map<String, int> subjectDistribution,
  }) = _Loaded;
  const factory DashboardState.error(String message) = _Error;
}
