import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pomodoro_state.dart';
import '../data/pomodoro_repository.dart';
import '../../../models/pomodoro_session.dart';

class PomodoroCubit extends Cubit<PomodoroState> {
  final PomodoroRepository _repository;
  Timer? _timer;

  PomodoroCubit(this._repository) : super(const PomodoroState.initial());

  void startTimer(int minutes) {
    emit(PomodoroState.running(secondsRemaining: minutes * 60, totalSeconds: minutes * 60));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.maybeWhen(
        running: (secondsRemaining, total) {
          if (secondsRemaining > 1) {
            emit(PomodoroState.running(secondsRemaining: secondsRemaining - 1, totalSeconds: total));
          } else {
            _timer?.cancel();
            _completeSession(total ~/ 60);
          }
        },
        orElse: () => _timer?.cancel(),
      );
    });
  }

  void pauseTimer() {
    state.maybeWhen(
      running: (remaining, total) {
        _timer?.cancel();
        emit(PomodoroState.paused(secondsRemaining: remaining, totalSeconds: total));
      },
      orElse: () {},
    );
  }

  void resumeTimer() {
    state.maybeWhen(
      paused: (remaining, total) {
        emit(PomodoroState.running(secondsRemaining: remaining, totalSeconds: total));
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          state.maybeWhen(
            running: (secondsRemaining, t) {
              if (secondsRemaining > 1) {
                emit(PomodoroState.running(secondsRemaining: secondsRemaining - 1, totalSeconds: t));
              } else {
                _timer?.cancel();
                _completeSession(t ~/ 60);
              }
            },
            orElse: () => _timer?.cancel(),
          );
        });
      },
      orElse: () {},
    );
  }

  void cancelTimer() {
    _timer?.cancel();
    emit(const PomodoroState.initial());
  }

  Future<void> _completeSession(int minutesLoaded) async {
    final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
    final session = PomodoroSession(
      id: const Uuid().v4(),
      userId: userId,
      goalId: 'general',
      durationMinutes: minutesLoaded,
      startTime: DateTime.now().subtract(Duration(minutes: minutesLoaded)),
      endTime: DateTime.now(),
      isCompleted: true,
      date: DateTime.now().toIso8601String().split('T')[0],
      createdAt: DateTime.now(),
    );

    try {
      await _repository.saveSession(session);
    } catch (_) {
      // Silently fail — session still shown as completed locally
    }
    emit(PomodoroState.completed(session));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
