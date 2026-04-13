import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/pomodoro_session.dart';

part 'pomodoro_state.freezed.dart';

@freezed
class PomodoroState with _$PomodoroState {
  const factory PomodoroState.initial() = _Initial;
  const factory PomodoroState.running({
    required int secondsRemaining,
    required int totalSeconds,
  }) = _Running;
  const factory PomodoroState.paused({
    required int secondsRemaining,
    required int totalSeconds,
  }) = _Paused;
  const factory PomodoroState.completed(PomodoroSession session) = _Completed;
  const factory PomodoroState.error(String message) = _Error;
}
