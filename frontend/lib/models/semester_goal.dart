import 'package:freezed_annotation/freezed_annotation.dart';

part 'semester_goal.freezed.dart';
part 'semester_goal.g.dart';

@freezed
class SemesterGoal with _$SemesterGoal {
  const SemesterGoal._();
  const factory SemesterGoal({
    required String id,
    required String userId,
    required String subject,
    required String title,
    required String semesterLabel,
    required String startDate,
    required String endDate,
    @Default(true) bool isActive,
    required DateTime createdAt,
  }) = _SemesterGoal;

  factory SemesterGoal.fromJson(Map<String, dynamic> json) => _$SemesterGoalFromJson(json);
}
