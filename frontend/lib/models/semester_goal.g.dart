// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SemesterGoalImpl _$$SemesterGoalImplFromJson(Map<String, dynamic> json) =>
    _$SemesterGoalImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      subject: json['subject'] as String,
      title: json['title'] as String,
      semesterLabel: json['semesterLabel'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SemesterGoalImplToJson(_$SemesterGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'subject': instance.subject,
      'title': instance.title,
      'semesterLabel': instance.semesterLabel,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };
