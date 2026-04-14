import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/goals_cubit.dart';
import '../cubit/goals_state.dart';
import '../../../models/goal.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/aurora_theme.dart';

class GoalsScreen extends StatefulWidget {
  GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  Goal? _selectedGoal;

  void _selectGoal(Goal goal) {
    setState(() {
      _selectedGoal = goal;
      _titleController.text = goal.title;
      _subjectController.text = goal.subject;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedGoal = null;
      _titleController.clear();
      _subjectController.clear();
    });
  }

  void _saveGoal() {
    if (_titleController.text.trim().isEmpty || _subjectController.text.trim().isEmpty) return;

    if (_selectedGoal != null) {
      // If we had edit capability we'd call it here
      // For now, clear selection as we don't have an update method in cubit yet
    } else {
      context.read<GoalsCubit>().createGoal(
        _titleController.text.trim(),
        _subjectController.text.trim(),
      );
    }
    _clearSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<GoalsCubit, GoalsState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: CircularProgressIndicator()),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(msg, style: TextStyle(color: AppColors.scoreRed))),
            loaded: (goals) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuroraTheme.sectionHeader('Celestial Productivity'),
                    SizedBox(height: 32),
                    
                    Text('Celestial Focus', style: AppTextStyles.h1),
                    SizedBox(height: 8),
                    Text('Architect your reality. Define your three pillars of manifestation for\nthe current cycle.', style: AppTextStyles.bodySecondary),
                    SizedBox(height: 32),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 800;
                        final taskList = _buildTaskList(goals);
                        final inspector = _buildInspector();

                        if (isWide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: taskList),
                              SizedBox(width: 32),
                              Expanded(flex: 2, child: inspector),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              inspector,
                              SizedBox(height: 32),
                              taskList,
                            ],
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTaskList(List<Goal> goals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('The Big 3', style: AppTextStyles.h3),
            Text('PRIORITY MATRIX', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
          ],
        ),
        SizedBox(height: 16),
        if (goals.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            decoration: AuroraTheme.card,
            alignment: Alignment.center,
            child: Text('No active missions. Plot a new course in the inspector.', style: AppTextStyles.bodySecondary),
          )
        else
          ...goals.map((goal) {
            final isSelected = _selectedGoal?.id == goal.id;
            return GestureDetector(
              onTap: () => _selectGoal(goal),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(20),
                decoration: isSelected ? AuroraTheme.cardHighlight : AuroraTheme.card,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (goal.isCompleted) {
                          context.read<GoalsCubit>().uncompleteGoal(goal.id);
                        } else {
                          context.read<GoalsCubit>().completeGoal(goal.id);
                        }
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: goal.isCompleted ? AppColors.primary : AppColors.surfaceBorder, width: 2),
                          color: goal.isCompleted ? AppColors.primary : Colors.transparent,
                        ),
                        child: goal.isCompleted ? Icon(Icons.check, size: 16, color: Colors.white) : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(goal.title, style: AppTextStyles.h2.copyWith(decoration: goal.isCompleted ? TextDecoration.lineThrough : null)),
                              AuroraTheme.statusTag(goal.isCompleted ? 'COMPLETED' : 'HIGH ORBIT'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text('Subject Context: ${goal.subject}', style: AppTextStyles.bodySecondary),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 14, color: AppColors.textMuted),
                              SizedBox(width: 4),
                              Text('Today', style: AppTextStyles.caption),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: AppColors.textMuted),
                      onPressed: () => context.read<GoalsCubit>().deleteGoal(goal.id),
                    )
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildInspector() {
    final mode = _selectedGoal == null ? 'New Mission' : 'Editing Mission';

    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.blur_on, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Goal Inspector', style: AppTextStyles.h3),
              Spacer(),
              if (_selectedGoal != null)
                IconButton(icon: Icon(Icons.close, size: 20), onPressed: _clearSelection),
            ],
          ),
          SizedBox(height: 24),
          
          Text('OBJECTIVE TITLE', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
          SizedBox(height: 8),
          TextField(
            controller: _titleController,
            style: AppTextStyles.body,
            decoration: InputDecoration(hintText: 'e.g. Launch the Solaris portal'),
          ),
          SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ORBIT LEVEL', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
                    SizedBox(height: 8),
                     TextField(
                      controller: _subjectController,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(hintText: 'Subject / Area'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: AuroraTheme.gradientButton(
              text: _selectedGoal == null ? 'Launch Manifest' : 'Update Manifest',
              onPressed: _saveGoal,
            ),
          ),
          SizedBox(height: 16),
          if (_selectedGoal != null)
            Center(
              child: TextButton(
                onPressed: () {
                  context.read<GoalsCubit>().deleteGoal(_selectedGoal!.id);
                  _clearSelection();
                },
                child: Text('Archive to Vault', style: AppTextStyles.bodySecondary),
              ),
            ),
            
          if (_selectedGoal == null) ...[
            SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.psychology_outlined, color: AppColors.primary, size: 16),
                      SizedBox(width: 8),
                      Text('AI INSIGHT', style: AppTextStyles.label.copyWith(color: AppColors.primary)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Setting precise objectives increases completion probability by 42%. Use the inspector to define your mission parameters.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  )
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
