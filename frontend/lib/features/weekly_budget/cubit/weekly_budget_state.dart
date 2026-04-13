import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_budget_state.freezed.dart';

@freezed
class WeeklyBudgetState with _$WeeklyBudgetState {
  const factory WeeklyBudgetState.initial() = _Initial;
  const factory WeeklyBudgetState.loading() = _Loading;
  const factory WeeklyBudgetState.loaded({
    required List<SubjectBudget> budgets,
  }) = _Loaded;
  const factory WeeklyBudgetState.error(String message) = _Error;
}

class SubjectBudget {
  final String subject;
  final int targetSessions;
  final int actualSessions;

  SubjectBudget({
    required this.subject,
    required this.targetSessions,
    required this.actualSessions,
  });

  double get completionPct =>
      targetSessions > 0 ? (actualSessions / targetSessions * 100).clamp(0, 100) : 0;
}
