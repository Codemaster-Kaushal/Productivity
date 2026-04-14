import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'quick_capture_state.dart';
import '../data/quick_capture_repository.dart';

class QuickCaptureCubit extends Cubit<QuickCaptureState> {
  final QuickCaptureRepository _repository;

  QuickCaptureCubit(this._repository) : super(const QuickCaptureState.idle());

  Future<void> capture(String input) async {
    if (input.trim().isEmpty) return;

    emit(const QuickCaptureState.parsing());
    try {
      final parsed = _repository.parseInput(input);
      await _repository.saveCapture(parsed);
      emit(QuickCaptureState.saved(parsed.title, parsed.type));
      
      // Auto-reset after 2 seconds
      await Future.delayed(Duration(seconds: 2));
      if (!isClosed) emit(const QuickCaptureState.idle());
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const QuickCaptureState.error('Failed to save. Try again.'));
    }
  }

  void reset() {
    emit(const QuickCaptureState.idle());
  }
}
