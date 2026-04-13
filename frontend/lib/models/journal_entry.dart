import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_entry.freezed.dart';
part 'journal_entry.g.dart';

@freezed
class JournalEntry with _$JournalEntry {
  const JournalEntry._();
  const factory JournalEntry({    required String id,
    required String userId,
    required String content,
    required int moodScore,
    required String date,
    required DateTime createdAt,
    DateTime? syncedAt,
  }) = _JournalEntry;

  factory JournalEntry.fromJson(Map<String, dynamic> json) => _$JournalEntryFromJson(json);
}
