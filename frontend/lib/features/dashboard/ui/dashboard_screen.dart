import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/aurora_theme.dart';
import 'widgets/momentum_bar.dart';
import 'widgets/subject_balance_ring.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'MORNING';
    if (hour < 17) return 'AFTERNOON';
    return 'EVENING';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
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
                AuroraTheme.outlinedButton(
                  text: 'Retry',
                  onPressed: () => context.read<DashboardCubit>().loadDashboard(),
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
              color: AppColors.primary,
              backgroundColor: AppColors.surfaceBorder,
              onRefresh: () => context.read<DashboardCubit>().loadDashboard(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Aurora Header ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_greeting()}, SYNCED USER',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'The universe is in focus.',
                                style: AppTextStyles.h1,
                              ),
                            ],
                          ),
                        ),
                        AuroraTheme.statusTag(
                          momentumPct > 0.7 ? 'Momentum: High' : 'Momentum: Avg',
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // ── Aurora True Score & Metrics Row ──
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Score Card
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: AuroraTheme.cardGradient,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('True Score', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                Text('Composite productivity index', style: AppTextStyles.caption),
                                const SizedBox(height: 24),
                                Center(
                                  child: Text(
                                    todayScore.toInt().toString(),
                                    style: AppTextStyles.scoreHero,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.auto_graph, color: AppColors.primary, size: 14),
                                      const SizedBox(width: 4),
                                      Text('+0% FROM YESTERDAY', style: AppTextStyles.label.copyWith(color: AppColors.primary)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AuroraTheme.gradientButton(
                                        text: 'Deep Work',
                                        height: 40,
                                        onPressed: () {}, // Handled by Quick Capture for now or Pomodoro
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: AuroraTheme.outlinedButton(
                                        text: 'View Insights',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Right Side Streak/Shield Cards
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: AuroraTheme.card,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.local_fire_department, color: AppColors.primary, size: 18),
                                        Text('FOCUS STREAK', style: AppTextStyles.label),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text('$currentStreak Days', style: AppTextStyles.h2),
                                    const SizedBox(height: 12),
                                    LinearProgressIndicator(
                                      value: 1.0,
                                      backgroundColor: AppColors.surfaceBorder,
                                      color: AppColors.primary,
                                      minHeight: 4,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: AuroraTheme.cardElevated,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.shield_outlined, color: AppColors.textSecondary, size: 18),
                                        Text('DISTRACTION SHIELD', style: AppTextStyles.label),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(isActiveDay ? 'Active' : 'Inactive', style: AppTextStyles.h2),
                                    const SizedBox(height: 4),
                                    Text('$shieldCount blocks prevented today', style: AppTextStyles.caption),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Weekly Momentum Bar ──
                    AuroraTheme.sectionHeader('Weekly Momentum', trailing: 'MON - SUN'),
                    const SizedBox(height: 16),
                    MomentumBar(percentage: momentumPct), // Needs UI update internally later
                    const SizedBox(height: 32),

                    // ── Aurora Stats Grid ──
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subject Balance Ring
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 220,
                            padding: const EdgeInsets.all(16),
                            decoration: AuroraTheme.card,
                            child: SubjectBalanceRing(distribution: subjectDistribution),
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // 2x2 Stats Grid
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: _buildAuroraStatCard('timer_outlined', '${(focusMinutesToday / 60.0).toStringAsFixed(1)}h', 'DEEP WORK AVG')),
                                  const SizedBox(width: 16),
                                  Expanded(child: _buildAuroraStatCard('check_circle_outline', '$taskCount', 'FLOW TASKS')),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(child: _buildAuroraStatCard('psychology_outlined', '92%', 'MENTAL CLARITY')),
                                  const SizedBox(width: 16),
                                  Expanded(child: _buildAuroraStatCard('bolt_outlined', '${todayScore.toInt() * 5}', 'EFFICIENCY PTS')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAuroraStatCard(String iconStr, String value, String label) {
    IconData icon = Icons.timer_outlined; // Default fallback
    if (iconStr == 'check_circle_outline') icon = Icons.check_circle_outline;
    if (iconStr == 'psychology_outlined') icon = Icons.psychology_outlined;
    if (iconStr == 'bolt_outlined') icon = Icons.bolt_outlined;

    return Container(
      height: 102,
      padding: const EdgeInsets.all(16),
      decoration: AuroraTheme.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 16),
          const Spacer(),
          Text(value, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(label, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.5)),
        ],
      ),
    );
  }
}
