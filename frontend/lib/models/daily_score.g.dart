// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyScoreImpl _$$DailyScoreImplFromJson(Map<String, dynamic> json) =>
    _$DailyScoreImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      score: (json['score'] as num).toDouble(),
      steps: (json['steps'] as num).toInt(),
      isActiveDay: json['isActiveDay'] as bool,
      isStrongDay: json['isStrongDay'] as bool,
      currentStreak: (json['currentStreak'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$DailyScoreImplToJson(_$DailyScoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date,
      'score': instance.score,
      'steps': instance.steps,
      'isActiveDay': instance.isActiveDay,
      'isStrongDay': instance.isStrongDay,
      'currentStreak': instance.currentStreak,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };
