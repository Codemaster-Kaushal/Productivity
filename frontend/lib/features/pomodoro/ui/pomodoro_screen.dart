import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/pomodoro_cubit.dart';
import '../cubit/pomodoro_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/aurora_theme.dart';
import '../../audio/ui/audio_player_widget.dart';

class PomodoroScreen extends StatelessWidget {
  PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            AuroraTheme.sectionHeader('Aurora Focus Timer'),
            SizedBox(height: 32),

            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 500;
                
                final timerSection = _buildTimerSection(context);
                final rightPanel = Column(
                  children: [
                    AudioPlayerWidget(),
                    SizedBox(height: 24),
                    _buildConsistencyCard(),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: timerSection),
                      SizedBox(width: 32),
                      Expanded(flex: 2, child: rightPanel),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      timerSection,
                      SizedBox(height: 48),
                      rightPanel,
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerSection(BuildContext context) {
    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: BlocBuilder<PomodoroCubit, PomodoroState>(
        builder: (context, state) {
          return state.when(
            initial: () => _buildStartView(context),
            running: (remaining, total) => _buildTimerView(context, remaining, total, true),
            paused: (remaining, total) => _buildTimerView(context, remaining, total, false),
            completed: (session) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Icon(Icons.check_circle_outline, color: AppColors.primary, size: 80),
                SizedBox(height: 24),
                Text('Session Completed', style: AppTextStyles.h2),
                SizedBox(height: 40),
                AuroraTheme.gradientButton(
                  text: 'Start Another',
                  onPressed: () => context.read<PomodoroCubit>().cancelTimer(),
                ),
              ],
            ),
            error: (msg) => Text(msg, style: TextStyle(color: AppColors.scoreRed)),
          );
        },
      ),
    );
  }

  Widget _buildStartView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => context.read<PomodoroCubit>().startTimer(25),
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '25:00',
                  style: GoogleFonts.inter(fontSize: 64, fontWeight: FontWeight.w800, color: Colors.white, height: 1.0),
                ),
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _durationChip(context, 25, true),
            SizedBox(width: 12),
            _durationChip(context, 45, false),
            SizedBox(width: 12),
            _durationChip(context, 60, false),
          ],
        )
      ],
    );
  }

  Widget _durationChip(BuildContext context, int min, bool active) {
    return GestureDetector(
      onTap: () => context.read<PomodoroCubit>().startTimer(min),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.surfaceBorder : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.surfaceBorder),
        ),
        child: Text(
          '$min MIN',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: active ? AppColors.primaryLight : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTimerView(BuildContext context, int remaining, int total, bool isRunning) {
    final minutes = (remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (remaining % 60).toString().padLeft(2, '0');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 240,
              height: 240,
              child: CircularProgressIndicator(
                value: remaining / total,
                strokeWidth: 12,
                color: AppColors.primary,
                backgroundColor: AppColors.surfaceBorder,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$minutes:$seconds', style: GoogleFonts.inter(fontSize: 56, fontWeight: FontWeight.w800, color: AppColors.textPrimary, height: 1.0)),
              ],
            ),
          ],
        ),
        SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isRunning)
              _controlBtn(Icons.pause, () => context.read<PomodoroCubit>().pauseTimer())
            else
              _controlBtn(Icons.play_arrow, () => context.read<PomodoroCubit>().resumeTimer()),
            SizedBox(width: 24),
            _controlBtn(Icons.stop, () => context.read<PomodoroCubit>().cancelTimer(), isSecondary: true),
          ],
        ),
      ],
    );
  }

  Widget _controlBtn(IconData icon, VoidCallback onTap, {bool isSecondary = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSecondary ? AppColors.surfaceBorder : AppColors.surfaceLight,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 28),
      ),
    );
  }

  Widget _buildConsistencyCard() {
    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Streak', style: AppTextStyles.h3),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('12', style: AppTextStyles.scoreLarge),
              SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('Focus Hours this week', style: AppTextStyles.caption),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Placeholder for the bar chart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (i) {
              final isToday = i == 3;
              return Container(
                width: 24,
                height: [20.0, 30.0, 40.0, 80.0, 15.0, 25.0, 50.0][i],
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primary : AppColors.surfaceBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
