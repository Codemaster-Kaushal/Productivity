import 'package:supabase_flutter/supabase_flutter.dart';

class ProcrastinationRepository {
  SupabaseClient get _supabase => Supabase.instance.client;
  String get _userId => _supabase.auth.currentUser?.id ?? '';

  /// Returns avg delay in minutes per subject
  Future<Map<String, double>> getAvgDelayBySubject() async {
    try {
      final response = await _supabase
          .from('goals')
          .select('subject, created_at, first_pomodoro_at')
          .eq('user_id', _userId)
          .not('first_pomodoro_at', 'is', null)
          .isFilter('deleted_at', null);

      final Map<String, List<double>> delaysBySubject = {};

      for (final row in (response as List)) {
        final subject = row['subject'] as String;
        final created = DateTime.parse(row['created_at']);
        final firstPomo = DateTime.parse(row['first_pomodoro_at']);
        final delayMinutes = firstPomo.difference(created).inMinutes.toDouble();

        if (delayMinutes >= 0) {
          delaysBySubject.putIfAbsent(subject, () => []);
          delaysBySubject[subject]!.add(delayMinutes);
        }
      }

      // Compute averages, filter subjects with ≥3 data points
      final Map<String, double> result = {};
      for (final entry in delaysBySubject.entries) {
        if (entry.value.length >= 3) {
          final avg = entry.value.reduce((a, b) => a + b) / entry.value.length;
          result[entry.key] = avg;
        }
      }

      return result;
    } catch (_) {
      return {};
    }
  }
}
