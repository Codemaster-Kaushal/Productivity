import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProcrastinationCard extends StatelessWidget {
  final Map<String, double> avgDelays; // subject -> avg minutes

  ProcrastinationCard({super.key, required this.avgDelays});

  @override
  Widget build(BuildContext context) {
    if (avgDelays.isEmpty) return const SizedBox.shrink();

    // Sort by delay descending
    final sorted = avgDelays.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('⏰', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text('Procrastination Patterns',
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 12),
          ...sorted.take(5).map((entry) {
            final minutes = entry.value;
            final hours = (minutes / 60).floor();
            final mins = (minutes % 60).floor();
            final label = hours > 0 ? '${hours}h ${mins}m' : '${mins}m';

            Color delayColor;
            if (minutes < 30) {
              delayColor = AppColors.scoreGreen;
            } else if (minutes < 120) {
              delayColor = AppColors.scoreAmber;
            } else {
              delayColor = AppColors.scoreRed;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(entry.key,
                        style: TextStyle(
                            color: AppColors.textPrimary, fontSize: 13)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: delayColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('avg $label delay',
                        style: TextStyle(
                            color: delayColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
