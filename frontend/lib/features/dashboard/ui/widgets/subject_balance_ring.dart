import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SubjectBalanceRing extends StatelessWidget {
  final Map<String, int> distribution;

  const SubjectBalanceRing({super.key, required this.distribution});

  static const _subjectColors = [
    Color(0xFF6C63FF),
    Color(0xFF03DAC6),
    Color(0xFFFF6B6B),
    Color(0xFFFFA726),
    Color(0xFF66BB6A),
    Color(0xFFAB47BC),
    Color(0xFF42A5F5),
    Color(0xFFEF5350),
  ];

  @override
  Widget build(BuildContext context) {
    if (distribution.isEmpty) return const SizedBox.shrink();

    final total = distribution.values.fold(0, (a, b) => a + b);
    final subjects = distribution.entries.toList();
    final allSame = subjects.length == 1 && total > 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Subject Balance',
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Row(
            children: [
              // Donut chart
              SizedBox(
                width: 80,
                height: 80,
                child: CustomPaint(
                  painter: _DonutPainter(subjects, total),
                ),
              ),
              const SizedBox(width: 16),
              // Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...subjects.asMap().entries.map((e) {
                      final i = e.key;
                      final entry = e.value;
                      final color = _subjectColors[i % _subjectColors.length];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(entry.key,
                                  style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 12),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text('${entry.value}',
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    }),
                    if (allSame)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('⚠️ Only one subject today',
                            style: TextStyle(
                                color: AppColors.scoreAmber, fontSize: 11)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<MapEntry<String, int>> subjects;
  final int total;

  _DonutPainter(this.subjects, this.total);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final center = rect.center;
    final radius = size.width / 2;
    const strokeWidth = 14.0;

    // Background ring
    final bgPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    // Segments
    double startAngle = -pi / 2;
    for (int i = 0; i < subjects.length; i++) {
      final sweepAngle = (subjects[i].value / total) * 2 * pi;
      final paint = Paint()
        ..color = SubjectBalanceRing
            ._subjectColors[i % SubjectBalanceRing._subjectColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle - 0.04, // small gap
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
