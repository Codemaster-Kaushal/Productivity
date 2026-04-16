import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/goals_cubit.dart';
import '../cubit/goals_state.dart';
import '../data/coach_repository.dart';
import '../../../models/goal.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/aurora_theme.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  final _coachController = TextEditingController();
  final CoachRepository _coachRepository = CoachRepository();
  Goal? _selectedGoal;
  String _coachMessage =
      'Your coach insight will appear here once your daily context loads.';
  bool _isCoachLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCoachMessage();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _coachController.dispose();
    super.dispose();
  }

  Future<void> _loadCoachMessage({String? prompt}) async {
    setState(() {
      _isCoachLoading = true;
    });
    try {
      final response = await _coachRepository.requestCoachMessage(message: prompt);
      if (!mounted) return;
      setState(() {
        _coachMessage = response;
        _isCoachLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _coachMessage =
            'Your coach is offline right now, but your goals are still ready for action.';
        _isCoachLoading = false;
      });
    }
  }

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

  Future<void> _saveGoal() async {
    if (_titleController.text.trim().isEmpty ||
        _subjectController.text.trim().isEmpty) {
      return;
    }

    if (_selectedGoal == null) {
      await context.read<GoalsCubit>().createGoal(
            _titleController.text.trim(),
            _subjectController.text.trim(),
          );
    } else {
      await context.read<GoalsCubit>().updateGoal(
            goalId: _selectedGoal!.id,
            title: _titleController.text.trim(),
            subject: _subjectController.text.trim(),
          );
    }
    _clearSelection();
    await _loadCoachMessage();
  }

  Future<void> _completeGoal(Goal goal) async {
    if (goal.isCompleted) {
      await context.read<GoalsCubit>().uncompleteGoal(goal.id);
    } else {
      await context.read<GoalsCubit>().completeGoal(goal.id);
    }
    await _loadCoachMessage();
  }

  Future<void> _deleteGoal(Goal goal) async {
    await context.read<GoalsCubit>().deleteGoal(goal.id);
    if (_selectedGoal?.id == goal.id) {
      _clearSelection();
    }
    await _loadCoachMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<GoalsCubit, GoalsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(
              child: Text(msg, style: const TextStyle(color: AppColors.scoreRed)),
            ),
            loaded: (goals) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuroraTheme.sectionHeader('Celestial Focus'),
                    const SizedBox(height: 12),
                    Text('The Big 3', style: AppTextStyles.h1),
                    const SizedBox(height: 8),
                    Text(
                      'Choose the three wins that actually matter today, inspect them closely, and let the coach respond to your momentum.',
                      style: AppTextStyles.bodySecondary,
                    ),
                    const SizedBox(height: 32),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 900;
                        final leftColumn = Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTaskList(goals),
                            const SizedBox(height: 24),
                            _buildCoachCard(),
                          ],
                        );

                        if (isWide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: leftColumn),
                              const SizedBox(width: 24),
                              Expanded(flex: 2, child: _buildInspector()),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            leftColumn,
                            const SizedBox(height: 24),
                            _buildInspector(),
                          ],
                        );
                      },
                    ),
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
    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('The Big 3', style: AppTextStyles.h3),
              const Spacer(),
              Text(
                'FOCUS TRACKER',
                style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (goals.isEmpty)
            Text(
              'No focus goals yet. Create one in the inspector and it will land here.',
              style: AppTextStyles.bodySecondary,
            )
          else
            ...goals.map((goal) {
              final isSelected = _selectedGoal?.id == goal.id;
              return GestureDetector(
                onTap: () => _selectGoal(goal),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration:
                      isSelected ? AuroraTheme.cardHighlight : AuroraTheme.cardElevated,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _completeGoal(goal);
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: goal.isCompleted
                                  ? AppColors.primary
                                  : AppColors.surfaceBorder,
                              width: 2,
                            ),
                            color: goal.isCompleted
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                          child: goal.isCompleted
                              ? const Icon(Icons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.title,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                                decoration: goal.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              goal.subject,
                              style: AppTextStyles.bodySecondary,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: AppColors.textMuted),
                        onPressed: () {
                          _deleteGoal(goal);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildInspector() {
    final isEditing = _selectedGoal != null;

    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune_rounded, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('Goal Inspector', style: AppTextStyles.h3),
              const Spacer(),
              if (isEditing)
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: _clearSelection,
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'OBJECTIVE TITLE',
            style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            style: AppTextStyles.body,
            decoration: const InputDecoration(
              hintText: 'Finish discrete math homework',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'FOCUS AREA',
            style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _subjectController,
            style: AppTextStyles.body,
            decoration: const InputDecoration(
              hintText: 'Homework / Music / Revision',
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: AuroraTheme.gradientButton(
              text: isEditing ? 'Update Goal' : 'Add Focus Goal',
              onPressed: () {
                _saveGoal();
              },
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'This panel keeps the focus page aligned with the sketch: three major items on the left, one inspector on the right.',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildCoachCard() {
    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: AppColors.secondary),
              const SizedBox(width: 8),
              Text('AI Help', style: AppTextStyles.h3),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            _coachMessage,
            style: AppTextStyles.bodyPrimary,
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _coachController,
            minLines: 1,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Ask your coach what to improve around you right now...',
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: AuroraTheme.outlinedButton(
                  text: 'Refresh Insight',
                  onPressed: () {
                    _loadCoachMessage();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _isCoachLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AuroraTheme.gradientButton(
                        text: 'Ask Coach',
                        onPressed: () {
                          final prompt = _coachController.text.trim();
                          _loadCoachMessage(
                            prompt: prompt.isEmpty ? null : prompt,
                          );
                          _coachController.clear();
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
