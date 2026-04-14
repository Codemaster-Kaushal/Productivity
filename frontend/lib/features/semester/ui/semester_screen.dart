import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/semester_cubit.dart';
import '../cubit/semester_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class SemesterScreen extends StatelessWidget {
  const SemesterScreen({super.key});

  void _showCreateGoalDialog(BuildContext context) {
    final subjectController = TextEditingController();
    final titleController = TextEditingController();
    final semesterController = TextEditingController(text: 'Spring 2026');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('New Semester Goal', style: AppTextStyles.h2),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildField(subjectController, 'Subject (e.g., Mathematics)'),
              const SizedBox(height: 12),
              _buildField(titleController, 'Goal title (e.g., Score 90+ in finals)'),
              const SizedBox(height: 12),
              _buildField(semesterController, 'Semester label'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade400)),
          ),
          ElevatedButton(
            onPressed: () {
              if (subjectController.text.isNotEmpty && titleController.text.isNotEmpty) {
                final now = DateTime.now();
                final endDate = now.add(const Duration(days: 120));
                context.read<SemesterCubit>().createGoal(
                  subject: subjectController.text.trim(),
                  title: titleController.text.trim(),
                  semesterLabel: semesterController.text.trim(),
                  startDate: now.toIso8601String().split('T')[0],
                  endDate: endDate.toIso8601String().split('T')[0],
                );
                Navigator.pop(dialogContext);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: AppColors.textPrimary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester Goals', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateGoalDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<SemesterCubit, SemesterState>(
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
                    onPressed: () => context.read<SemesterCubit>().loadGoals(),
                    child: Text('Retry'),
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
                      Icon(Icons.school_outlined, size: 64, color: Colors.grey.shade600),
                      const SizedBox(height: 16),
                      Text('No semester goals yet', style: AppTextStyles.bodySecondary),
                      const SizedBox(height: 8),
                      Text('Tap + to add your first semester goal!', style: AppTextStyles.bodySecondary),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => context.read<SemesterCubit>().loadGoals(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final g = goals[index];
                    return Dismissible(
                      key: Key(g.id),
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
                      onDismissed: (_) => context.read<SemesterCubit>().deleteGoal(g.id),
                      child: Card(
                        color: AppColors.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(g.subject, style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: g.isActive ? AppColors.scoreGreen.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      g.isActive ? 'Active' : 'Inactive',
                                      style: TextStyle(color: g.isActive ? AppColors.scoreGreen : Colors.grey, fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(g.title, style: AppTextStyles.body),
                              const SizedBox(height: 6),
                              Text(
                                '${g.semesterLabel}  •  ${g.startDate} → ${g.endDate}',
                                style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                              ),
                            ],
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
