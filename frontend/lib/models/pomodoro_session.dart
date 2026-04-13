import 'package:freezed_annotation/freezed_annotation.dart';

part 'pomodoro_session.freezed.dart';
part 'pomodoro_session.g.dart';

@freezed
class PomodoroSession with _$PomodoroSession {
  const PomodoroSession._();
  const factory PomodoroSession({    required String id,
    required String userId,
    required String goalId,
    required int durationMinutes,
    required DateTime startTime,
    DateTime? endTime,
    required bool isCompleted,
    required String date,
    required DateTime createdAt,
    DateTime? syncedAt,
  }) = _PomodoroSession;

  factory PomodoroSession.fromJson(Map<String, dynamic> json) => _$PomodoroSessionFromJson(json);
}
