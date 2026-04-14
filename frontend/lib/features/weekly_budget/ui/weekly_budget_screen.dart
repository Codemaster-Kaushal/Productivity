import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weekly_budget_cubit.dart';
import '../cubit/weekly_budget_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WeeklyBudgetScreen extends StatelessWidget {
  WeeklyBudgetScreen({super.key});

  void _showAddTargetDialog(BuildContext context) {
    final subjectController = TextEditingController();
    int sessions = 5;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: Text('Set Weekly Target', style: AppTextStyles.h2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  hintText: 'Subject name',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: AppColors.textPrimary),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Sessions/week: ',
                      style: TextStyle(color: Colors.grey.shade400)),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      if (sessions > 1) setState(() => sessions--);
                    },
                    icon: Icon(Icons.remove_circle_outline,
                        color: AppColors.textSecondary),
                  ),
                  Text('$sessions',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => setState(() => sessions++),
                    icon: Icon(Icons.add_circle_outline,
                        color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child:
                  Text('Cancel', style: TextStyle(color: Colors.grey.shade400)),
            ),
            ElevatedButton(
              onPressed: () {
                if (subjectController.text.isNotEmpty) {
                  context.read<WeeklyBudgetCubit>().setTarget(
                        subjectController.text.trim(),
                        sessions,
                      );
                  Navigator.pop(dialogContext);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Budget', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTargetDialog(context),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<WeeklyBudgetCubit, WeeklyBudgetState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: CircularProgressIndicator()),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (msg) => Center(
                child: Text(msg,
                    style: TextStyle(color: AppColors.scoreRed))),
            loaded: (budgets) {
              if (budgets.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_view_week,
                          size: 64, color: Colors.grey.shade600),
                      SizedBox(height: 16),
                      Text('No weekly targets set',
                          style: AppTextStyles.bodySecondary),
                      SizedBox(height: 8),
                      Text('Tap + to plan your study week!',
                          style: AppTextStyles.bodySecondary),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () =>
                    context.read<WeeklyBudgetCubit>().loadBudget(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: budgets.length,
                  itemBuilder: (context, index) {
                    final b = budgets[index];
                    final pct = b.completionPct;
                    final color = pct >= 100
                        ? AppColors.scoreGreen
                        : pct >= 50
                            ? AppColors.scoreAmber
                            : AppColors.scoreRed;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(b.subject,
                                    style: AppTextStyles.body
                                        .copyWith(fontWeight: FontWeight.w600)),
                              ),
                              Text(
                                '${b.actualSessions}/${b.targetSessions}',
                                style: TextStyle(
                                    color: color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (pct / 100).clamp(0, 1),
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade800,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(color),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            pct >= 100
                                ? '✅ Target reached!'
                                : '${pct.toInt()}% complete',
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 12),
                          ),
                        ],
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
