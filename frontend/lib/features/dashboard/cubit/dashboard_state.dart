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
  }) = _Loaded;
  const factory DashboardState.error(String message) = _Error;
}
