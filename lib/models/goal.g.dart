// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoalImpl _$$GoalImplFromJson(Map<String, dynamic> json) => _$GoalImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      subject: json['subject'] as String,
      date: json['date'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      semesterGoalId: json['semesterGoalId'] as String?,
      focusWindowStart: json['focusWindowStart'] as String?,
      focusWindowEnd: json['focusWindowEnd'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$GoalImplToJson(_$GoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'subject': instance.subject,
      'date': instance.date,
      'isCompleted': instance.isCompleted,
      'semesterGoalId': instance.semesterGoalId,
      'focusWindowStart': instance.focusWindowStart,
      'focusWindowEnd': instance.focusWindowEnd,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };
