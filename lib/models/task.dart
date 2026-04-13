import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const Task._();
  const factory Task({    required String id,
    required String userId,
    required String goalId,
    required String title,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
    DateTime? syncedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
