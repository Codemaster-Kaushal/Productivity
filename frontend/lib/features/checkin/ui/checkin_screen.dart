import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/checkin_cubit.dart';
import '../cubit/checkin_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/aurora_theme.dart';

class CheckinScreen extends StatefulWidget {
  CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  int _energy = 5;
  int _focus = 5;
  int _mood = 5;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _syncReflection() {
    context.read<CheckinCubit>().saveCheckin(
          energy: _energy,
          focus: _focus,
          mood: _mood,
          note: _noteController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<CheckinCubit, CheckinState>(
        listener: (context, state) {
          state.maybeWhen(
            saved: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Reflection synced to vault. ✨'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Future.delayed(Duration(seconds: 1), () {
                if (mounted) context.read<CheckinCubit>().reset();
              });
            },
            error: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  backgroundColor: AppColors.scoreRed,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isSaving = state.maybeWhen(saving: () => true, orElse: () => false);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuroraTheme.sectionHeader('Aurora Reflection Center'),
                SizedBox(height: 32),

                Text('DAILY PULSE', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
                SizedBox(height: 8),
                Text('Evening Reflection', style: AppTextStyles.h1),
                SizedBox(height: 8),
                Text(
                  'Capture the essence of your journey today. Align your energy with your\ncelestial path.',
                  style: AppTextStyles.bodySecondary,
                ),
                SizedBox(height: 32),

                // Metrics Row Component
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 800;
                    if (isWide) {
                      return Row(
                        children: [
                          Expanded(child: _buildMetricCard('Energy', '01', Icons.bolt, 'How much vital force did you feel flowing through your tasks?', 'STATIC', 'KINETIC', _energy, (v) => setState(() => _energy = v))),
                          SizedBox(width: 16),
                          Expanded(child: _buildMetricCard('Focus', '02', Icons.center_focus_strong, 'Degree of immersion in your deep work and intentional moments.', 'DIFFUSE', 'LASER', _focus, (v) => setState(() => _focus = v))),
                          SizedBox(width: 16),
                          Expanded(child: _buildMetricCard('Mood', '03', Icons.auto_awesome, 'The emotional resonance of your day. High or low frequency?', 'MELANCHOLY', 'EUPHORIA', _mood, (v) => setState(() => _mood = v))),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildMetricCard('Energy', '01', Icons.bolt, 'How much vital force did you feel flowing through your tasks?', 'STATIC', 'KINETIC', _energy, (v) => setState(() => _energy = v)),
                          SizedBox(height: 16),
                          _buildMetricCard('Focus', '02', Icons.center_focus_strong, 'Degree of immersion in your deep work and intentional moments.', 'DIFFUSE', 'LASER', _focus, (v) => setState(() => _focus = v)),
                          SizedBox(height: 16),
                          _buildMetricCard('Mood', '03', Icons.auto_awesome, 'The emotional resonance of your day. High or low frequency?', 'MELANCHOLY', 'EUPHORIA', _mood, (v) => setState(() => _mood = v)),
                        ],
                      );
                    }
                  },
                ),
                
                SizedBox(height: 32),

                // Bottom Section: Notes + Snapshot
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 800;
                    
                    final monologue = Container(
                      decoration: AuroraTheme.card,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('INTERNAL MONOLOGUE', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
                          SizedBox(height: 16),
                          TextField(
                            controller: _noteController,
                            maxLines: 5,
                            style: AppTextStyles.body,
                            decoration: InputDecoration(
                              hintText: 'What stars aligned today? What shadows need clearing?',
                              filled: false,
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              AuroraTheme.statusTag('#productivity', color: AppColors.textSecondary),
                              SizedBox(width: 8),
                              AuroraTheme.statusTag('#alignment', color: AppColors.textSecondary),
                              SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceBorder,
                                  borderRadius: BorderRadius.circular(16)
                                ),
                                child: Text('Add Tag +', style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary)),
                              )
                            ],
                          )
                        ],
                      ),
                    );

                    final snapshot = Container(
                      decoration: AuroraTheme.card,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Celestial Snapshot', style: AppTextStyles.h3),
                          SizedBox(height: 12),
                          Text(
                            'Your current stats indicate a high-focus day. Tomorrow\'s forecast suggests prioritizing rest.',
                            style: AppTextStyles.bodySecondary,
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('CONSISTENCY', style: AppTextStyles.label),
                              Text('12 DAY STREAK', style: AppTextStyles.label.copyWith(color: AppColors.primary)),
                            ],
                          ),
                          SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: isSaving
                              ? Center(child: CircularProgressIndicator(color: AppColors.primary))
                              : AuroraTheme.gradientButton(
                                  text: 'Sync Reflection',
                                  onPressed: _syncReflection,
                                ),
                          )
                        ],
                      ),
                    );

                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: monologue),
                          SizedBox(width: 24),
                          Expanded(flex: 1, child: snapshot),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          monologue,
                          SizedBox(height: 24),
                          snapshot,
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard(String title, String numId, IconData icon, String desc, String leftLabel, String rightLabel, int value, ValueChanged<int> onChanged) {
    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              Text('METRIC $numId', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          SizedBox(height: 16),
          Text(title, style: AppTextStyles.h3),
          SizedBox(height: 8),
          Text(desc, style: AppTextStyles.bodySecondary),
          SizedBox(height: 32),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.surfaceBorder,
              thumbColor: AppColors.textPrimary,
              overlayColor: AppColors.primary.withOpacity(0.1),
              trackHeight: 4,
            ),
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (v) => onChanged(v.toInt()),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leftLabel, style: AppTextStyles.label),
              Text(rightLabel, style: AppTextStyles.label),
            ],
          )
        ],
      ),
    );
  }
}
