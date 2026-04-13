import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pomodoro_cubit.dart';
import '../cubit/pomodoro_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../audio/ui/audio_player_widget.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Timer', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Timer Section
            BlocBuilder<PomodoroCubit, PomodoroState>(
              builder: (context, state) {
                return state.when(
                  initial: () => _buildStartView(context),
                  running: (remaining, total) =>
                      _buildTimerView(context, remaining, total, true),
                  paused: (remaining, total) =>
                      _buildTimerView(context, remaining, total, false),
                  completed: (session) => Column(
                    children: [
                      const SizedBox(height: 40),
                      const Icon(Icons.check_circle,
                          color: AppColors.scoreGreen, size: 80),
                      const SizedBox(height: 24),
                      const Text('Session Completed!',
                          style: AppTextStyles.h2),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<PomodoroCubit>().cancelTimer(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Start Another',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  error: (msg) => Text(msg,
                      style: const TextStyle(color: AppColors.scoreRed)),
                );
              },
            ),

            const SizedBox(height: 32),

            // Focus Music Player
            const AudioPlayerWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildStartView(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
            border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 3),
          ),
          child: const Center(
            child: Text('25:00', style: AppTextStyles.scoreLarge),
          ),
        ),
        const SizedBox(height: 40),
        // Duration chips
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [15, 25, 45, 60].map((min) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ActionChip(
                label: Text('$min min',
                    style: TextStyle(
                        color: min == 25
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontSize: 13)),
                backgroundColor:
                    min == 25 ? AppColors.primary : AppColors.surface,
                onPressed: () =>
                    context.read<PomodoroCubit>().startTimer(min),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () =>
              context.read<PomodoroCubit>().startTimer(25),
          child: const Text('Start Focus',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildTimerView(
      BuildContext context, int remaining, int total, bool isRunning) {
    final minutes = (remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (remaining % 60).toString().padLeft(2, '0');

    return Column(
      children: [
        const SizedBox(height: 40),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 220,
              child: CircularProgressIndicator(
                value: remaining / total,
                strokeWidth: 10,
                color: AppColors.primary,
                backgroundColor: AppColors.surface,
              ),
            ),
            Text('$minutes:$seconds', style: AppTextStyles.scoreLarge),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isRunning)
              IconButton(
                iconSize: 48,
                color: AppColors.scoreAmber,
                icon: const Icon(Icons.pause_circle_filled),
                onPressed: () =>
                    context.read<PomodoroCubit>().pauseTimer(),
              )
            else
              IconButton(
                iconSize: 48,
                color: AppColors.scoreGreen,
                icon: const Icon(Icons.play_circle_fill),
                onPressed: () =>
                    context.read<PomodoroCubit>().resumeTimer(),
              ),
            const SizedBox(width: 32),
            IconButton(
              iconSize: 48,
              color: AppColors.scoreRed,
              icon: const Icon(Icons.stop_circle),
              onPressed: () =>
                  context.read<PomodoroCubit>().cancelTimer(),
            ),
          ],
        ),
      ],
    );
  }
}
