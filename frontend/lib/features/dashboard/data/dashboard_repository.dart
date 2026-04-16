import 'dart:async';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/dio_client.dart';

class DashboardTaskItem {
  const DashboardTaskItem({
    required this.id,
    required this.title,
    required this.date,
    required this.isCompleted,
    required this.createdAt,
  });

  final String id;
  final String title;
  final DateTime date;
  final bool isCompleted;
  final DateTime createdAt;

  factory DashboardTaskItem.fromRow(Map<String, dynamic> row) {
    return DashboardTaskItem(
      id: row['id'] as String,
      title: row['title'] as String,
      date: DateTime.parse(row['date'] as String),
      isCompleted: row['is_completed'] as bool? ?? false,
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }
}

class DashboardCalendarEvent {
  const DashboardCalendarEvent({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.isAllDay,
  });

  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final bool isAllDay;

  factory DashboardCalendarEvent.fromGoogleJson(Map<String, dynamic> json) {
    final startMap = Map<String, dynamic>.from(json['start'] as Map);
    final endMap = Map<String, dynamic>.from(json['end'] as Map);
    final isAllDay = startMap['date'] != null;
    final start = DateTime.parse(
      (startMap['dateTime'] ?? startMap['date']) as String,
    );
    final end = DateTime.parse(
      (endMap['dateTime'] ?? endMap['date']) as String,
    );

    return DashboardCalendarEvent(
      id: json['id'] as String? ?? '',
      title: json['summary'] as String? ?? 'Untitled event',
      start: start,
      end: end,
      isAllDay: isAllDay,
    );
  }
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.month,
    required this.reflectionScore,
    required this.verdict,
    required this.currentStreak,
    required this.stepsToday,
    required this.focusMinutesToday,
    required this.completedGoalsToday,
    required this.totalGoalsToday,
    required this.completedTasksToday,
    required this.totalTasksToday,
    required this.progressRatio,
    required this.todayTasks,
    required this.todayEvents,
    required this.highlightedDates,
    required this.googleConnected,
  });

  final DateTime month;
  final double reflectionScore;
  final String verdict;
  final int currentStreak;
  final int stepsToday;
  final int focusMinutesToday;
  final int completedGoalsToday;
  final int totalGoalsToday;
  final int completedTasksToday;
  final int totalTasksToday;
  final double progressRatio;
  final List<DashboardTaskItem> todayTasks;
  final List<DashboardCalendarEvent> todayEvents;
  final Set<String> highlightedDates;
  final bool googleConnected;
}

