import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pomodoro_cubit.dart';
import '../cubit/pomodoro_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Focus Timer', style: AppTextStyles.h2), backgroundColor: AppColors.background, elevation: 0),
      body: BlocBuilder<PomodoroCubit, PomodoroState>(
        builder: (context, state) {
          return Center(
            child: state.when(
              initial: () => ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.all(24)),
                onPressed: () => context.read<PomodoroCubit>().startTimer(25),
                child: const Text('Start 25 min Focus', style: AppTextStyles.h2),
              ),
              running: (remaining, total) => _buildTimerView(context, remaining, total, true),
              paused: (remaining, total) => _buildTimerView(context, remaining, total, false),
              completed: (session) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: AppColors.scoreGreen, size: 80),
                  const SizedBox(height: 24),
                  const Text('Session Completed!', style: AppTextStyles.h2),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () => context.read<PomodoroCubit>().cancelTimer(),
                    child: const Text('Start Another'),
                  )
                ],
              ),
              error: (msg) => Text(msg, style: const TextStyle(color: AppColors.scoreRed)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimerView(BuildContext context, int remaining, int total, bool isRunning) {
    final minutes = (remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (remaining % 60).toString().padLeft(2, '0');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: CircularProgressIndicator(
                value: remaining / total,
                strokeWidth: 12,
                color: AppColors.primary,
                backgroundColor: AppColors.surface,
              ),
            ),
            Text('$minutes:$seconds', style: AppTextStyles.scoreLarge),
          ],
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isRunning)
              IconButton(
                iconSize: 48,
                color: AppColors.scoreAmber,
                icon: const Icon(Icons.pause_circle_filled),
                onPressed: () => context.read<PomodoroCubit>().pauseTimer(),
              )
            else
              IconButton(
                iconSize: 48,
                color: AppColors.scoreGreen,
                icon: const Icon(Icons.play_circle_fill),
                onPressed: () => context.read<PomodoroCubit>().resumeTimer(),
              ),
            const SizedBox(width: 32),
            IconButton(
              iconSize: 48,
              color: AppColors.scoreRed,
              icon: const Icon(Icons.stop_circle),
              onPressed: () => context.read<PomodoroCubit>().cancelTimer(),
            ),
          ],
        )
      ],
    );
  }
}
