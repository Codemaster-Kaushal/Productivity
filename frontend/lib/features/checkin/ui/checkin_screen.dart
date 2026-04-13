import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/checkin_cubit.dart';
import '../cubit/checkin_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen>
    with SingleTickerProviderStateMixin {
  int _energy = 5;
  int _focus = 5;
  int _mood = 5;
  final _noteController = TextEditingController();
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Color _sliderColor(int value) {
    if (value >= 8) return AppColors.scoreGreen;
    if (value >= 5) return AppColors.scoreAmber;
    if (value >= 3) return AppColors.scoreOrange;
    return AppColors.scoreRed;
  }

  String _emoji(int value) {
    if (value >= 9) return '🔥';
    if (value >= 7) return '😊';
    if (value >= 5) return '😐';
    if (value >= 3) return '😔';
    return '😞';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Check-in', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: BlocConsumer<CheckinCubit, CheckinState>(
        listener: (context, state) {
          state.maybeWhen(
            saved: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('Check-in saved! ✨'),
                    ],
                  ),
                  backgroundColor: AppColors.scoreGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
              // Reset after save
              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  context.read<CheckinCubit>().reset();
                }
              });
            },
            error: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(msg),
                    backgroundColor: AppColors.scoreRed),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isSaving = state.maybeWhen(
            saving: () => true,
            orElse: () => false,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: 0.7 + (_pulseController.value * 0.3),
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.2),
                          AppColors.primary.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        const Text('How was your day?',
                            style: AppTextStyles.h2),
                        const SizedBox(height: 4),
                        Text('Takes less than 10 seconds',
                            style: AppTextStyles.bodySecondary
                                .copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Energy slider
                _buildSliderCard(
                  label: 'Energy',
                  icon: Icons.bolt_rounded,
                  value: _energy,
                  onChanged: (v) => setState(() => _energy = v),
                ),

                const SizedBox(height: 16),

                // Focus slider
                _buildSliderCard(
                  label: 'Focus',
                  icon: Icons.center_focus_strong_rounded,
                  value: _focus,
                  onChanged: (v) => setState(() => _focus = v),
                ),

                const SizedBox(height: 16),

                // Mood slider
                _buildSliderCard(
                  label: 'Mood',
                  icon: Icons.mood_rounded,
                  value: _mood,
                  onChanged: (v) => setState(() => _mood = v),
                ),

                const SizedBox(height: 24),

                // Optional note
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Optional: anything on your mind? (optional)',
                      hintStyle: TextStyle(
                          color: Colors.grey.shade600, fontSize: 14),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    style: const TextStyle(
                        color: AppColors.textPrimary, fontSize: 14),
                  ),
                ),

                const SizedBox(height: 28),

                // Save button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isSaving
                        ? null
                        : () {
                            context.read<CheckinCubit>().saveCheckin(
                                  energy: _energy,
                                  focus: _focus,
                                  mood: _mood,
                                  note: _noteController.text.trim(),
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Text('Save Check-in',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                  ),
                ),

                const SizedBox(height: 16),

                // Summary preview
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSummaryChip(
                          '⚡', 'Energy', _energy, _sliderColor(_energy)),
                      _buildSummaryChip(
                          '🎯', 'Focus', _focus, _sliderColor(_focus)),
                      _buildSummaryChip(
                          _emoji(_mood), 'Mood', _mood, _sliderColor(_mood)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSliderCard({
    required String label,
    required IconData icon,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    final color = _sliderColor(value);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('$value/10',
                    style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              inactiveTrackColor: color.withOpacity(0.15),
              thumbColor: color,
              overlayColor: color.withOpacity(0.1),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (v) => onChanged(v.toInt()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryChip(
      String emoji, String label, int value, Color color) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text('$value',
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
      ],
    );
  }
}
