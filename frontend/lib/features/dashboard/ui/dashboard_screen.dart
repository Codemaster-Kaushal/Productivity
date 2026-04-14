import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGreetingHeader(),
          SizedBox(height: 40),
          
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 8, child: _buildHeroScoreCard()),
                        SizedBox(width: 24),
                        Expanded(flex: 4, child: Column(
                          children: [
                            _buildStreakCard(),
                            SizedBox(height: 24),
                            _buildShieldCard(),
                          ],
                        )),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildHeroScoreCard(),
                        SizedBox(height: 24),
                        _buildStreakCard(),
                        SizedBox(height: 24),
                        _buildShieldCard(),
                      ],
                    ),
                  
                  SizedBox(height: 24),
                  _buildWeeklyMomentum(),
                  SizedBox(height: 24),

                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 5, child: _buildBalanceRing()),
                        SizedBox(width: 24),
                        Expanded(flex: 7, child: _buildQuickStatsGrid()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildBalanceRing(),
                        SizedBox(height: 24),
                        _buildQuickStatsGrid(),
                      ],
                    ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildGreetingHeader() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.end,
      runSpacing: 16,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MORNING, ALEXANDER', style: AppTextStyles.label.copyWith(
              color: AppColors.primary, fontSize: 12, letterSpacing: 0.6,
            )),
            SizedBox(height: 4),
            Text('The universe is in focus.', style: AppTextStyles.headline.copyWith(
              fontSize: 48, fontWeight: FontWeight.w600, letterSpacing: -1.92, color: AppColors.onSurface,
            )),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh.withOpacity(0.5),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: AppColors.outlineVariant.withOpacity(0.15)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, color: AppColors.secondary, size: 14),
              SizedBox(width: 6),
              Text('Momentum: High', style: AppTextStyles.body.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeroScoreCard() {
    return Container(
      constraints: BoxConstraints(minHeight: 400),
      decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(24)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -128,
            right: -128,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.1), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 100, spreadRadius: 50)]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('True Score', style: AppTextStyles.headline.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant)),
                    Text('Composite productivity index', style: AppTextStyles.body.copyWith(fontSize: 14, color: AppColors.outlineVariant)),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(colors: [AppColors.primary, AppColors.secondary], begin: Alignment.topLeft, end: Alignment.bottomRight).createShader(bounds),
                          child: Text(
                            '84',
                            style: GoogleFonts.inter(fontSize: 160, fontWeight: FontWeight.w800, color: Colors.white, height: 1.0, letterSpacing: -8),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.trending_up, color: AppColors.primary, size: 16),
                            SizedBox(width: 8),
                            Text('+12% FROM YESTERDAY', style: AppTextStyles.label.copyWith(color: AppColors.primary, fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary, AppColors.secondary]), borderRadius: BorderRadius.circular(9999)),
                      child: Text('Deep Work', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: AppColors.onPrimaryFixed)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      decoration: BoxDecoration(color: AppColors.surfaceBright.withOpacity(0.2), border: Border.all(color: AppColors.primary.withOpacity(0.2)), borderRadius: BorderRadius.circular(9999)),
                      child: Text('View Insights', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVariant.withOpacity(0.1)), boxShadow: const [BoxShadow(color: Color.fromRGBO(0,0,0,0.2), blurRadius: 32, offset: Offset(0, 8))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.local_fire_department, color: AppColors.secondary),
              Text('FOCUS STREAK', style: AppTextStyles.label.copyWith(fontSize: 12, color: AppColors.onSurfaceVariant)),
            ],
          ),
          SizedBox(height: 16),
          Text('14 Days', style: AppTextStyles.headline.copyWith(fontSize: 36, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(9999)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7,
              child: Container(decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(9999), boxShadow: const [BoxShadow(color: AppColors.secondary, blurRadius: 8)])),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShieldCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVariant.withOpacity(0.1)), boxShadow: const [BoxShadow(color: Color.fromRGBO(0,0,0,0.2), blurRadius: 32, offset: Offset(0, 8))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.security, color: AppColors.primary),
              Text('DISTRACTION SHIELD', style: AppTextStyles.label.copyWith(fontSize: 12, color: AppColors.onSurfaceVariant)),
            ],
          ),
          SizedBox(height: 16),
          Text('Active', style: AppTextStyles.headline.copyWith(fontSize: 36, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('34 blocks prevented today', style: AppTextStyles.body.copyWith(fontSize: 14, color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildWeeklyMomentum() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Weekly Momentum', style: AppTextStyles.headline.copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
              Text('MON — SUN', style: AppTextStyles.label.copyWith(fontSize: 12, color: AppColors.outlineVariant, letterSpacing: 1.2)),
            ],
          ),
          SizedBox(height: 32),
          SizedBox(
            height: 128,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBarGraphCol('M', 0.6, Color(0xFF767578), 48),
                _buildBarGraphCol('T', 0.85, AppColors.primary, 96, shadowColor: AppColors.primary),
                _buildBarGraphCol('W', 0.7, AppColors.primaryDim, 64),
                _buildBarGraphCol('T', 1.0, AppColors.secondary, 112, shadowColor: AppColors.secondary),
                _buildBarGraphCol('F', 0.75, AppColors.primary, 80),
                _buildBarGraphCol('S', 0.4, AppColors.outlineVariant, 32),
                _buildBarGraphCol('S', 0.5, AppColors.outlineVariant, 40),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBarGraphCol(String day, double fillFactor, Color color, double containerHeight, {Color? shadowColor}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: containerHeight,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(9999)),
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: fillFactor,
              child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(9999), boxShadow: shadowColor != null ? [BoxShadow(color: shadowColor.withOpacity(0.3), blurRadius: 15)] : null), width: double.infinity),
            ),
          ),
          SizedBox(height: 12),
          Text(day, style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.outlineVariant)),
        ],
      ),
    );
  }

  Widget _buildBalanceRing() {
    return Container(
      constraints: BoxConstraints(minHeight: 280),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          SizedBox(
            width: 128,
            height: 128,
            child: Stack(
              children: [
                CustomPaint(size: Size(128, 128), painter: _RingPainter()),
                Center(child: Text('BALANCE', style: AppTextStyles.label.copyWith(fontSize: 12))),
              ],
            ),
          ),
          SizedBox(width: 32),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Core Focus', style: AppTextStyles.headline.copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(height: 16),
                _buildLegendRow('Strategic Design', '45%', AppColors.primary),
                SizedBox(height: 8),
                _buildLegendRow('Deep Research', '30%', AppColors.secondary),
                SizedBox(height: 8),
                _buildLegendRow('Others', '25%', AppColors.outlineVariant),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLegendRow(String title, String percent, Color dotColor) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor)),
        SizedBox(width: 8),
        Text(title, style: AppTextStyles.body.copyWith(fontSize: 14, color: AppColors.onSurfaceVariant)),
        Spacer(),
        Text(percent, style: AppTextStyles.body.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuickStatsGrid() {
    return LayoutBuilder(builder: (context, constraints) {
      final crossCount = constraints.maxWidth < 400 ? 1 : 2;
      return GridView.count(
        crossAxisCount: crossCount,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.4,
        children: [
          _buildQuickStatCard('timer', '6.2h', 'Deep Work Avg', AppColors.tertiary),
          _buildQuickStatCard('task_alt', '182', 'Flow Tasks', AppColors.primary),
          _buildQuickStatCard('psychology', '92%', 'Mental Clarity', AppColors.secondary),
          _buildQuickStatCard('bolt', '450', 'Efficiency Pts', AppColors.tertiaryFixed),
        ],
      );
    });
  }

  Widget _buildQuickStatCard(String iconStr, String val, String title, Color iconColor) {
    IconData icon;
    switch(iconStr) {
      case 'timer': icon = Icons.timer; break;
      case 'task_alt': icon = Icons.task_alt; break;
      case 'psychology': icon = Icons.psychology; break;
      case 'bolt': icon = Icons.bolt; break;
      default: icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVariant.withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor),
          SizedBox(height: 12),
          Text(val, style: AppTextStyles.headline.copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(title, style: AppTextStyles.label.copyWith(fontSize: 12, color: AppColors.onSurfaceVariant, letterSpacing: 0.6)),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 4;
    paint.color = AppColors.surfaceVariant;
    canvas.drawArc(rect, 0, 2 * math.pi, false, paint);
    paint.color = AppColors.primary;
    double start1 = -math.pi / 2;
    double sweep1 = 2 * math.pi * 0.45;
    canvas.drawArc(rect, start1, sweep1, false, paint);
    paint.color = AppColors.secondary;
    double start2 = start1 + sweep1 + 0.1;
    double sweep2 = 2 * math.pi * 0.30;
    canvas.drawArc(rect, start2, sweep2, false, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
