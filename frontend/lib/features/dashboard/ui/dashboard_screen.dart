import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../scores/ui/widgets/true_score_card.dart';
import '../../quick_capture/ui/quick_capture_sheet.dart';
import 'widgets/momentum_bar.dart';
import 'widgets/seven_day_strip.dart';
import 'widgets/streak_shield_widget.dart';
import 'widgets/subject_balance_ring.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => QuickCaptureSheet.show(context),
        backgroundColor: AppColors.primary,
        elevation: 4,
        child: const Icon(Icons.bolt_rounded, size: 26),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: AppColors.scoreRed, size: 48),
                  const SizedBox(height: 16),
                  Text(msg, style: const TextStyle(color: AppColors.scoreRed)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<DashboardCubit>().loadDashboard(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            loaded: (
              todayScore,
              isActiveDay,
              isStrongDay,
              currentStreak,
              focusMinutesToday,
              last7Scores,
              completedBig3,
              totalBig3,
              pomodoroCount,
              taskCount,
              shieldCount,
              momentumPct,
              subjectDistribution,
            ) {
              return RefreshIndicator(
                onRefresh: () => context.read<DashboardCubit>().loadDashboard(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Momentum Bar
                      MomentumBar(percentage: momentumPct),
                      
                      const SizedBox(height: 24),

                      // 2. Greeting Header
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_greeting()} 👋',
                                style: AppTextStyles.h1.copyWith(fontSize: 26),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _motivationalText(todayScore, isActiveDay),
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
                            onPressed: () => context.read<DashboardCubit>().loadDashboard(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // 3. True Score Card
                      TrueScoreCard(
                        score: todayScore,
                        isActiveDay: isActiveDay,
                        isStrongDay: isStrongDay,
                      ),

                      const SizedBox(height: 16),

                      // 4. Streak & Shield Widget
                      StreakShieldWidget(
                        streak: currentStreak,
                        shields: shieldCount,
                        isActiveToday: isActiveDay,
                      ),

                      const SizedBox(height: 16),

                      // 5. 7-Day Score Strip + Subject Ring side by side on larger screens
                      SevenDayStrip(scores: last7Scores),

                      const SizedBox(height: 16),

                      // 6. Subject Balance Ring
                      SubjectBalanceRing(distribution: subjectDistribution),

                      const SizedBox(height: 16),

                      // 7. Quick Stats Row
                      Row(
                        children: [
                          Expanded(child: _buildMiniStatCard(
                            '🎯 Big 3', '$completedBig3/$totalBig3',
                            completedBig3 >= 3 ? AppColors.scoreGreen : AppColors.scoreAmber,
                          )),
                          const SizedBox(width: 12),
                          Expanded(child: _buildMiniStatCard(
                            '🍅 Pomodoros', '$pomodoroCount',
                            pomodoroCount >= 3 ? AppColors.scoreGreen : AppColors.primary,
                          )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildMiniStatCard(
                            '⏱ Focus', '$focusMinutesToday min',
                            AppColors.primary,
                          )),
                          const SizedBox(width: 12),
                          Expanded(child: _buildMiniStatCard(
                            '✅ Tasks', '$taskCount done',
                            taskCount > 0 ? AppColors.scoreTeal : Colors.grey,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _motivationalText(double score, bool isActive) {
    if (score >= 85) return "You're crushing it today!";
    if (score >= 70) return "Great progress, keep pushing!";
    if (score >= 50) return "Solid start, you can do more!";
    if (isActive) return "You've started — now finish strong.";
    return "Your day is waiting. Let's go.";
  }

  Widget _buildMiniStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(
            color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