class DashboardRepository {
  DashboardRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  Future<DashboardSnapshot> loadSnapshot({DateTime? month}) async {
    final now = DateTime.now();
    final selectedMonth = DateTime(month?.year ?? now.year, month?.month ?? now.month);
    final today = _isoDate(now);

    try {
      await _dioClient.get('/calendar/tasks/pull');
    } catch (_) {}

    final Future<List<dynamic>> tasksFuture = _supabase
        .from('tasks')
        .select('id, title, date, is_completed, created_at')
        .eq('user_id', _userId)
        .eq('date', today)
        .isFilter('deleted_at', null)
        .order('created_at');

    final Future<List<dynamic>> goalsFuture = _supabase
        .from('goals')
        .select('id, is_completed')
        .eq('user_id', _userId)
        .eq('date', today)
        .isFilter('deleted_at', null);

    final Future<List<dynamic>> pomodoroFuture = _supabase
        .from('pomodoro_sessions')
        .select('duration_minutes')
        .eq('user_id', _userId)
        .gte('started_at', '${today}T00:00:00')
        .not('completed_at', 'is', null);

    final Future<List<dynamic>> journalFuture = _supabase
        .from('journal_entries')
        .select('content')
        .eq('user_id', _userId)
        .eq('date', today)
        .limit(1);

    final Future<Map<String, dynamic>?> streakFuture = _supabase
        .from('user_profiles')
        .select('current_streak')
        .eq('id', _userId)
        .maybeSingle();

    final localHighlightsFuture = _loadLocalHighlightsForMonth(selectedMonth);
    final googleSyncFuture = _loadGoogleSyncForMonth(selectedMonth);

    final results = await Future.wait<dynamic>([
      tasksFuture,
      goalsFuture,
      pomodoroFuture,
      journalFuture,
      streakFuture,
      localHighlightsFuture,
      googleSyncFuture,
    ]);

    final taskRows = List<Map<String, dynamic>>.from(results[0] as List);
    final goalRows = List<Map<String, dynamic>>.from(results[1] as List);
    final pomodoroRows = List<Map<String, dynamic>>.from(results[2] as List);
    final journalRows = List<Map<String, dynamic>>.from(results[3] as List);
    final streakRow = results[4] as Map<String, dynamic>?;
    final localHighlights = results[5] as Set<String>;
    final googleSync = results[6] as _GoogleSyncSnapshot;

    final tasks = taskRows.map(DashboardTaskItem.fromRow).toList();
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final completedGoals =
        goalRows.where((goal) => goal['is_completed'] == true).length;
    final focusMinutes = pomodoroRows.fold<int>(
      0,
      (sum, row) => sum + ((row['duration_minutes'] as num?)?.toInt() ?? 0),
    );
    final journalPoints = journalRows.isNotEmpty &&
            ((journalRows.first['content'] as String?)?.trim().length ?? 0) >= 20
        ? 10
        : 0;
    final incompleteGoals = goalRows.length - completedGoals;
    final pomodoroPoints = _clampToRange((pomodoroRows.length * 10).toDouble(), 0, 30);
    final taskPoints = _clampToRange((completedTasks * 5).toDouble(), 0, 25);
    final activePoints = _clampToRange(((googleSync.stepsToday ~/ 1000) * 10).toDouble(), 0, 20);
    final rawScore =
        completedGoals * 30 + pomodoroPoints + taskPoints + journalPoints + activePoints - incompleteGoals * 20;
    final reflectionScore = _clampToRange(rawScore.toDouble(), 0, 100);
    final totalItems = goalRows.length + tasks.length;
    final completedItems = completedGoals + completedTasks;
    final progressRatio = totalItems == 0 ? 0.0 : completedItems / totalItems;

    return DashboardSnapshot(
      month: selectedMonth,
      reflectionScore: reflectionScore,
      verdict: _verdictForScore(reflectionScore),
      currentStreak: (streakRow?['current_streak'] as num?)?.toInt() ?? 0,
      stepsToday: googleSync.stepsToday,
      focusMinutesToday: focusMinutes,
      completedGoalsToday: completedGoals,
      totalGoalsToday: goalRows.length,
      completedTasksToday: completedTasks,
      totalTasksToday: tasks.length,
      progressRatio: progressRatio,
      todayTasks: tasks,
      todayEvents: googleSync.todayEvents,
      highlightedDates: {...localHighlights, ...googleSync.highlightedDates},
      googleConnected: googleSync.connected,
    );
  }

  Future<void> addTodayTask(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      return;
    }

    final inserted = await _supabase
        .from('tasks')
        .insert({
          'user_id': _userId,
          'title': trimmed,
          'date': _isoDate(DateTime.now()),
          'is_completed': false,
        })
        .select('id, title, date, is_completed, created_at')
        .single();

