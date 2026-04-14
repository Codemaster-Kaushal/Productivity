import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SevenDayStrip extends StatelessWidget {
  final List<double> scores;

  SevenDayStrip({super.key, required this.scores});

  Color _tileColor(double score) {
    if (score < 0) return Colors.grey.shade800; // no data
    if (score >= 85) return AppColors.scoreGreen;
    if (score >= 70) return AppColors.scoreTeal;
    if (score >= 50) return AppColors.scoreAmber;
    if (score >= 30) return AppColors.scoreOrange;
    return AppColors.scoreRed;
  }

  String _dayLabel(int daysAgo) {
    final date = DateTime.now().subtract(Duration(days: 6 - daysAgo));
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final displayScores = scores.length >= 7 ? scores : List.filled(7, -1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last 7 Days',
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final score = displayScores[i];
              final color = _tileColor(score);

              return Tooltip(
                message: score < 0
                    ? '${_dayLabel(i)}: No data'
                    : '${_dayLabel(i)}: ${score.toInt()}',
                child: Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.withOpacity(score < 0 ? 0.3 : 0.85),
                        borderRadius: BorderRadius.circular(8),
                        border: i == 6
                            ? Border.all(
                                color: AppColors.primary, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          score < 0 ? '—' : '${score.toInt()}',
                          style: TextStyle(
                            color: score < 0
                                ? Colors.grey.shade600
                                : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(_dayLabel(i),
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 10)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
