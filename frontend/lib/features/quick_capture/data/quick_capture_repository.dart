import 'package:supabase_flutter/supabase_flutter.dart';

class ParsedCapture {
  final String title;
  final String? subject;
  final DateTime? dueDate;
  final String type; // 'task' or 'goal'

  ParsedCapture({
    required this.title,
    this.subject,
    this.dueDate,
    this.type = 'task',
  });
}

class QuickCaptureRepository {
  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  // Known subject keywords for auto-detection
  static const _subjectKeywords = {
    'math': 'Mathematics',
    'maths': 'Mathematics',
    'mathematics': 'Mathematics',
    'physics': 'Physics',
    'chemistry': 'Chemistry',
    'bio': 'Biology',
    'biology': 'Biology',
    'cs': 'Computer Science',
    'dsa': 'DSA',
    'algo': 'Algorithms',
    'english': 'English',
    'history': 'History',
    'economics': 'Economics',
    'psychology': 'Psychology',
    'stats': 'Statistics',
    'statistics': 'Statistics',
    'accounting': 'Accounting',
    'programming': 'Programming',
    'calculus': 'Calculus',
    'linear algebra': 'Linear Algebra',
  };

  // Day-name to date mapping
  static final _dayNames = {
    'monday': DateTime.monday,
    'tuesday': DateTime.tuesday,
    'wednesday': DateTime.wednesday,
    'thursday': DateTime.thursday,
    'friday': DateTime.friday,
    'saturday': DateTime.saturday,
    'sunday': DateTime.sunday,
  };

  ParsedCapture parseInput(String input) {
    final lower = input.toLowerCase().trim();

    // 1. Detect due date
    DateTime? dueDate;

    if (lower.contains('tomorrow')) {
      dueDate = DateTime.now().add(Duration(days: 1));
    } else if (lower.contains('today')) {
      dueDate = DateTime.now();
    } else {
      // Check for day names
      for (final entry in _dayNames.entries) {
        if (lower.contains(entry.key)) {
          final now = DateTime.now();
          int daysUntil = entry.value - now.weekday;
          if (daysUntil <= 0) daysUntil += 7;
          dueDate = now.add(Duration(days: daysUntil));
          break;
        }
      }
    }

    // 2. Detect subject
    String? subject;
    for (final entry in _subjectKeywords.entries) {
      if (lower.contains(entry.key)) {
        subject = entry.value;
        break;
      }
    }

    // 3. Clean title — remove date/time words
    String title = input.trim();
    final removePatterns = [
      RegExp(r'\bby\s+(tomorrow|today|monday|tuesday|wednesday|thursday|friday|saturday|sunday)\b', caseSensitive: false),
      RegExp(r'\b(before|due|until)\s+(tomorrow|today|monday|tuesday|wednesday|thursday|friday|saturday|sunday)\b', caseSensitive: false),
    ];
    for (final pattern in removePatterns) {
      title = title.replaceAll(pattern, '').trim();
    }

    // Capitalize first letter
    if (title.isNotEmpty) {
      title = title[0].toUpperCase() + title.substring(1);
    }

    // 4. Determine type — if "goal" is mentioned, treat as goal
    final type = lower.contains('goal') ? 'goal' : 'task';

    return ParsedCapture(
      title: title,
      subject: subject,
      dueDate: dueDate,
      type: type,
    );
  }

  Future<void> saveCapture(ParsedCapture capture) async {
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (capture.type == 'goal') {
      await _supabase.from('goals').insert({
        'user_id': _userId,
        'title': capture.title,
        'subject': capture.subject ?? 'General',
        'date': today,
        'is_completed': false,
      });
    } else {
      await _supabase.from('tasks').insert({
        'user_id': _userId,
        'title': capture.title,
        'date': today,
        'is_completed': false,
        'source': 'quick_capture',
        if (capture.dueDate != null)
          'due_date': capture.dueDate!.toIso8601String().split('T')[0],
      });
    }
  }
}
