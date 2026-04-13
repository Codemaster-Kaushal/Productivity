// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PomodoroSessionImpl _$$PomodoroSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$PomodoroSessionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      goalId: json['goalId'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      isCompleted: json['isCompleted'] as bool,
      date: json['date'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$PomodoroSessionImplToJson(
        _$PomodoroSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'goalId': instance.goalId,
      'durationMinutes': instance.durationMinutes,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'date': instance.date,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };
