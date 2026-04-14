import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/scores_cubit.dart';
import '../cubit/scores_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ScoresScreen extends StatelessWidget {
  ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Score History', style: AppTextStyles.h2), backgroundColor: AppColors.background, elevation: 0),
      body: BlocBuilder<ScoresCubit, ScoresState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: CircularProgressIndicator()),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(msg, style: TextStyle(color: AppColors.scoreRed))),
            loaded: (todayScore, history) {
              if (history.isEmpty) return Center(child: Text('No scores yet.', style: AppTextStyles.bodySecondary));
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final sc = history[index];
                  return Card(
                    color: AppColors.surface,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(sc.date, style: AppTextStyles.body),
                      subtitle: Text('Streak: ${sc.currentStreak}', style: AppTextStyles.bodySecondary),
                      trailing: Text(sc.score.toStringAsFixed(1), style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
                    ),
                  );
                },
              );
            }
          );
        },
      ),
    );
  }
}
