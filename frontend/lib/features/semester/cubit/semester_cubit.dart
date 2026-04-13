import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'semester_state.dart';
import '../data/semester_repository.dart';

class SemesterCubit extends Cubit<SemesterState> {
  final SemesterRepository _repository;

  SemesterCubit(this._repository) : super(const SemesterState.initial()) {
    loadGoals();
  }

  Future<void> loadGoals() async {
    emit(const SemesterState.loading());
    try {
      final goals = await _repository.getGoals();
      emit(SemesterState.loaded(goals));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const SemesterState.error('Failed to load semester goals.'));
    }
  }

  Future<void> createGoal({
    required String subject,
    required String title,
    required String semesterLabel,
    required String startDate,
    required String endDate,
  }) async {
    try {
      await _repository.createGoal(
        subject: subject,
        title: title,
        semesterLabel: semesterLabel,
        startDate: startDate,
        endDate: endDate,
      );
      await loadGoals();
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
    }
  }

  Future<void> toggleActive(String goalId, bool isActive) async {
    try {
      await _repository.toggleActive(goalId, isActive);
      await loadGoals();
    } catch (_) {}
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      await _repository.deleteGoal(goalId);
      await loadGoals();
    } catch (_) {}
  }
}
