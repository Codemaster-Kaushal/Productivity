import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class MomentumBar extends StatelessWidget {
  final double percentage;

  const MomentumBar({super.key, required this.percentage});

  Color _barColor(double pct) {
    if (pct >= 80) return AppColors.scoreGreen;
    if (pct >= 50) return AppColors.scoreAmber;
    if (pct >= 25) return AppColors.scoreOrange;
    return AppColors.scoreRed;
  }

  @override
  Widget build(BuildContext context) {
    final color = _barColor(percentage);
    final clampedPct = percentage.clamp(0, 100) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today's Momentum",
                style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
            Text('${percentage.toInt()}%',
                style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                color: AppColors.surface,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: 10,
                width: MediaQuery.of(context).size.width * clampedPct,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.7),
                      color,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
