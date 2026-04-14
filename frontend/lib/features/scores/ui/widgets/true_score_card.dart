import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/scoring_constants.dart';

class TrueScoreCard extends StatefulWidget {
  final double score;
  final bool isActiveDay;
  final bool isStrongDay;

  TrueScoreCard({
    super.key,
    required this.score,
    required this.isActiveDay,
    required this.isStrongDay,
  });

  @override
  State<TrueScoreCard> createState() => _TrueScoreCardState();
}

class _TrueScoreCardState extends State<TrueScoreCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showVerdict = false;
  Timer? _verdictTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (ScoringConstants.trueScoreAnimationDuration * 1000) ~/ 1),
    );
    
    _animation = Tween<double>(begin: 0, end: widget.score).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)
    );

    _controller.forward().then((_) {
      _verdictTimer = Timer(Duration(milliseconds: (ScoringConstants.verdictDelay * 1000) ~/ 1), () {
        if (mounted) {
          setState(() {
            _showVerdict = true;
          });
        }
      });
    });
  }

  @override
  void didUpdateWidget(TrueScoreCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _showVerdict = false;
      _verdictTimer?.cancel();
      _animation = Tween<double>(begin: _animation.value, end: widget.score).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)
      );
      _controller.forward(from: 0).then((_) {
        _verdictTimer = Timer(Duration(milliseconds: (ScoringConstants.verdictDelay * 1000) ~/ 1), () {
          if (mounted) {
            setState(() {
              _showVerdict = true;
            });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _verdictTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Color _getScoreColor(double v) {
    if (v >= 85) return AppColors.scoreGreen;
    if (v >= 70) return AppColors.scoreTeal;
    if (v >= 50) return AppColors.scoreAmber;
    if (v >= 30) return AppColors.scoreOrange;
    return AppColors.scoreRed;
  }
  
  String _getVerdictText(double v) {
    if (v >= 85) return "Excellent";
    if (v >= 70) return "Good";
    if (v >= 50) return "Okay";
    if (v >= 30) return "Needs Work";
    return "Critical";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('True Score', style: AppTextStyles.h2),
            SizedBox(height: 16),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final val = _animation.value;
                final color = _getScoreColor(val);
                return Text(
                  val.toStringAsFixed(1),
                  style: AppTextStyles.scoreLarge.copyWith(color: color),
                );
              },
            ),
            SizedBox(height: 8),
            AnimatedOpacity(
              opacity: _showVerdict ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Text(
                _getVerdictText(widget.score),
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getScoreColor(widget.score),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.isStrongDay)
                  Chip(
                    label: Text('Strong day ✓', style: TextStyle(color: Colors.white)),
                    backgroundColor: AppColors.primary,
                  )
                else if (widget.isActiveDay)
                  Chip(
                    label: Text('Active day ✓', style: TextStyle(color: Colors.white)),
                    backgroundColor: AppColors.scoreTeal,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
