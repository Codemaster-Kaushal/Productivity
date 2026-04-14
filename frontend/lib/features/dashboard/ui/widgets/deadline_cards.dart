import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DeadlineCards extends StatelessWidget {
  final List<Map<String, dynamic>> deadlines;

  DeadlineCards({super.key, required this.deadlines});

  @override
  Widget build(BuildContext context) {
    if (deadlines.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Deadlines',
            style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: deadlines.length,
            separatorBuilder: (_, _) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              final d = deadlines[index];
              final title = d['title'] ?? 'Untitled';
              final dueDateStr = d['due_date'] as String?;
              final dueDate = dueDateStr != null
                  ? DateTime.tryParse(dueDateStr)
                  : null;

              final daysLeft = dueDate != null
                  ? dueDate.difference(DateTime.now()).inDays
                  : 999;

              Color urgencyColor;
              String urgencyText;

              if (daysLeft <= 0) {
                urgencyColor = AppColors.scoreRed;
                urgencyText = 'Due today!';
              } else if (daysLeft <= 1) {
                urgencyColor = AppColors.scoreRed;
                urgencyText = 'Tomorrow';
              } else if (daysLeft <= 3) {
                urgencyColor = AppColors.scoreOrange;
                urgencyText = 'In $daysLeft days';
              } else if (daysLeft <= 7) {
                urgencyColor = AppColors.scoreAmber;
                urgencyText = 'In $daysLeft days';
              } else {
                urgencyColor = Colors.grey;
                urgencyText = 'In $daysLeft days';
              }

              return Container(
                width: 180,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: urgencyColor.withOpacity(0.3), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: urgencyColor),
                        SizedBox(width: 4),
                        Text(urgencyText,
                            style: TextStyle(
                                color: urgencyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
