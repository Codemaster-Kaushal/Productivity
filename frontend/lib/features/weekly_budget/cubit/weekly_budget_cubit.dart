import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'weekly_budget_state.dart';
import '../data/weekly_budget_repository.dart';

class WeeklyBudgetCubit extends Cubit<WeeklyBudgetState> {
  final WeeklyBudgetRepository _repository;

  WeeklyBudgetCubit(this._repository) : super(const WeeklyBudgetState.initial()) {
    loadBudget();
  }

  Future<void> loadBudget() async {
    emit(const WeeklyBudgetState.loading());
    try {
      final targets = await _repository.getWeeklyTargets();
      final actuals = await _repository.getActualSessionsThisWeek();

      final budgets = targets.map((t) {
        final subject = t['subject'] as String;
        final target = t['target_sessions'] as int;
        final actual = actuals[subject] ?? 0;
        return SubjectBudget(
          subject: subject,
          targetSessions: target,
          actualSessions: actual,
        );
      }).toList();

      // Also add subjects with actuals but no target
      for (final entry in actuals.entries) {
        if (!budgets.any((b) => b.subject == entry.key)) {
          budgets.add(SubjectBudget(
            subject: entry.key,
            targetSessions: 0,
            actualSessions: entry.value,
          ));
        }
      }

      emit(WeeklyBudgetState.loaded(budgets: budgets));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const WeeklyBudgetState.error('Failed to load budget.'));
    }
  }

  Future<void> setTarget(String subject, int sessions) async {
    try {
      await _repository.setTarget(subject, sessions);
      await loadBudget();
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
    }
  }
}
