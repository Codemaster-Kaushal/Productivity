import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'scores_state.dart';
import '../data/scores_repository.dart';
import '../../../models/daily_score.dart';

class ScoresCubit extends Cubit<ScoresState> {
  final ScoresRepository _repository;

  ScoresCubit(this._repository) : super(const ScoresState.initial()) {
    loadScores();
  }

  Future<void> loadScores() async {
    emit(const ScoresState.loading());
    try {
      final scores = await _repository.getScores();
      scores.sort((a, b) => b.date.compareTo(a.date));
      
      final today = DateTime.now().toIso8601String().split('T')[0];
      final todayScore = scores.firstWhere((s) => s.date == today, orElse: () => _emptyScore(today));
      
      emit(ScoresState.loaded(todayScore: todayScore, history: scores));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const ScoresState.error('Failed to load scores.'));
    }
  }

  DailyScore _emptyScore(String date) {
    return DailyScore(id: 'temp', userId: '', date: date, score: 0, steps: 0, isActiveDay: false, isStrongDay: false, currentStreak: 0, createdAt: DateTime.now());
  }
}
