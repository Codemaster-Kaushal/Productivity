import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'journal_state.dart';
import '../data/journal_repository.dart';

class JournalCubit extends Cubit<JournalState> {
  final JournalRepository _repository;

  JournalCubit(this._repository) : super(const JournalState.initial()) {
    loadEntries();
  }

  Future<void> loadEntries() async {
    emit(const JournalState.loading());
    try {
      final entries = await _repository.getEntries();
      emit(JournalState.loaded(entries));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const JournalState.error('Failed to load journal entries.'));
    }
  }

  Future<void> saveEntry(String content, int moodScore) async {
    emit(const JournalState.loading());
    try {
      await _repository.saveEntry(content, moodScore);
      final entries = await _repository.getEntries();
      emit(JournalState.loaded(entries));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const JournalState.error('Failed to save journal.'));
    }
  }
}
