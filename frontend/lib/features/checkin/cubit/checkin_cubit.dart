import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'checkin_state.dart';
import '../data/checkin_repository.dart';

class CheckinCubit extends Cubit<CheckinState> {
  final CheckinRepository _repository;

  CheckinCubit(this._repository) : super(const CheckinState.initial());

  Future<void> saveCheckin({
    required int energy,
    required int focus,
    required int mood,
    String? note,
  }) async {
    emit(const CheckinState.saving());
    try {
      await _repository.saveCheckin(
        energy: energy,
        focus: focus,
        mood: mood,
        note: note,
      );
      emit(const CheckinState.saved());
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const CheckinState.error('Failed to save check-in.'));
    }
  }

  void reset() {
    emit(const CheckinState.initial());
  }
}