    final task = DashboardTaskItem.fromRow(Map<String, dynamic>.from(inserted));
    unawaited(_syncTaskToGoogleCalendar(task));
  }

  Future<void> toggleTodayTask(String taskId, bool isCompleted) async {
    await _supabase
        .from('tasks')
        .update({'is_completed': isCompleted})
        .eq('id', taskId)
        .eq('user_id', _userId);

    final row = await _supabase.from('tasks').select('id, title, date, is_completed, created_at').eq('id', taskId).single();
    final task = DashboardTaskItem.fromRow(Map<String, dynamic>.from(row as Map));
    unawaited(_syncTaskToGoogleCalendar(task));
  }

  Future<void> deleteTodayTask(String taskId) async {
    await _supabase
        .from('tasks')
        .update({'deleted_at': DateTime.now().toIso8601String()})
        .eq('id', taskId)
        .eq('user_id', _userId);
  }

  Future<double> getTodayScore() async => (await loadSnapshot()).reflectionScore;

  Future<int> getCurrentStreak() async => (await loadSnapshot()).currentStreak;

  Future<int> getShieldCount() async {
    try {
      final response = await _supabase
          .from('user_profiles')
          .select('shield_count')
          .eq('id', _userId)
          .single();
      return (response['shield_count'] as num?)?.toInt() ?? 0;
    } catch (_) {
      return 0;
    }
  }

  Future<int> getFocusMinutesToday() async => (await loadSnapshot()).focusMinutesToday;

  Future<int> getPomodoroCountToday() async {
    final today = _isoDate(DateTime.now());
    try {
      final response = await _supabase
          .from('pomodoro_sessions')
          .select('id')
          .eq('user_id', _userId)
          .gte('started_at', '${today}T00:00:00')
          .not('completed_at', 'is', null);
      return (response as List).length;
    } catch (_) {
      return 0;
    }
  }

  Future<int> getCompletedGoalsToday() async =>
      (await loadSnapshot()).completedGoalsToday;

  Future<int> getTotalGoalsToday() async => (await loadSnapshot()).totalGoalsToday;

  Future<int> getCompletedTasksToday() async =>
      (await loadSnapshot()).completedTasksToday;

  Future<List<double>> getLast7Scores() async {
    final now = DateTime.now();
    final scores = <double>[];

    for (int offset = 6; offset >= 0; offset--) {
      final day = now.subtract(Duration(days: offset));
      final dayString = _isoDate(day);

      try {
        final goalsResponse = await _supabase
            .from('goals')
            .select('id, is_completed')
            .eq('user_id', _userId)
            .eq('date', dayString)
            .isFilter('deleted_at', null);
        final tasksResponse = await _supabase
            .from('tasks')
            .select('id, is_completed')
            .eq('user_id', _userId)
            .eq('date', dayString)
            .isFilter('deleted_at', null);

        final goals = List<Map<String, dynamic>>.from(goalsResponse);
        final tasks = List<Map<String, dynamic>>.from(tasksResponse);
        final completedGoals =
            goals.where((goal) => goal['is_completed'] == true).length;
        final completedTasks =
            tasks.where((task) => task['is_completed'] == true).length;
        final score = _clampToRange(
          (completedGoals * 30 + completedTasks * 5 - (goals.length - completedGoals) * 20)
              .toDouble(),
          0,
          100,
        );
        scores.add(score);
      } catch (_) {
        scores.add(-1);
      }
    }

    return scores;
  }

  Future<Map<String, int>> getSubjectDistribution() async {
    final today = _isoDate(DateTime.now());
    try {
      final response = await _supabase
          .from('goals')
          .select('subject')
          .eq('user_id', _userId)
          .eq('date', today)
          .isFilter('deleted_at', null);

      final distribution = <String, int>{};
      for (final row in response as List) {
        final subject = row['subject'] as String? ?? 'General';
        distribution[subject] = (distribution[subject] ?? 0) + 1;
      }
      return distribution;
    } catch (_) {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getUpcomingDeadlines() async {
    final today = _isoDate(DateTime.now());
    try {
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('user_id', _userId)
          .eq('is_completed', false)
          .isFilter('deleted_at', null)
          .gte('date', today)
          .order('date')
          .limit(5);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  Future<_GoogleSyncSnapshot> _loadGoogleSyncForMonth(DateTime month) async {
    final events = await _loadGoogleEvents(month);
    final todayString = _isoDate(DateTime.now());
    return _GoogleSyncSnapshot(
      stepsToday: events.stepsToday,
      todayEvents: events.events
          .where((event) => _isoDate(event.start) == todayString)
          .toList(),
      highlightedDates: events.events
          .map((event) => _isoDate(event.start))
          .toSet(),
      connected: events.connected,
    );
  }

  Future<_GoogleEventsResponse> _loadGoogleEvents(DateTime month) async {
    try {
      final response = await Future.wait([
        _dioClient.get('/calendar/month', queryParameters: {
          'month': '${month.year.toString().padLeft(4, '0')}-${month.month.toString().padLeft(2, '0')}',
        }),
        _dioClient.get('/calendar/steps/today'),
      ]);

      final calendarPayload = Map<String, dynamic>.from(
        response[0].data as Map<String, dynamic>,
      );
      final stepsPayload = Map<String, dynamic>.from(
        response[1].data as Map<String, dynamic>,
      );

      final events = (calendarPayload['data'] as List? ?? const [])
          .map((item) => DashboardCalendarEvent.fromGoogleJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList();

      return _GoogleEventsResponse(
        connected: (calendarPayload['connected'] as bool?) ??
            (stepsPayload['connected'] as bool?) ??
            false,
        stepsToday: (stepsPayload['data'] as num?)?.toInt() ?? 0,
        events: events,
      );
    } on DioException {
      return const _GoogleEventsResponse(
        connected: false,
        stepsToday: 0,
        events: [],
      );
    }
  }

  Future<Set<String>> _loadLocalHighlightsForMonth(DateTime month) async {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0);

    final results = await Future.wait([
      _supabase
          .from('tasks')
          .select('date')
          .eq('user_id', _userId)
          .isFilter('deleted_at', null)
          .gte('date', _isoDate(monthStart))
          .lte('date', _isoDate(monthEnd)),
      _supabase
          .from('goals')
          .select('date')
          .eq('user_id', _userId)
          .isFilter('deleted_at', null)
          .gte('date', _isoDate(monthStart))
          .lte('date', _isoDate(monthEnd)),
    ]);

    final highlightedDates = <String>{};
    for (final result in results) {
      for (final row in result as List) {
        highlightedDates.add(row['date'] as String);
      }
    }
    return highlightedDates;
  }

  Future<void> _syncTaskToGoogleCalendar(DashboardTaskItem task) async {
    try {
      await _dioClient.post(
        '/calendar/tasks/sync',
        data: {
          'task_id': task.id,
          'title': task.title,
          'date': _isoDate(task.date),
          'is_completed': task.isCompleted,
        },
      );
    } on DioException {
      // Keep local save successful even when Google sync is unavailable.
    }
  }

  String _isoDate(DateTime value) =>
      value.toIso8601String().split('T').first;

  double _clampToRange(double value, num min, num max) {
    if (value < min) return min.toDouble();
    if (value > max) return max.toDouble();
    return value;
  }

  String _verdictForScore(double score) {
    if (score >= 90) return 'Very Good';
    if (score >= 75) return 'Strong';
    if (score >= 60) return 'On Track';
    if (score >= 40) return 'Warming Up';
    return 'Needs Momentum';
  }
}

class _GoogleSyncSnapshot {
  const _GoogleSyncSnapshot({
    required this.stepsToday,
    required this.todayEvents,
    required this.highlightedDates,
    required this.connected,
  });

  final int stepsToday;
  final List<DashboardCalendarEvent> todayEvents;
  final Set<String> highlightedDates;
  final bool connected;
}

class _GoogleEventsResponse {
  const _GoogleEventsResponse({
    required this.connected,
    required this.stepsToday,
    required this.events,
  });

  final bool connected;
  final int stepsToday;
  final List<DashboardCalendarEvent> events;
}
