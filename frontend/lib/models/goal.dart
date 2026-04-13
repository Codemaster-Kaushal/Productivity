import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

@freezed
class Goal with _$Goal {
  const Goal._();
  const factory Goal({    required String id,
    required String userId,
    required String title,
    required String subject,
    required String date,
    @Default(false) bool isCompleted,
    String? semesterGoalId,
    String? focusWindowStart,
    String? focusWindowEnd,
    required DateTime createdAt,
    DateTime? syncedAt,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}
