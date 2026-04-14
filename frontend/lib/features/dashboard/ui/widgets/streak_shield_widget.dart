import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class StreakShieldWidget extends StatelessWidget {
  final int streak;
  final int shields;
  final bool isActiveToday;

  StreakShieldWidget({
    super.key,
    required this.streak,
    required this.shields,
    required this.isActiveToday,
  });

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final isUrgent = hour >= 21 && !isActiveToday;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: isUrgent
            ? Border.all(color: AppColors.scoreRed.withOpacity(0.6), width: 1.5)
            : null,
        boxShadow: isUrgent
            ? [
                BoxShadow(
                  color: AppColors.scoreRed.withOpacity(0.15),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Streak
          Expanded(
            child: Row(
              children: [
                Text(
                  streak > 0 ? '🔥' : '❄️',
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$streak',
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text(
                      streak == 1 ? 'day streak' : 'day streak',
                      style: TextStyle(
                          color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade800,
          ),

          // Shields
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  shields > 0 ? '🛡️' : '🪨',
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$shields',
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text(
                      shields == 1 ? 'shield' : 'shields',
                      style: TextStyle(
                          color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Urgency indicator
          if (isUrgent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.scoreRed.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '⚠️',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
