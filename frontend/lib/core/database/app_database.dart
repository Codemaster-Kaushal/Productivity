import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
part 'app_database.g.dart';

class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get subject => text()();
  TextColumn get date => text()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
  TextColumn? get semesterGoalId => text().nullable()();
  TextColumn? get focusWindowStart => text().nullable()();
  TextColumn? get focusWindowEnd => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn? get syncedAt => dateTime().nullable()();
  DateTimeColumn? get deletedAt => dateTime().nullable()(); // Added for soft deletes

  @override
  Set<Column> get primaryKey => {id};
}

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get date => text()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
  TextColumn? get linkedGoalId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn? get syncedAt => dateTime().nullable()();
  DateTimeColumn? get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PomodoroSessions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn? get linkedGoalId => text().nullable()();
  IntColumn get durationMinutes => integer().withDefault(Constant(25))();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn? get completedAt => dateTime().nullable()();
  TextColumn get idempotencyKey => text().unique()();
  DateTimeColumn? get syncedAt => dateTime().nullable()();
  DateTimeColumn? get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get date => text().unique()();
  TextColumn get content => text()();
  TextColumn? get aiPrompts => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn? get syncedAt => dateTime().nullable()();
  DateTimeColumn? get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncOperations extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get operationType => text()();
  TextColumn get payload => text()();
  TextColumn get idempotencyKey => text().unique()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn? get syncedAt => dateTime().nullable()();
  DateTimeColumn? get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class DailyScores extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get date => text()();
  IntColumn get trueScore => integer()();
  TextColumn get verdict => text()();
  IntColumn get big3Points => integer()();
  IntColumn get pomodoroPoints => integer()();
  IntColumn get taskPoints => integer()();
  IntColumn get journalPoints => integer()();
  IntColumn get activePoints => integer()();
  IntColumn get penaltyPoints => integer()();
  BoolColumn get focusBadgeEarned => boolean().withDefault(Constant(false))();
  DateTimeColumn? get syncedAt => dateTime().nullable()();
  DateTimeColumn? get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SemesterGoals extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get targetDate => text()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn? get syncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  Goals,
  Tasks,
  PomodoroSessions,
  JournalEntries,
  SyncOperations,
  DailyScores,
  SemesterGoals,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    if (kIsWeb) {
      return DatabaseConnection.delayed(Future(() async {
        final db = await WasmDatabase.open(
          databaseName: 'productivity_app',
          sqlite3Uri: Uri.parse('sqlite3.wasm'),
          driftWorkerUri: Uri.parse('drift_worker.js'),
        );
        return db.resolvedExecutor;
      }));
    }
    return driftDatabase(name: 'productivity_app');
  }
}
