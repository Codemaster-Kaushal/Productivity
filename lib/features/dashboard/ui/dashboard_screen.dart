import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../scores/ui/widgets/true_score_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<DashboardCubit>().loadDashboard(),
          ),
        ],
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
            loaded: (todayScore, isActiveDay, isStrongDay, currentStreak, focusMinutesToday) {
              return RefreshIndicator(
                onRefresh: () => context.read<DashboardCubit>().loadDashboard(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TrueScoreCard(
                        score: todayScore,
                        isActiveDay: isActiveDay,
                        isStrongDay: isStrongDay,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: _buildMiniStatCard('🔥 Streak', '$currentStreak days', AppColors.scoreOrange)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildMiniStatCard('⏱ Focus', '$focusMinutesToday min', AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildMiniStatCard(
                            '📊 Score',
                            todayScore > 0 ? '${todayScore.toInt()}' : '—',
                            todayScore >= 80 ? AppColors.scoreGreen : todayScore >= 50 ? AppColors.scoreAmber : AppColors.scoreRed,
                          )),
                          const SizedBox(width: 12),
                          Expanded(child: _buildMiniStatCard(
                            isStrongDay ? '💪 Strong Day' : isActiveDay ? '✅ Active' : '😴 Inactive',
                            isStrongDay ? 'Yes' : isActiveDay ? 'Yes' : 'Not yet',
                            isStrongDay ? AppColors.scoreGreen : isActiveDay ? AppColors.scoreAmber : Colors.grey,
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

  Widget _buildMiniStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
