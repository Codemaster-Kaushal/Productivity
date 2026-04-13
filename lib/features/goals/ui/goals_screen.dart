import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/goals_cubit.dart';
import '../cubit/goals_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  void _showCreateGoalDialog(BuildContext context) {
    final titleController = TextEditingController();
    final subjectController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('New Goal', style: AppTextStyles.h2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Goal title',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                hintText: 'Subject (e.g., Math, Physics)',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade400)),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && subjectController.text.isNotEmpty) {
                context.read<GoalsCubit>().createGoal(
                  titleController.text.trim(),
                  subjectController.text.trim(),
                );
                Navigator.pop(dialogContext);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Goals', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateGoalDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GoalsCubit, GoalsState>(
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
                    onPressed: () => context.read<GoalsCubit>().loadTodayGoals(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            loaded: (goals) {
              if (goals.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flag_outlined, size: 64, color: Colors.grey.shade600),
                      const SizedBox(height: 16),
                      const Text('No goals for today', style: AppTextStyles.bodySecondary),
                      const SizedBox(height: 8),
                      const Text('Tap + to add your first goal!', style: AppTextStyles.bodySecondary),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => context.read<GoalsCubit>().loadTodayGoals(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return Dismissible(
                      key: Key(goal.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.scoreRed.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.delete, color: AppColors.scoreRed),
                      ),
                      onDismissed: (_) {
                        context.read<GoalsCubit>().deleteGoal(goal.id);
                      },
                      child: Card(
                        color: AppColors.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          title: Text(goal.title, style: AppTextStyles.body.copyWith(
                            decoration: goal.isCompleted ? TextDecoration.lineThrough : null,
                            color: goal.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                          )),
                          subtitle: Text(goal.subject, style: AppTextStyles.bodySecondary),
                          trailing: Checkbox(
                            value: goal.isCompleted,
                            activeColor: AppColors.scoreGreen,
                            onChanged: (_) {
                              if (goal.isCompleted) {
                                context.read<GoalsCubit>().uncompleteGoal(goal.id);
                              } else {
                                context.read<GoalsCubit>().completeGoal(goal.id);
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
