import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_score.freezed.dart';
part 'daily_score.g.dart';

@freezed
class DailyScore with _$DailyScore {
  const DailyScore._();
  const factory DailyScore({    required String id,
    required String userId,
    required String date,
    required double score,
    required int steps,
    required bool isActiveDay,
    required bool isStrongDay,
    required int currentStreak,
    required DateTime createdAt,
    DateTime? syncedAt,
  }) = _DailyScore;

  factory DailyScore.fromJson(Map<String, dynamic> json) => _$DailyScoreFromJson(json);
}
