import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/aurora_theme.dart';
import '../data/dashboard_repository.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _taskController = TextEditingController();
  late final DashboardRepository _repository;
  late DateTime _visibleMonth;
  late Future<DashboardSnapshot> _snapshotFuture;

  @override
  void initState() {
    super.initState();
    _repository = context.read<DashboardRepository>();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month);
    _snapshotFuture = _repository.loadSnapshot(month: _visibleMonth);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    final future = _repository.loadSnapshot(month: _visibleMonth);
    setState(() {
      _snapshotFuture = future;
    });
    await future;
  }

  Future<void> _changeMonth(int delta) async {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
      _snapshotFuture = _repository.loadSnapshot(month: _visibleMonth);
    });
  }

  Future<void> _addTask() async {
    final title = _taskController.text.trim();
    if (title.isEmpty) {
      return;
    }

    await _repository.addTodayTask(title);
    _taskController.clear();
    await _reload();
  }

  Future<void> _toggleTask(DashboardTaskItem task, bool value) async {
    await _repository.toggleTodayTask(task.id, value);
    await _reload();
  }

  Future<void> _deleteTask(DashboardTaskItem task) async {
    await _repository.deleteTodayTask(task.id);
    await _reload();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DashboardSnapshot>(
      future: _snapshotFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Unable to load your dashboard right now.',
                    style: AppTextStyles.h3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  AuroraTheme.gradientButton(
                    text: 'Try Again',
                    onPressed: () {
                      setState(() {
                        _snapshotFuture =
                            _repository.loadSnapshot(month: _visibleMonth);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        }

        final data = snapshot.data!;
        final isWide = MediaQuery.of(context).size.width >= 980;

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: _reload,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 140),
            children: [
              _buildHeader(data),
              const SizedBox(height: 24),
              _buildReflectionHero(data),
              const SizedBox(height: 24),
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: _buildCalendarCard(data),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 5,
                      child: _buildTodayTasksCard(data),
                    ),
                  ],
                )
              else ...[
                _buildCalendarCard(data),
                const SizedBox(height: 20),
                _buildTodayTasksCard(data),
              ],
              const SizedBox(height: 24),
              _buildProgressCard(data),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(DashboardSnapshot data) {
    final now = DateTime.now();
    final weekday = _weekdayLabel(now.weekday);
    final month = _monthLabel(now.month);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Dashboard',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(width: 12),
                Tooltip(
                  message: 'Sync Google Calendar & Tasks',
                 child: IconButton(
                    onPressed: _reload,
                    icon: Icon(Icons.sync_rounded, color: AppColors.secondary),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surfaceVariant.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '$weekday, $month ${now.day}',
              style: AppTextStyles.bodySecondary.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.surfaceContainerHigh,
                AppColors.surfaceContainerLow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.outlineVariant.withOpacity(0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Steps Today',
                style: AppTextStyles.label.copyWith(
                  fontSize: 11,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                data.stepsToday.toString(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.googleConnected
                    ? 'Live from Google Fit'
                    : 'Connect Google to sync steps',
                style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReflectionHero(DashboardSnapshot data) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;
          final ring = _ScoreRing(score: data.reflectionScore);
          final stats = Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildStatChip('Goals', '${data.completedGoalsToday}/${data.totalGoalsToday}'),
              _buildStatChip('Tasks', '${data.completedTasksToday}/${data.totalTasksToday}'),
              _buildStatChip('Focus', '${data.focusMinutesToday} min'),
              _buildStatChip('Streak', '${data.currentStreak} days'),
            ],
          );

          if (isWide) {
            return Row(
              children: [
                Expanded(child: ring),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Reflection Score', style: AppTextStyles.h3),
                      const SizedBox(height: 10),
                      Text(
                        data.verdict,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Your score blends steps, focus sessions, goals, tasks, and journaling so the day feels tangible instead of empty.',
                        style: AppTextStyles.bodySecondary,
                      ),
                      const SizedBox(height: 18),
                      stats,
                    ],
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              ring,
              const SizedBox(height: 18),
              Text('Reflection Score', style: AppTextStyles.h3),
              const SizedBox(height: 8),
              Text(
                data.verdict,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              stats,
            ],
          );
        },
      ),
    );
  }

  Widget _buildCalendarCard(DashboardSnapshot data) {
    final days = _buildMonthCells(data.month, data.highlightedDates);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${_monthLabel(data.month.month)} ${data.month.year}',
                style: AppTextStyles.h3,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _changeMonth(-1);
                },
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              IconButton(
                onPressed: () {
                  _changeMonth(1);
                },
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              _WeekdayCell(label: 'Mo'),
              _WeekdayCell(label: 'Tu'),
              _WeekdayCell(label: 'We'),
              _WeekdayCell(label: 'Th'),
              _WeekdayCell(label: 'Fr'),
              _WeekdayCell(label: 'Sa'),
              _WeekdayCell(label: 'Su'),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final cell = days[index];
              if (cell == null) {
                return const SizedBox.shrink();
              }

              return Container(
                decoration: BoxDecoration(
                  color: cell.isToday
                      ? AppColors.primary.withOpacity(0.18)
                      : AppColors.surfaceVariant.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: cell.isToday
                        ? AppColors.primary
                        : cell.isHighlighted
                            ? AppColors.secondary.withOpacity(0.6)
                            : Colors.transparent,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        '${cell.day.day}',
                        style: AppTextStyles.bodyPrimary.copyWith(
                          fontWeight: cell.isToday ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (cell.isHighlighted)
                      const Positioned(
                        right: 8,
                        top: 8,
                        child: _GlowDot(),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          if (data.todayEvents.isNotEmpty) ...[
            Text(
              'Synced Today',
              style: AppTextStyles.label.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 10),
            ...data.todayEvents.take(3).map(
              (event) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const _GlowDot(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        event.title,
                        style: AppTextStyles.bodyPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else
            Text(
              data.googleConnected
                  ? 'Your synced Google calendar events will appear here.'
                  : 'Google Calendar sync will light up this view after you reconnect Google with calendar permission.',
              style: AppTextStyles.bodySecondary,
            ),
        ],
      ),
    );
  }

  Widget _buildTodayTasksCard(DashboardSnapshot data) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Task List", style: AppTextStyles.h3),
          const SizedBox(height: 10),
          Text(
            'Every new task syncs to Google Calendar when Google access is available.',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 16),
          ...data.todayTasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      activeColor: AppColors.primary,
                      side: BorderSide(color: AppColors.outlineVariant.withOpacity(0.8)),
                      onChanged: (value) {
                        _toggleTask(task, value ?? false);
                      },
                    ),
                    Expanded(
                      child: Text(
                        task.title,
                        style: AppTextStyles.bodyPrimary.copyWith(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isCompleted
                              ? AppColors.onSurfaceVariant
                              : AppColors.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteTask(task);
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (data.todayTasks.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Add your first task for today and it will appear here immediately.',
                style: AppTextStyles.bodySecondary,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  onSubmitted: (_) {
                    _addTask();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Add a task for today',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 52,
                child: AuroraTheme.gradientButton(
                  text: 'Add',
                  onPressed: () {
                    _addTask();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(DashboardSnapshot data) {
    final progressPercent = (data.progressRatio * 100).round();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Progress", style: AppTextStyles.h3),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 16,
              value: data.progressRatio,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$progressPercent% complete',
                style: AppTextStyles.bodyPrimary,
              ),
              Text(
                '${data.completedGoalsToday + data.completedTasksToday} of ${data.totalGoalsToday + data.totalTasksToday} done',
                style: AppTextStyles.bodySecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.label.copyWith(
              fontSize: 10,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodyPrimary.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  List<_MonthCell?> _buildMonthCells(DateTime month, Set<String> highlights) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = firstDay.weekday - 1;
    final today = DateTime.now();

    return [
      ...List<_MonthCell?>.filled(leadingBlanks, null),
      for (int day = 1; day <= daysInMonth; day++)
        _MonthCell(
          day: DateTime(month.year, month.month, day),
          isToday:
              today.year == month.year && today.month == month.month && today.day == day,
          isHighlighted:
              highlights.contains(
                DateTime(month.year, month.month, day)
                    .toIso8601String()
                    .split('T')
                    .first,
              ),
        ),
    ];
  }

  String _monthLabel(int month) {
    const labels = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return labels[month - 1];
  }

  String _weekdayLabel(int weekday) {
    const labels = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return labels[weekday - 1];
  }
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.square(240),
            painter: _ScoreRingPainter(score),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                score.round().toString(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 72,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                'out of 100',
                style: AppTextStyles.bodySecondary.copyWith(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  _ScoreRingPainter(this.score);

  final double score;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 12;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..color = AppColors.surfaceVariant;
    final valuePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2, false, backgroundPaint);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * (score / 100),
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.score != score;
  }
}

class _WeekdayCell extends StatelessWidget {
  const _WeekdayCell({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.label.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class _GlowDot extends StatelessWidget {
  const _GlowDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.6),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}

class _MonthCell {
  const _MonthCell({
    required this.day,
    required this.isToday,
    required this.isHighlighted,
  });

  final DateTime day;
  final bool isToday;
  final bool isHighlighted;
}
