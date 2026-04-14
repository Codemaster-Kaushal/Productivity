// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$GoalsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = VerificationMeta('id');
@override
late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _userIdMeta = VerificationMeta('userId');
@override
late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _titleMeta = VerificationMeta('title');
@override
late final GeneratedColumn<String> title = GeneratedColumn<String>('title', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _subjectMeta = VerificationMeta('subject');
@override
late final GeneratedColumn<String> subject = GeneratedColumn<String>('subject', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _dateMeta = VerificationMeta('date');
@override
late final GeneratedColumn<String> date = GeneratedColumn<String>('date', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _isCompletedMeta = VerificationMeta('isCompleted');
@override
late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>('is_completed', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_completed" IN (0, 1))'), defaultValue: Constant(false));
static const VerificationMeta _semesterGoalIdMeta = VerificationMeta('semesterGoalId');
@override
late final GeneratedColumn<String> semesterGoalId = GeneratedColumn<String>('semester_goal_id', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _focusWindowStartMeta = VerificationMeta('focusWindowStart');
@override
late final GeneratedColumn<String> focusWindowStart = GeneratedColumn<String>('focus_window_start', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _focusWindowEndMeta = VerificationMeta('focusWindowEnd');
@override
late final GeneratedColumn<String> focusWindowEnd = GeneratedColumn<String>('focus_window_end', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');
@override
late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>('synced_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
static const VerificationMeta _deletedAtMeta = VerificationMeta('deletedAt');
@override
late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, userId, title, subject, date, isCompleted, semesterGoalId, focusWindowStart, focusWindowEnd, createdAt, syncedAt, deletedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'goals';
@override
VerificationContext validateIntegrity(Insertable<Goal> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));} else if (isInserting) {
context.missing(_idMeta);
}
if (data.containsKey('user_id')) {
context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));} else if (isInserting) {
context.missing(_userIdMeta);
}
if (data.containsKey('title')) {
context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));} else if (isInserting) {
context.missing(_titleMeta);
}
if (data.containsKey('subject')) {
context.handle(_subjectMeta, subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));} else if (isInserting) {
context.missing(_subjectMeta);
}
if (data.containsKey('date')) {
context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));} else if (isInserting) {
context.missing(_dateMeta);
}
if (data.containsKey('is_completed')) {
context.handle(_isCompletedMeta, isCompleted.isAcceptableOrUnknown(data['is_completed']!, _isCompletedMeta));}if (data.containsKey('semester_goal_id')) {
context.handle(_semesterGoalIdMeta, semesterGoalId.isAcceptableOrUnknown(data['semester_goal_id']!, _semesterGoalIdMeta));}if (data.containsKey('focus_window_start')) {
context.handle(_focusWindowStartMeta, focusWindowStart.isAcceptableOrUnknown(data['focus_window_start']!, _focusWindowStartMeta));}if (data.containsKey('focus_window_end')) {
context.handle(_focusWindowEndMeta, focusWindowEnd.isAcceptableOrUnknown(data['focus_window_end']!, _focusWindowEndMeta));}if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('synced_at')) {
context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));}if (data.containsKey('deleted_at')) {
context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override Goal map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return Goal(id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!, userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!, title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!, subject: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}subject'])!, date: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}date'])!, isCompleted: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!, semesterGoalId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}semester_goal_id']), focusWindowStart: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}focus_window_start']), focusWindowEnd: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}focus_window_end']), createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']), deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']), );
}
@override
$GoalsTable createAlias(String alias) {
return $GoalsTable(attachedDatabase, alias);}}class Goal extends DataClass implements Insertable<Goal> 
{
final String id;
final String userId;
final String title;
final String subject;
final String date;
final bool isCompleted;
final String? semesterGoalId;
final String? focusWindowStart;
final String? focusWindowEnd;
final DateTime createdAt;
final DateTime? syncedAt;
final DateTime? deletedAt;
Goal({required this.id, required this.userId, required this.title, required this.subject, required this.date, required this.isCompleted, this.semesterGoalId, this.focusWindowStart, this.focusWindowEnd, required this.createdAt, this.syncedAt, this.deletedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<String>(id);
map['user_id'] = Variable<String>(userId);
map['title'] = Variable<String>(title);
map['subject'] = Variable<String>(subject);
map['date'] = Variable<String>(date);
map['is_completed'] = Variable<bool>(isCompleted);
if (!nullToAbsent || semesterGoalId != null){map['semester_goal_id'] = Variable<String>(semesterGoalId);
}if (!nullToAbsent || focusWindowStart != null){map['focus_window_start'] = Variable<String>(focusWindowStart);
}if (!nullToAbsent || focusWindowEnd != null){map['focus_window_end'] = Variable<String>(focusWindowEnd);
}map['created_at'] = Variable<DateTime>(createdAt);
if (!nullToAbsent || syncedAt != null){map['synced_at'] = Variable<DateTime>(syncedAt);
}if (!nullToAbsent || deletedAt != null){map['deleted_at'] = Variable<DateTime>(deletedAt);
}return map; 
}
GoalsCompanion toCompanion(bool nullToAbsent) {
return GoalsCompanion(id: Value(id),userId: Value(userId),title: Value(title),subject: Value(subject),date: Value(date),isCompleted: Value(isCompleted),semesterGoalId: semesterGoalId == null && nullToAbsent ? const Value.absent() : Value(semesterGoalId),focusWindowStart: focusWindowStart == null && nullToAbsent ? const Value.absent() : Value(focusWindowStart),focusWindowEnd: focusWindowEnd == null && nullToAbsent ? const Value.absent() : Value(focusWindowEnd),createdAt: Value(createdAt),syncedAt: syncedAt == null && nullToAbsent ? const Value.absent() : Value(syncedAt),deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),);
}
factory Goal.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return Goal(id: serializer.fromJson<String>(json['id']),userId: serializer.fromJson<String>(json['userId']),title: serializer.fromJson<String>(json['title']),subject: serializer.fromJson<String>(json['subject']),date: serializer.fromJson<String>(json['date']),isCompleted: serializer.fromJson<bool>(json['isCompleted']),semesterGoalId: serializer.fromJson<String?>(json['semesterGoalId']),focusWindowStart: serializer.fromJson<String?>(json['focusWindowStart']),focusWindowEnd: serializer.fromJson<String?>(json['focusWindowEnd']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<String>(id),'userId': serializer.toJson<String>(userId),'title': serializer.toJson<String>(title),'subject': serializer.toJson<String>(subject),'date': serializer.toJson<String>(date),'isCompleted': serializer.toJson<bool>(isCompleted),'semesterGoalId': serializer.toJson<String?>(semesterGoalId),'focusWindowStart': serializer.toJson<String?>(focusWindowStart),'focusWindowEnd': serializer.toJson<String?>(focusWindowEnd),'createdAt': serializer.toJson<DateTime>(createdAt),'syncedAt': serializer.toJson<DateTime?>(syncedAt),'deletedAt': serializer.toJson<DateTime?>(deletedAt),};}Goal copyWith({String? id,String? userId,String? title,String? subject,String? date,bool? isCompleted,Value<String?> semesterGoalId = const Value.absent(),Value<String?> focusWindowStart = const Value.absent(),Value<String?> focusWindowEnd = const Value.absent(),DateTime? createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent()}) => Goal(id: id ?? this.id,userId: userId ?? this.userId,title: title ?? this.title,subject: subject ?? this.subject,date: date ?? this.date,isCompleted: isCompleted ?? this.isCompleted,semesterGoalId: semesterGoalId.present ? semesterGoalId.value : this.semesterGoalId,focusWindowStart: focusWindowStart.present ? focusWindowStart.value : this.focusWindowStart,focusWindowEnd: focusWindowEnd.present ? focusWindowEnd.value : this.focusWindowEnd,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,);Goal copyWithCompanion(GoalsCompanion data) {
return Goal(
id: data.id.present ? data.id.value : this.id,userId: data.userId.present ? data.userId.value : this.userId,title: data.title.present ? data.title.value : this.title,subject: data.subject.present ? data.subject.value : this.subject,date: data.date.present ? data.date.value : this.date,isCompleted: data.isCompleted.present ? data.isCompleted.value : this.isCompleted,semesterGoalId: data.semesterGoalId.present ? data.semesterGoalId.value : this.semesterGoalId,focusWindowStart: data.focusWindowStart.present ? data.focusWindowStart.value : this.focusWindowStart,focusWindowEnd: data.focusWindowEnd.present ? data.focusWindowEnd.value : this.focusWindowEnd,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,);
}
@override
String toString() {return (StringBuffer('Goal(')..write('id: $id, ')..write('userId: $userId, ')..write('title: $title, ')..write('subject: $subject, ')..write('date: $date, ')..write('isCompleted: $isCompleted, ')..write('semesterGoalId: $semesterGoalId, ')..write('focusWindowStart: $focusWindowStart, ')..write('focusWindowEnd: $focusWindowEnd, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, userId, title, subject, date, isCompleted, semesterGoalId, focusWindowStart, focusWindowEnd, createdAt, syncedAt, deletedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is Goal && other.id == this.id && other.userId == this.userId && other.title == this.title && other.subject == this.subject && other.date == this.date && other.isCompleted == this.isCompleted && other.semesterGoalId == this.semesterGoalId && other.focusWindowStart == this.focusWindowStart && other.focusWindowEnd == this.focusWindowEnd && other.createdAt == this.createdAt && other.syncedAt == this.syncedAt && other.deletedAt == this.deletedAt);
}class GoalsCompanion extends UpdateCompanion<Goal> {
final Value<String> id;
final Value<String> userId;
final Value<String> title;
final Value<String> subject;
final Value<String> date;
final Value<bool> isCompleted;
final Value<String?> semesterGoalId;
final Value<String?> focusWindowStart;
final Value<String?> focusWindowEnd;
final Value<DateTime> createdAt;
final Value<DateTime?> syncedAt;
final Value<DateTime?> deletedAt;
final Value<int> rowid;
GoalsCompanion({this.id = const Value.absent(),this.userId = const Value.absent(),this.title = const Value.absent(),this.subject = const Value.absent(),this.date = const Value.absent(),this.isCompleted = const Value.absent(),this.semesterGoalId = const Value.absent(),this.focusWindowStart = const Value.absent(),this.focusWindowEnd = const Value.absent(),this.createdAt = const Value.absent(),this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),});
GoalsCompanion.insert({required String id,required String userId,required String title,required String subject,required String date,this.isCompleted = const Value.absent(),this.semesterGoalId = const Value.absent(),this.focusWindowStart = const Value.absent(),this.focusWindowEnd = const Value.absent(),required DateTime createdAt,this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),}): id = Value(id), userId = Value(userId), title = Value(title), subject = Value(subject), date = Value(date), createdAt = Value(createdAt);
static Insertable<Goal> custom({Expression<String>? id, 
Expression<String>? userId, 
Expression<String>? title, 
Expression<String>? subject, 
Expression<String>? date, 
Expression<bool>? isCompleted, 
Expression<String>? semesterGoalId, 
Expression<String>? focusWindowStart, 
Expression<String>? focusWindowEnd, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? syncedAt, 
Expression<DateTime>? deletedAt, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (userId != null)'user_id': userId,if (title != null)'title': title,if (subject != null)'subject': subject,if (date != null)'date': date,if (isCompleted != null)'is_completed': isCompleted,if (semesterGoalId != null)'semester_goal_id': semesterGoalId,if (focusWindowStart != null)'focus_window_start': focusWindowStart,if (focusWindowEnd != null)'focus_window_end': focusWindowEnd,if (createdAt != null)'created_at': createdAt,if (syncedAt != null)'synced_at': syncedAt,if (deletedAt != null)'deleted_at': deletedAt,if (rowid != null)'rowid': rowid,});
}GoalsCompanion copyWith({Value<String>? id, Value<String>? userId, Value<String>? title, Value<String>? subject, Value<String>? date, Value<bool>? isCompleted, Value<String?>? semesterGoalId, Value<String?>? focusWindowStart, Value<String?>? focusWindowEnd, Value<DateTime>? createdAt, Value<DateTime?>? syncedAt, Value<DateTime?>? deletedAt, Value<int>? rowid}) {
return GoalsCompanion(id: id ?? this.id,userId: userId ?? this.userId,title: title ?? this.title,subject: subject ?? this.subject,date: date ?? this.date,isCompleted: isCompleted ?? this.isCompleted,semesterGoalId: semesterGoalId ?? this.semesterGoalId,focusWindowStart: focusWindowStart ?? this.focusWindowStart,focusWindowEnd: focusWindowEnd ?? this.focusWindowEnd,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt ?? this.syncedAt,deletedAt: deletedAt ?? this.deletedAt,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<String>(id.value);}
if (userId.present) {
map['user_id'] = Variable<String>(userId.value);}
if (title.present) {
map['title'] = Variable<String>(title.value);}
if (subject.present) {
map['subject'] = Variable<String>(subject.value);}
if (date.present) {
map['date'] = Variable<String>(date.value);}
if (isCompleted.present) {
map['is_completed'] = Variable<bool>(isCompleted.value);}
if (semesterGoalId.present) {
map['semester_goal_id'] = Variable<String>(semesterGoalId.value);}
if (focusWindowStart.present) {
map['focus_window_start'] = Variable<String>(focusWindowStart.value);}
if (focusWindowEnd.present) {
map['focus_window_end'] = Variable<String>(focusWindowEnd.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (syncedAt.present) {
map['synced_at'] = Variable<DateTime>(syncedAt.value);}
if (deletedAt.present) {
map['deleted_at'] = Variable<DateTime>(deletedAt.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('GoalsCompanion(')..write('id: $id, ')..write('userId: $userId, ')..write('title: $title, ')..write('subject: $subject, ')..write('date: $date, ')..write('isCompleted: $isCompleted, ')..write('semesterGoalId: $semesterGoalId, ')..write('focusWindowStart: $focusWindowStart, ')..write('focusWindowEnd: $focusWindowEnd, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt, ')..write('rowid: $rowid')..write(')')).toString();}
}
class $TasksTable extends Tasks with TableInfo<$TasksTable, Task>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$TasksTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = VerificationMeta('id');
@override
late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _userIdMeta = VerificationMeta('userId');
@override
late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _titleMeta = VerificationMeta('title');
@override
late final GeneratedColumn<String> title = GeneratedColumn<String>('title', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _dateMeta = VerificationMeta('date');
@override
late final GeneratedColumn<String> date = GeneratedColumn<String>('date', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _isCompletedMeta = VerificationMeta('isCompleted');
@override
late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>('is_completed', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_completed" IN (0, 1))'), defaultValue: Constant(false));
static const VerificationMeta _linkedGoalIdMeta = VerificationMeta('linkedGoalId');
@override
late final GeneratedColumn<String> linkedGoalId = GeneratedColumn<String>('linked_goal_id', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');
@override
late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>('synced_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
static const VerificationMeta _deletedAtMeta = VerificationMeta('deletedAt');
@override
late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, userId, title, date, isCompleted, linkedGoalId, createdAt, syncedAt, deletedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'tasks';
@override
VerificationContext validateIntegrity(Insertable<Task> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));} else if (isInserting) {
context.missing(_idMeta);
}
if (data.containsKey('user_id')) {
context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));} else if (isInserting) {
context.missing(_userIdMeta);
}
if (data.containsKey('title')) {
context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));} else if (isInserting) {
context.missing(_titleMeta);
}
if (data.containsKey('date')) {
context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));} else if (isInserting) {
context.missing(_dateMeta);
}
if (data.containsKey('is_completed')) {
context.handle(_isCompletedMeta, isCompleted.isAcceptableOrUnknown(data['is_completed']!, _isCompletedMeta));}if (data.containsKey('linked_goal_id')) {
context.handle(_linkedGoalIdMeta, linkedGoalId.isAcceptableOrUnknown(data['linked_goal_id']!, _linkedGoalIdMeta));}if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('synced_at')) {
context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));}if (data.containsKey('deleted_at')) {
context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override Task map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return Task(id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!, userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!, title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!, date: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}date'])!, isCompleted: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!, linkedGoalId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}linked_goal_id']), createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']), deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']), );
}
@override
$TasksTable createAlias(String alias) {
return $TasksTable(attachedDatabase, alias);}}class Task extends DataClass implements Insertable<Task> 
{
final String id;
final String userId;
final String title;
final String date;
final bool isCompleted;
final String? linkedGoalId;
final DateTime createdAt;
final DateTime? syncedAt;
final DateTime? deletedAt;
Task({required this.id, required this.userId, required this.title, required this.date, required this.isCompleted, this.linkedGoalId, required this.createdAt, this.syncedAt, this.deletedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<String>(id);
map['user_id'] = Variable<String>(userId);
map['title'] = Variable<String>(title);
map['date'] = Variable<String>(date);
map['is_completed'] = Variable<bool>(isCompleted);
if (!nullToAbsent || linkedGoalId != null){map['linked_goal_id'] = Variable<String>(linkedGoalId);
}map['created_at'] = Variable<DateTime>(createdAt);
if (!nullToAbsent || syncedAt != null){map['synced_at'] = Variable<DateTime>(syncedAt);
}if (!nullToAbsent || deletedAt != null){map['deleted_at'] = Variable<DateTime>(deletedAt);
}return map; 
}
TasksCompanion toCompanion(bool nullToAbsent) {
return TasksCompanion(id: Value(id),userId: Value(userId),title: Value(title),date: Value(date),isCompleted: Value(isCompleted),linkedGoalId: linkedGoalId == null && nullToAbsent ? const Value.absent() : Value(linkedGoalId),createdAt: Value(createdAt),syncedAt: syncedAt == null && nullToAbsent ? const Value.absent() : Value(syncedAt),deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),);
}
factory Task.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return Task(id: serializer.fromJson<String>(json['id']),userId: serializer.fromJson<String>(json['userId']),title: serializer.fromJson<String>(json['title']),date: serializer.fromJson<String>(json['date']),isCompleted: serializer.fromJson<bool>(json['isCompleted']),linkedGoalId: serializer.fromJson<String?>(json['linkedGoalId']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<String>(id),'userId': serializer.toJson<String>(userId),'title': serializer.toJson<String>(title),'date': serializer.toJson<String>(date),'isCompleted': serializer.toJson<bool>(isCompleted),'linkedGoalId': serializer.toJson<String?>(linkedGoalId),'createdAt': serializer.toJson<DateTime>(createdAt),'syncedAt': serializer.toJson<DateTime?>(syncedAt),'deletedAt': serializer.toJson<DateTime?>(deletedAt),};}Task copyWith({String? id,String? userId,String? title,String? date,bool? isCompleted,Value<String?> linkedGoalId = const Value.absent(),DateTime? createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent()}) => Task(id: id ?? this.id,userId: userId ?? this.userId,title: title ?? this.title,date: date ?? this.date,isCompleted: isCompleted ?? this.isCompleted,linkedGoalId: linkedGoalId.present ? linkedGoalId.value : this.linkedGoalId,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,);Task copyWithCompanion(TasksCompanion data) {
return Task(
id: data.id.present ? data.id.value : this.id,userId: data.userId.present ? data.userId.value : this.userId,title: data.title.present ? data.title.value : this.title,date: data.date.present ? data.date.value : this.date,isCompleted: data.isCompleted.present ? data.isCompleted.value : this.isCompleted,linkedGoalId: data.linkedGoalId.present ? data.linkedGoalId.value : this.linkedGoalId,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,);
}
@override
String toString() {return (StringBuffer('Task(')..write('id: $id, ')..write('userId: $userId, ')..write('title: $title, ')..write('date: $date, ')..write('isCompleted: $isCompleted, ')..write('linkedGoalId: $linkedGoalId, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, userId, title, date, isCompleted, linkedGoalId, createdAt, syncedAt, deletedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is Task && other.id == this.id && other.userId == this.userId && other.title == this.title && other.date == this.date && other.isCompleted == this.isCompleted && other.linkedGoalId == this.linkedGoalId && other.createdAt == this.createdAt && other.syncedAt == this.syncedAt && other.deletedAt == this.deletedAt);
}class TasksCompanion extends UpdateCompanion<Task> {
final Value<String> id;
final Value<String> userId;
final Value<String> title;
final Value<String> date;
final Value<bool> isCompleted;
final Value<String?> linkedGoalId;
final Value<DateTime> createdAt;
final Value<DateTime?> syncedAt;
final Value<DateTime?> deletedAt;
final Value<int> rowid;
TasksCompanion({this.id = const Value.absent(),this.userId = const Value.absent(),this.title = const Value.absent(),this.date = const Value.absent(),this.isCompleted = const Value.absent(),this.linkedGoalId = const Value.absent(),this.createdAt = const Value.absent(),this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),});
TasksCompanion.insert({required String id,required String userId,required String title,required String date,this.isCompleted = const Value.absent(),this.linkedGoalId = const Value.absent(),required DateTime createdAt,this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),}): id = Value(id), userId = Value(userId), title = Value(title), date = Value(date), createdAt = Value(createdAt);
static Insertable<Task> custom({Expression<String>? id, 
Expression<String>? userId, 
Expression<String>? title, 
Expression<String>? date, 
Expression<bool>? isCompleted, 
Expression<String>? linkedGoalId, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? syncedAt, 
Expression<DateTime>? deletedAt, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (userId != null)'user_id': userId,if (title != null)'title': title,if (date != null)'date': date,if (isCompleted != null)'is_completed': isCompleted,if (linkedGoalId != null)'linked_goal_id': linkedGoalId,if (createdAt != null)'created_at': createdAt,if (syncedAt != null)'synced_at': syncedAt,if (deletedAt != null)'deleted_at': deletedAt,if (rowid != null)'rowid': rowid,});
}TasksCompanion copyWith({Value<String>? id, Value<String>? userId, Value<String>? title, Value<String>? date, Value<bool>? isCompleted, Value<String?>? linkedGoalId, Value<DateTime>? createdAt, Value<DateTime?>? syncedAt, Value<DateTime?>? deletedAt, Value<int>? rowid}) {
return TasksCompanion(id: id ?? this.id,userId: userId ?? this.userId,title: title ?? this.title,date: date ?? this.date,isCompleted: isCompleted ?? this.isCompleted,linkedGoalId: linkedGoalId ?? this.linkedGoalId,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt ?? this.syncedAt,deletedAt: deletedAt ?? this.deletedAt,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<String>(id.value);}
if (userId.present) {
map['user_id'] = Variable<String>(userId.value);}
if (title.present) {
map['title'] = Variable<String>(title.value);}
if (date.present) {
map['date'] = Variable<String>(date.value);}
if (isCompleted.present) {
map['is_completed'] = Variable<bool>(isCompleted.value);}
if (linkedGoalId.present) {
map['linked_goal_id'] = Variable<String>(linkedGoalId.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (syncedAt.present) {
map['synced_at'] = Variable<DateTime>(syncedAt.value);}
if (deletedAt.present) {
map['deleted_at'] = Variable<DateTime>(deletedAt.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('TasksCompanion(')..write('id: $id, ')..write('userId: $userId, ')..write('title: $title, ')..write('date: $date, ')..write('isCompleted: $isCompleted, ')..write('linkedGoalId: $linkedGoalId, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt, ')..write('rowid: $rowid')..write(')')).toString();}
}
class $PomodoroSessionsTable extends PomodoroSessions with TableInfo<$PomodoroSessionsTable, PomodoroSession>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$PomodoroSessionsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = VerificationMeta('id');
@override
late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _userIdMeta = VerificationMeta('userId');
@override
late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _linkedGoalIdMeta = VerificationMeta('linkedGoalId');
@override
late final GeneratedColumn<String> linkedGoalId = GeneratedColumn<String>('linked_goal_id', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _durationMinutesMeta = VerificationMeta('durationMinutes');
@override
late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>('duration_minutes', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: Constant(25));
static const VerificationMeta _startedAtMeta = VerificationMeta('startedAt');
@override
late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>('started_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _completedAtMeta = VerificationMeta('completedAt');
@override
late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>('completed_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
static const VerificationMeta _idempotencyKeyMeta = VerificationMeta('idempotencyKey');
@override
late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>('idempotency_key', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');
@override
late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>('synced_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
static const VerificationMeta _deletedAtMeta = VerificationMeta('deletedAt');
@override
late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, userId, linkedGoalId, durationMinutes, startedAt, completedAt, idempotencyKey, syncedAt, deletedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'pomodoro_sessions';
@override
VerificationContext validateIntegrity(Insertable<PomodoroSession> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));} else if (isInserting) {
context.missing(_idMeta);
}
if (data.containsKey('user_id')) {
context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));} else if (isInserting) {
context.missing(_userIdMeta);
}
if (data.containsKey('linked_goal_id')) {
context.handle(_linkedGoalIdMeta, linkedGoalId.isAcceptableOrUnknown(data['linked_goal_id']!, _linkedGoalIdMeta));}if (data.containsKey('duration_minutes')) {
context.handle(_durationMinutesMeta, durationMinutes.isAcceptableOrUnknown(data['duration_minutes']!, _durationMinutesMeta));}if (data.containsKey('started_at')) {
context.handle(_startedAtMeta, startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));} else if (isInserting) {
context.missing(_startedAtMeta);
}
if (data.containsKey('completed_at')) {
context.handle(_completedAtMeta, completedAt.isAcceptableOrUnknown(data['completed_at']!, _completedAtMeta));}if (data.containsKey('idempotency_key')) {
context.handle(_idempotencyKeyMeta, idempotencyKey.isAcceptableOrUnknown(data['idempotency_key']!, _idempotencyKeyMeta));} else if (isInserting) {
context.missing(_idempotencyKeyMeta);
}
if (data.containsKey('synced_at')) {
context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));}if (data.containsKey('deleted_at')) {
context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override PomodoroSession map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return PomodoroSession(id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!, userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!, linkedGoalId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}linked_goal_id']), durationMinutes: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!, startedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!, completedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']), idempotencyKey: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}idempotency_key'])!, syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']), deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']), );
}
@override
$PomodoroSessionsTable createAlias(String alias) {
return $PomodoroSessionsTable(attachedDatabase, alias);}}class PomodoroSession extends DataClass implements Insertable<PomodoroSession> 
{
final String id;
final String userId;
final String? linkedGoalId;
final int durationMinutes;
final DateTime startedAt;
final DateTime? completedAt;
final String idempotencyKey;
final DateTime? syncedAt;
final DateTime? deletedAt;
PomodoroSession({required this.id, required this.userId, this.linkedGoalId, required this.durationMinutes, required this.startedAt, this.completedAt, required this.idempotencyKey, this.syncedAt, this.deletedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<String>(id);
map['user_id'] = Variable<String>(userId);
if (!nullToAbsent || linkedGoalId != null){map['linked_goal_id'] = Variable<String>(linkedGoalId);
}map['duration_minutes'] = Variable<int>(durationMinutes);
map['started_at'] = Variable<DateTime>(startedAt);
if (!nullToAbsent || completedAt != null){map['completed_at'] = Variable<DateTime>(completedAt);
}map['idempotency_key'] = Variable<String>(idempotencyKey);
if (!nullToAbsent || syncedAt != null){map['synced_at'] = Variable<DateTime>(syncedAt);
}if (!nullToAbsent || deletedAt != null){map['deleted_at'] = Variable<DateTime>(deletedAt);
}return map; 
}
PomodoroSessionsCompanion toCompanion(bool nullToAbsent) {
return PomodoroSessionsCompanion(id: Value(id),userId: Value(userId),linkedGoalId: linkedGoalId == null && nullToAbsent ? const Value.absent() : Value(linkedGoalId),durationMinutes: Value(durationMinutes),startedAt: Value(startedAt),completedAt: completedAt == null && nullToAbsent ? const Value.absent() : Value(completedAt),idempotencyKey: Value(idempotencyKey),syncedAt: syncedAt == null && nullToAbsent ? const Value.absent() : Value(syncedAt),deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),);
}
factory PomodoroSession.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return PomodoroSession(id: serializer.fromJson<String>(json['id']),userId: serializer.fromJson<String>(json['userId']),linkedGoalId: serializer.fromJson<String?>(json['linkedGoalId']),durationMinutes: serializer.fromJson<int>(json['durationMinutes']),startedAt: serializer.fromJson<DateTime>(json['startedAt']),completedAt: serializer.fromJson<DateTime?>(json['completedAt']),idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<String>(id),'userId': serializer.toJson<String>(userId),'linkedGoalId': serializer.toJson<String?>(linkedGoalId),'durationMinutes': serializer.toJson<int>(durationMinutes),'startedAt': serializer.toJson<DateTime>(startedAt),'completedAt': serializer.toJson<DateTime?>(completedAt),'idempotencyKey': serializer.toJson<String>(idempotencyKey),'syncedAt': serializer.toJson<DateTime?>(syncedAt),'deletedAt': serializer.toJson<DateTime?>(deletedAt),};}PomodoroSession copyWith({String? id,String? userId,Value<String?> linkedGoalId = const Value.absent(),int? durationMinutes,DateTime? startedAt,Value<DateTime?> completedAt = const Value.absent(),String? idempotencyKey,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent()}) => PomodoroSession(id: id ?? this.id,userId: userId ?? this.userId,linkedGoalId: linkedGoalId.present ? linkedGoalId.value : this.linkedGoalId,durationMinutes: durationMinutes ?? this.durationMinutes,startedAt: startedAt ?? this.startedAt,completedAt: completedAt.present ? completedAt.value : this.completedAt,idempotencyKey: idempotencyKey ?? this.idempotencyKey,syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,);PomodoroSession copyWithCompanion(PomodoroSessionsCompanion data) {
return PomodoroSession(
id: data.id.present ? data.id.value : this.id,userId: data.userId.present ? data.userId.value : this.userId,linkedGoalId: data.linkedGoalId.present ? data.linkedGoalId.value : this.linkedGoalId,durationMinutes: data.durationMinutes.present ? data.durationMinutes.value : this.durationMinutes,startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,completedAt: data.completedAt.present ? data.completedAt.value : this.completedAt,idempotencyKey: data.idempotencyKey.present ? data.idempotencyKey.value : this.idempotencyKey,syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,);
}
@override
String toString() {return (StringBuffer('PomodoroSession(')..write('id: $id, ')..write('userId: $userId, ')..write('linkedGoalId: $linkedGoalId, ')..write('durationMinutes: $durationMinutes, ')..write('startedAt: $startedAt, ')..write('completedAt: $completedAt, ')..write('idempotencyKey: $idempotencyKey, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, userId, linkedGoalId, durationMinutes, startedAt, completedAt, idempotencyKey, syncedAt, deletedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is PomodoroSession && other.id == this.id && other.userId == this.userId && other.linkedGoalId == this.linkedGoalId && other.durationMinutes == this.durationMinutes && other.startedAt == this.startedAt && other.completedAt == this.completedAt && other.idempotencyKey == this.idempotencyKey && other.syncedAt == this.syncedAt && other.deletedAt == this.deletedAt);
}class PomodoroSessionsCompanion extends UpdateCompanion<PomodoroSession> {
final Value<String> id;
final Value<String> userId;
final Value<String?> linkedGoalId;
final Value<int> durationMinutes;
final Value<DateTime> startedAt;
final Value<DateTime?> completedAt;
final Value<String> idempotencyKey;
final Value<DateTime?> syncedAt;
final Value<DateTime?> deletedAt;
final Value<int> rowid;
PomodoroSessionsCompanion({this.id = const Value.absent(),this.userId = const Value.absent(),this.linkedGoalId = const Value.absent(),this.durationMinutes = const Value.absent(),this.startedAt = const Value.absent(),this.completedAt = const Value.absent(),this.idempotencyKey = const Value.absent(),this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),});
PomodoroSessionsCompanion.insert({required String id,required String userId,this.linkedGoalId = const Value.absent(),this.durationMinutes = const Value.absent(),required DateTime startedAt,this.completedAt = const Value.absent(),required String idempotencyKey,this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),}): id = Value(id), userId = Value(userId), startedAt = Value(startedAt), idempotencyKey = Value(idempotencyKey);
static Insertable<PomodoroSession> custom({Expression<String>? id, 
Expression<String>? userId, 
Expression<String>? linkedGoalId, 
Expression<int>? durationMinutes, 
Expression<DateTime>? startedAt, 
Expression<DateTime>? completedAt, 
Expression<String>? idempotencyKey, 
Expression<DateTime>? syncedAt, 
Expression<DateTime>? deletedAt, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (userId != null)'user_id': userId,if (linkedGoalId != null)'linked_goal_id': linkedGoalId,if (durationMinutes != null)'duration_minutes': durationMinutes,if (startedAt != null)'started_at': startedAt,if (completedAt != null)'completed_at': completedAt,if (idempotencyKey != null)'idempotency_key': idempotencyKey,if (syncedAt != null)'synced_at': syncedAt,if (deletedAt != null)'deleted_at': deletedAt,if (rowid != null)'rowid': rowid,});
}PomodoroSessionsCompanion copyWith({Value<String>? id, Value<String>? userId, Value<String?>? linkedGoalId, Value<int>? durationMinutes, Value<DateTime>? startedAt, Value<DateTime?>? completedAt, Value<String>? idempotencyKey, Value<DateTime?>? syncedAt, Value<DateTime?>? deletedAt, Value<int>? rowid}) {
return PomodoroSessionsCompanion(id: id ?? this.id,userId: userId ?? this.userId,linkedGoalId: linkedGoalId ?? this.linkedGoalId,durationMinutes: durationMinutes ?? this.durationMinutes,startedAt: startedAt ?? this.startedAt,completedAt: completedAt ?? this.completedAt,idempotencyKey: idempotencyKey ?? this.idempotencyKey,syncedAt: syncedAt ?? this.syncedAt,deletedAt: deletedAt ?? this.deletedAt,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<String>(id.value);}
if (userId.present) {
map['user_id'] = Variable<String>(userId.value);}
if (linkedGoalId.present) {
map['linked_goal_id'] = Variable<String>(linkedGoalId.value);}
if (durationMinutes.present) {
map['duration_minutes'] = Variable<int>(durationMinutes.value);}
if (startedAt.present) {
map['started_at'] = Variable<DateTime>(startedAt.value);}
if (completedAt.present) {
map['completed_at'] = Variable<DateTime>(completedAt.value);}
if (idempotencyKey.present) {
map['idempotency_key'] = Variable<String>(idempotencyKey.value);}
if (syncedAt.present) {
map['synced_at'] = Variable<DateTime>(syncedAt.value);}
if (deletedAt.present) {
map['deleted_at'] = Variable<DateTime>(deletedAt.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('PomodoroSessionsCompanion(')..write('id: $id, ')..write('userId: $userId, ')..write('linkedGoalId: $linkedGoalId, ')..write('durationMinutes: $durationMinutes, ')..write('startedAt: $startedAt, ')..write('completedAt: $completedAt, ')..write('idempotencyKey: $idempotencyKey, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt, ')..write('rowid: $rowid')..write(')')).toString();}
}
class $JournalEntriesTable extends JournalEntries with TableInfo<$JournalEntriesTable, JournalEntry>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$JournalEntriesTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = VerificationMeta('id');
@override
late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _userIdMeta = VerificationMeta('userId');
@override
late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _dateMeta = VerificationMeta('date');
@override
late final GeneratedColumn<String> date = GeneratedColumn<String>('date', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _contentMeta = VerificationMeta('content');
@override
late final GeneratedColumn<String> content = GeneratedColumn<String>('content', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _aiPromptsMeta = VerificationMeta('aiPrompts');
@override
late final GeneratedColumn<String> aiPrompts = GeneratedColumn<String>('ai_prompts', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');
@override
late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>('synced_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
static const VerificationMeta _deletedAtMeta = VerificationMeta('deletedAt');
@override
late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, userId, date, content, aiPrompts, createdAt, syncedAt, deletedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'journal_entries';
@override
VerificationContext validateIntegrity(Insertable<JournalEntry> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));} else if (isInserting) {
context.missing(_idMeta);
}
if (data.containsKey('user_id')) {
context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));} else if (isInserting) {
context.missing(_userIdMeta);
}
if (data.containsKey('date')) {
context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));} else if (isInserting) {
context.missing(_dateMeta);
}
if (data.containsKey('content')) {
context.handle(_contentMeta, content.isAcceptableOrUnknown(data['content']!, _contentMeta));} else if (isInserting) {
context.missing(_contentMeta);
}
if (data.containsKey('ai_prompts')) {
context.handle(_aiPromptsMeta, aiPrompts.isAcceptableOrUnknown(data['ai_prompts']!, _aiPromptsMeta));}if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('synced_at')) {
context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));}if (data.containsKey('deleted_at')) {
context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override JournalEntry map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return JournalEntry(id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!, userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!, date: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}date'])!, content: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}content'])!, aiPrompts: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}ai_prompts']), createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']), deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']), );
}
@override
$JournalEntriesTable createAlias(String alias) {
return $JournalEntriesTable(attachedDatabase, alias);}}class JournalEntry extends DataClass implements Insertable<JournalEntry> 
{
final String id;
final String userId;
final String date;
final String content;
final String? aiPrompts;
final DateTime createdAt;
final DateTime? syncedAt;
final DateTime? deletedAt;
JournalEntry({required this.id, required this.userId, required this.date, required this.content, this.aiPrompts, required this.createdAt, this.syncedAt, this.deletedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<String>(id);
map['user_id'] = Variable<String>(userId);
map['date'] = Variable<String>(date);
map['content'] = Variable<String>(content);
if (!nullToAbsent || aiPrompts != null){map['ai_prompts'] = Variable<String>(aiPrompts);
}map['created_at'] = Variable<DateTime>(createdAt);
if (!nullToAbsent || syncedAt != null){map['synced_at'] = Variable<DateTime>(syncedAt);
}if (!nullToAbsent || deletedAt != null){map['deleted_at'] = Variable<DateTime>(deletedAt);
}return map; 
}
JournalEntriesCompanion toCompanion(bool nullToAbsent) {
return JournalEntriesCompanion(id: Value(id),userId: Value(userId),date: Value(date),content: Value(content),aiPrompts: aiPrompts == null && nullToAbsent ? const Value.absent() : Value(aiPrompts),createdAt: Value(createdAt),syncedAt: syncedAt == null && nullToAbsent ? const Value.absent() : Value(syncedAt),deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),);
}
factory JournalEntry.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return JournalEntry(id: serializer.fromJson<String>(json['id']),userId: serializer.fromJson<String>(json['userId']),date: serializer.fromJson<String>(json['date']),content: serializer.fromJson<String>(json['content']),aiPrompts: serializer.fromJson<String?>(json['aiPrompts']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<String>(id),'userId': serializer.toJson<String>(userId),'date': serializer.toJson<String>(date),'content': serializer.toJson<String>(content),'aiPrompts': serializer.toJson<String?>(aiPrompts),'createdAt': serializer.toJson<DateTime>(createdAt),'syncedAt': serializer.toJson<DateTime?>(syncedAt),'deletedAt': serializer.toJson<DateTime?>(deletedAt),};}JournalEntry copyWith({String? id,String? userId,String? date,String? content,Value<String?> aiPrompts = const Value.absent(),DateTime? createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent()}) => JournalEntry(id: id ?? this.id,userId: userId ?? this.userId,date: date ?? this.date,content: content ?? this.content,aiPrompts: aiPrompts.present ? aiPrompts.value : this.aiPrompts,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,);JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
return JournalEntry(
id: data.id.present ? data.id.value : this.id,userId: data.userId.present ? data.userId.value : this.userId,date: data.date.present ? data.date.value : this.date,content: data.content.present ? data.content.value : this.content,aiPrompts: data.aiPrompts.present ? data.aiPrompts.value : this.aiPrompts,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,);
}
@override
String toString() {return (StringBuffer('JournalEntry(')..write('id: $id, ')..write('userId: $userId, ')..write('date: $date, ')..write('content: $content, ')..write('aiPrompts: $aiPrompts, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, userId, date, content, aiPrompts, createdAt, syncedAt, deletedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is JournalEntry && other.id == this.id && other.userId == this.userId && other.date == this.date && other.content == this.content && other.aiPrompts == this.aiPrompts && other.createdAt == this.createdAt && other.syncedAt == this.syncedAt && other.deletedAt == this.deletedAt);
}class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
final Value<String> id;
final Value<String> userId;
final Value<String> date;
final Value<String> content;
final Value<String?> aiPrompts;
final Value<DateTime> createdAt;
final Value<DateTime?> syncedAt;
final Value<DateTime?> deletedAt;
final Value<int> rowid;
JournalEntriesCompanion({this.id = const Value.absent(),this.userId = const Value.absent(),this.date = const Value.absent(),this.content = const Value.absent(),this.aiPrompts = const Value.absent(),this.createdAt = const Value.absent(),this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),});
JournalEntriesCompanion.insert({required String id,required String userId,required String date,required String content,this.aiPrompts = const Value.absent(),required DateTime createdAt,this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),}): id = Value(id), userId = Value(userId), date = Value(date), content = Value(content), createdAt = Value(createdAt);
static Insertable<JournalEntry> custom({Expression<String>? id, 
Expression<String>? userId, 
Expression<String>? date, 
Expression<String>? content, 
Expression<String>? aiPrompts, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? syncedAt, 
Expression<DateTime>? deletedAt, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (userId != null)'user_id': userId,if (date != null)'date': date,if (content != null)'content': content,if (aiPrompts != null)'ai_prompts': aiPrompts,if (createdAt != null)'created_at': createdAt,if (syncedAt != null)'synced_at': syncedAt,if (deletedAt != null)'deleted_at': deletedAt,if (rowid != null)'rowid': rowid,});
}JournalEntriesCompanion copyWith({Value<String>? id, Value<String>? userId, Value<String>? date, Value<String>? content, Value<String?>? aiPrompts, Value<DateTime>? createdAt, Value<DateTime?>? syncedAt, Value<DateTime?>? deletedAt, Value<int>? rowid}) {
return JournalEntriesCompanion(id: id ?? this.id,userId: userId ?? this.userId,date: date ?? this.date,content: content ?? this.content,aiPrompts: aiPrompts ?? this.aiPrompts,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt ?? this.syncedAt,deletedAt: deletedAt ?? this.deletedAt,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<String>(id.value);}
if (userId.present) {
map['user_id'] = Variable<String>(userId.value);}
if (date.present) {
map['date'] = Variable<String>(date.value);}
if (content.present) {
map['content'] = Variable<String>(content.value);}
if (aiPrompts.present) {
map['ai_prompts'] = Variable<String>(aiPrompts.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (syncedAt.present) {
map['synced_at'] = Variable<DateTime>(syncedAt.value);}
if (deletedAt.present) {
map['deleted_at'] = Variable<DateTime>(deletedAt.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('JournalEntriesCompanion(')..write('id: $id, ')..write('userId: $userId, ')..write('date: $date, ')..write('content: $content, ')..write('aiPrompts: $aiPrompts, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt, ')..write('rowid: $rowid')..write(')')).toString();}
}
class $SyncOperationsTable extends SyncOperations with TableInfo<$SyncOperationsTable, SyncOperation>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$SyncOperationsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = VerificationMeta('id');
@override
late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _userIdMeta = VerificationMeta('userId');
@override
late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _operationTypeMeta = VerificationMeta('operationType');
@override
late final GeneratedColumn<String> operationType = GeneratedColumn<String>('operation_type', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _payloadMeta = VerificationMeta('payload');
@override
late final GeneratedColumn<String> payload = GeneratedColumn<String>('payload', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _idempotencyKeyMeta = VerificationMeta('idempotencyKey');
@override
late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>('idempotency_key', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true, defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');
@override
late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>('synced_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
static const VerificationMeta _deletedAtMeta = VerificationMeta('deletedAt');
@override
late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, userId, operationType, payload, idempotencyKey, createdAt, syncedAt, deletedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'sync_operations';
@override
VerificationContext validateIntegrity(Insertable<SyncOperation> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));} else if (isInserting) {
context.missing(_idMeta);
}
if (data.containsKey('user_id')) {
context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));} else if (isInserting) {
context.missing(_userIdMeta);
}
if (data.containsKey('operation_type')) {
context.handle(_operationTypeMeta, operationType.isAcceptableOrUnknown(data['operation_type']!, _operationTypeMeta));} else if (isInserting) {
context.missing(_operationTypeMeta);
}
if (data.containsKey('payload')) {
context.handle(_payloadMeta, payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));} else if (isInserting) {
context.missing(_payloadMeta);
}
if (data.containsKey('idempotency_key')) {
context.handle(_idempotencyKeyMeta, idempotencyKey.isAcceptableOrUnknown(data['idempotency_key']!, _idempotencyKeyMeta));} else if (isInserting) {
context.missing(_idempotencyKeyMeta);
}
if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('synced_at')) {
context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));}if (data.containsKey('deleted_at')) {
context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override SyncOperation map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return SyncOperation(id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!, userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!, operationType: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}operation_type'])!, payload: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}payload'])!, idempotencyKey: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}idempotency_key'])!, createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']), deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']), );
}
@override
$SyncOperationsTable createAlias(String alias) {
return $SyncOperationsTable(attachedDatabase, alias);}}class SyncOperation extends DataClass implements Insertable<SyncOperation> 
{
final String id;
final String userId;
final String operationType;
final String payload;
final String idempotencyKey;
final DateTime createdAt;
final DateTime? syncedAt;
final DateTime? deletedAt;
SyncOperation({required this.id, required this.userId, required this.operationType, required this.payload, required this.idempotencyKey, required this.createdAt, this.syncedAt, this.deletedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<String>(id);
map['user_id'] = Variable<String>(userId);
map['operation_type'] = Variable<String>(operationType);
map['payload'] = Variable<String>(payload);
map['idempotency_key'] = Variable<String>(idempotencyKey);
map['created_at'] = Variable<DateTime>(createdAt);
if (!nullToAbsent || syncedAt != null){map['synced_at'] = Variable<DateTime>(syncedAt);
}if (!nullToAbsent || deletedAt != null){map['deleted_at'] = Variable<DateTime>(deletedAt);
}return map; 
}
SyncOperationsCompanion toCompanion(bool nullToAbsent) {
return SyncOperationsCompanion(id: Value(id),userId: Value(userId),operationType: Value(operationType),payload: Value(payload),idempotencyKey: Value(idempotencyKey),createdAt: Value(createdAt),syncedAt: syncedAt == null && nullToAbsent ? const Value.absent() : Value(syncedAt),deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),);
}
factory SyncOperation.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return SyncOperation(id: serializer.fromJson<String>(json['id']),userId: serializer.fromJson<String>(json['userId']),operationType: serializer.fromJson<String>(json['operationType']),payload: serializer.fromJson<String>(json['payload']),idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<String>(id),'userId': serializer.toJson<String>(userId),'operationType': serializer.toJson<String>(operationType),'payload': serializer.toJson<String>(payload),'idempotencyKey': serializer.toJson<String>(idempotencyKey),'createdAt': serializer.toJson<DateTime>(createdAt),'syncedAt': serializer.toJson<DateTime?>(syncedAt),'deletedAt': serializer.toJson<DateTime?>(deletedAt),};}SyncOperation copyWith({String? id,String? userId,String? operationType,String? payload,String? idempotencyKey,DateTime? createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent()}) => SyncOperation(id: id ?? this.id,userId: userId ?? this.userId,operationType: operationType ?? this.operationType,payload: payload ?? this.payload,idempotencyKey: idempotencyKey ?? this.idempotencyKey,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,);SyncOperation copyWithCompanion(SyncOperationsCompanion data) {
return SyncOperation(
id: data.id.present ? data.id.value : this.id,userId: data.userId.present ? data.userId.value : this.userId,operationType: data.operationType.present ? data.operationType.value : this.operationType,payload: data.payload.present ? data.payload.value : this.payload,idempotencyKey: data.idempotencyKey.present ? data.idempotencyKey.value : this.idempotencyKey,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,);
}
@override
String toString() {return (StringBuffer('SyncOperation(')..write('id: $id, ')..write('userId: $userId, ')..write('operationType: $operationType, ')..write('payload: $payload, ')..write('idempotencyKey: $idempotencyKey, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, userId, operationType, payload, idempotencyKey, createdAt, syncedAt, deletedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is SyncOperation && other.id == this.id && other.userId == this.userId && other.operationType == this.operationType && other.payload == this.payload && other.idempotencyKey == this.idempotencyKey && other.createdAt == this.createdAt && other.syncedAt == this.syncedAt && other.deletedAt == this.deletedAt);
}class SyncOperationsCompanion extends UpdateCompanion<SyncOperation> {
final Value<String> id;
final Value<String> userId;
final Value<String> operationType;
final Value<String> payload;
final Value<String> idempotencyKey;
final Value<DateTime> createdAt;
final Value<DateTime?> syncedAt;
final Value<DateTime?> deletedAt;
final Value<int> rowid;
SyncOperationsCompanion({this.id = const Value.absent(),this.userId = const Value.absent(),this.operationType = const Value.absent(),this.payload = const Value.absent(),this.idempotencyKey = const Value.absent(),this.createdAt = const Value.absent(),this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),});
SyncOperationsCompanion.insert({required String id,required String userId,required String operationType,required String payload,required String idempotencyKey,required DateTime createdAt,this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),}): id = Value(id), userId = Value(userId), operationType = Value(operationType), payload = Value(payload), idempotencyKey = Value(idempotencyKey), createdAt = Value(createdAt);
static Insertable<SyncOperation> custom({Expression<String>? id, 
Expression<String>? userId, 
Expression<String>? operationType, 
Expression<String>? payload, 
Expression<String>? idempotencyKey, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? syncedAt, 
Expression<DateTime>? deletedAt, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (userId != null)'user_id': userId,if (operationType != null)'operation_type': operationType,if (payload != null)'payload': payload,if (idempotencyKey != null)'idempotency_key': idempotencyKey,if (createdAt != null)'created_at': createdAt,if (syncedAt != null)'synced_at': syncedAt,if (deletedAt != null)'deleted_at': deletedAt,if (rowid != null)'rowid': rowid,});
}SyncOperationsCompanion copyWith({Value<String>? id, Value<String>? userId, Value<String>? operationType, Value<String>? payload, Value<String>? idempotencyKey, Value<DateTime>? createdAt, Value<DateTime?>? syncedAt, Value<DateTime?>? deletedAt, Value<int>? rowid}) {
return SyncOperationsCompanion(id: id ?? this.id,userId: userId ?? this.userId,operationType: operationType ?? this.operationType,payload: payload ?? this.payload,idempotencyKey: idempotencyKey ?? this.idempotencyKey,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt ?? this.syncedAt,deletedAt: deletedAt ?? this.deletedAt,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<String>(id.value);}
if (userId.present) {
map['user_id'] = Variable<String>(userId.value);}
if (operationType.present) {
map['operation_type'] = Variable<String>(operationType.value);}
if (payload.present) {
map['payload'] = Variable<String>(payload.value);}
if (idempotencyKey.present) {
map['idempotency_key'] = Variable<String>(idempotencyKey.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (syncedAt.present) {
map['synced_at'] = Variable<DateTime>(syncedAt.value);}
if (deletedAt.present) {
map['deleted_at'] = Variable<DateTime>(deletedAt.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('SyncOperationsCompanion(')..write('id: $id, ')..write('userId: $userId, ')..write('operationType: $operationType, ')..write('payload: $payload, ')..write('idempotencyKey: $idempotencyKey, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt, ')..write('rowid: $rowid')..write(')')).toString();}
}
class $DailyScoresTable extends DailyScores with TableInfo<$DailyScoresTable, DailyScore>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$DailyScoresTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = VerificationMeta('id');
@override
late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _userIdMeta = VerificationMeta('userId');
@override
late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _dateMeta = VerificationMeta('date');
@override
late final GeneratedColumn<String> date = GeneratedColumn<String>('date', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _trueScoreMeta = VerificationMeta('trueScore');
@override
late final GeneratedColumn<int> trueScore = GeneratedColumn<int>('true_score', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _verdictMeta = VerificationMeta('verdict');
@override
late final GeneratedColumn<String> verdict = GeneratedColumn<String>('verdict', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _big3PointsMeta = VerificationMeta('big3Points');
@override
late final GeneratedColumn<int> big3Points = GeneratedColumn<int>('big3_points', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _pomodoroPointsMeta = VerificationMeta('pomodoroPoints');
@override
late final GeneratedColumn<int> pomodoroPoints = GeneratedColumn<int>('pomodoro_points', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _taskPointsMeta = VerificationMeta('taskPoints');
@override
late final GeneratedColumn<int> taskPoints = GeneratedColumn<int>('task_points', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _journalPointsMeta = VerificationMeta('journalPoints');
@override
late final GeneratedColumn<int> journalPoints = GeneratedColumn<int>('journal_points', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _activePointsMeta = VerificationMeta('activePoints');
@override
late final GeneratedColumn<int> activePoints = GeneratedColumn<int>('active_points', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _penaltyPointsMeta = VerificationMeta('penaltyPoints');
@override
late final GeneratedColumn<int> penaltyPoints = GeneratedColumn<int>('penalty_points', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
static const VerificationMeta _focusBadgeEarnedMeta = VerificationMeta('focusBadgeEarned');
@override
late final GeneratedColumn<bool> focusBadgeEarned = GeneratedColumn<bool>('focus_badge_earned', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("focus_badge_earned" IN (0, 1))'), defaultValue: Constant(false));
static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');
@override
late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>('synced_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
static const VerificationMeta _deletedAtMeta = VerificationMeta('deletedAt');
@override
late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, userId, date, trueScore, verdict, big3Points, pomodoroPoints, taskPoints, journalPoints, activePoints, penaltyPoints, focusBadgeEarned, syncedAt, deletedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'daily_scores';
@override
VerificationContext validateIntegrity(Insertable<DailyScore> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));} else if (isInserting) {
context.missing(_idMeta);
}
if (data.containsKey('user_id')) {
context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));} else if (isInserting) {
context.missing(_userIdMeta);
}
if (data.containsKey('date')) {
context.handle(_dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));} else if (isInserting) {
context.missing(_dateMeta);
}
if (data.containsKey('true_score')) {
context.handle(_trueScoreMeta, trueScore.isAcceptableOrUnknown(data['true_score']!, _trueScoreMeta));} else if (isInserting) {
context.missing(_trueScoreMeta);
}
if (data.containsKey('verdict')) {
context.handle(_verdictMeta, verdict.isAcceptableOrUnknown(data['verdict']!, _verdictMeta));} else if (isInserting) {
context.missing(_verdictMeta);
}
if (data.containsKey('big3_points')) {
context.handle(_big3PointsMeta, big3Points.isAcceptableOrUnknown(data['big3_points']!, _big3PointsMeta));} else if (isInserting) {
context.missing(_big3PointsMeta);
}
if (data.containsKey('pomodoro_points')) {
context.handle(_pomodoroPointsMeta, pomodoroPoints.isAcceptableOrUnknown(data['pomodoro_points']!, _pomodoroPointsMeta));} else if (isInserting) {
context.missing(_pomodoroPointsMeta);
}
if (data.containsKey('task_points')) {
context.handle(_taskPointsMeta, taskPoints.isAcceptableOrUnknown(data['task_points']!, _taskPointsMeta));} else if (isInserting) {
context.missing(_taskPointsMeta);
}
if (data.containsKey('journal_points')) {
context.handle(_journalPointsMeta, journalPoints.isAcceptableOrUnknown(data['journal_points']!, _journalPointsMeta));} else if (isInserting) {
context.missing(_journalPointsMeta);
}
if (data.containsKey('active_points')) {
context.handle(_activePointsMeta, activePoints.isAcceptableOrUnknown(data['active_points']!, _activePointsMeta));} else if (isInserting) {
context.missing(_activePointsMeta);
}
if (data.containsKey('penalty_points')) {
context.handle(_penaltyPointsMeta, penaltyPoints.isAcceptableOrUnknown(data['penalty_points']!, _penaltyPointsMeta));} else if (isInserting) {
context.missing(_penaltyPointsMeta);
}
if (data.containsKey('focus_badge_earned')) {
context.handle(_focusBadgeEarnedMeta, focusBadgeEarned.isAcceptableOrUnknown(data['focus_badge_earned']!, _focusBadgeEarnedMeta));}if (data.containsKey('synced_at')) {
context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));}if (data.containsKey('deleted_at')) {
context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override DailyScore map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return DailyScore(id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!, userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!, date: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}date'])!, trueScore: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}true_score'])!, verdict: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}verdict'])!, big3Points: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}big3_points'])!, pomodoroPoints: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}pomodoro_points'])!, taskPoints: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}task_points'])!, journalPoints: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}journal_points'])!, activePoints: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}active_points'])!, penaltyPoints: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}penalty_points'])!, focusBadgeEarned: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}focus_badge_earned'])!, syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']), deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']), );
}
@override
$DailyScoresTable createAlias(String alias) {
return $DailyScoresTable(attachedDatabase, alias);}}class DailyScore extends DataClass implements Insertable<DailyScore> 
{
final String id;
final String userId;
final String date;
final int trueScore;
final String verdict;
final int big3Points;
final int pomodoroPoints;
final int taskPoints;
final int journalPoints;
final int activePoints;
final int penaltyPoints;
final bool focusBadgeEarned;
final DateTime? syncedAt;
final DateTime? deletedAt;
DailyScore({required this.id, required this.userId, required this.date, required this.trueScore, required this.verdict, required this.big3Points, required this.pomodoroPoints, required this.taskPoints, required this.journalPoints, required this.activePoints, required this.penaltyPoints, required this.focusBadgeEarned, this.syncedAt, this.deletedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<String>(id);
map['user_id'] = Variable<String>(userId);
map['date'] = Variable<String>(date);
map['true_score'] = Variable<int>(trueScore);
map['verdict'] = Variable<String>(verdict);
map['big3_points'] = Variable<int>(big3Points);
map['pomodoro_points'] = Variable<int>(pomodoroPoints);
map['task_points'] = Variable<int>(taskPoints);
map['journal_points'] = Variable<int>(journalPoints);
map['active_points'] = Variable<int>(activePoints);
map['penalty_points'] = Variable<int>(penaltyPoints);
map['focus_badge_earned'] = Variable<bool>(focusBadgeEarned);
if (!nullToAbsent || syncedAt != null){map['synced_at'] = Variable<DateTime>(syncedAt);
}if (!nullToAbsent || deletedAt != null){map['deleted_at'] = Variable<DateTime>(deletedAt);
}return map; 
}
DailyScoresCompanion toCompanion(bool nullToAbsent) {
return DailyScoresCompanion(id: Value(id),userId: Value(userId),date: Value(date),trueScore: Value(trueScore),verdict: Value(verdict),big3Points: Value(big3Points),pomodoroPoints: Value(pomodoroPoints),taskPoints: Value(taskPoints),journalPoints: Value(journalPoints),activePoints: Value(activePoints),penaltyPoints: Value(penaltyPoints),focusBadgeEarned: Value(focusBadgeEarned),syncedAt: syncedAt == null && nullToAbsent ? const Value.absent() : Value(syncedAt),deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),);
}
factory DailyScore.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return DailyScore(id: serializer.fromJson<String>(json['id']),userId: serializer.fromJson<String>(json['userId']),date: serializer.fromJson<String>(json['date']),trueScore: serializer.fromJson<int>(json['trueScore']),verdict: serializer.fromJson<String>(json['verdict']),big3Points: serializer.fromJson<int>(json['big3Points']),pomodoroPoints: serializer.fromJson<int>(json['pomodoroPoints']),taskPoints: serializer.fromJson<int>(json['taskPoints']),journalPoints: serializer.fromJson<int>(json['journalPoints']),activePoints: serializer.fromJson<int>(json['activePoints']),penaltyPoints: serializer.fromJson<int>(json['penaltyPoints']),focusBadgeEarned: serializer.fromJson<bool>(json['focusBadgeEarned']),syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<String>(id),'userId': serializer.toJson<String>(userId),'date': serializer.toJson<String>(date),'trueScore': serializer.toJson<int>(trueScore),'verdict': serializer.toJson<String>(verdict),'big3Points': serializer.toJson<int>(big3Points),'pomodoroPoints': serializer.toJson<int>(pomodoroPoints),'taskPoints': serializer.toJson<int>(taskPoints),'journalPoints': serializer.toJson<int>(journalPoints),'activePoints': serializer.toJson<int>(activePoints),'penaltyPoints': serializer.toJson<int>(penaltyPoints),'focusBadgeEarned': serializer.toJson<bool>(focusBadgeEarned),'syncedAt': serializer.toJson<DateTime?>(syncedAt),'deletedAt': serializer.toJson<DateTime?>(deletedAt),};}DailyScore copyWith({String? id,String? userId,String? date,int? trueScore,String? verdict,int? big3Points,int? pomodoroPoints,int? taskPoints,int? journalPoints,int? activePoints,int? penaltyPoints,bool? focusBadgeEarned,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent()}) => DailyScore(id: id ?? this.id,userId: userId ?? this.userId,date: date ?? this.date,trueScore: trueScore ?? this.trueScore,verdict: verdict ?? this.verdict,big3Points: big3Points ?? this.big3Points,pomodoroPoints: pomodoroPoints ?? this.pomodoroPoints,taskPoints: taskPoints ?? this.taskPoints,journalPoints: journalPoints ?? this.journalPoints,activePoints: activePoints ?? this.activePoints,penaltyPoints: penaltyPoints ?? this.penaltyPoints,focusBadgeEarned: focusBadgeEarned ?? this.focusBadgeEarned,syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,);DailyScore copyWithCompanion(DailyScoresCompanion data) {
return DailyScore(
id: data.id.present ? data.id.value : this.id,userId: data.userId.present ? data.userId.value : this.userId,date: data.date.present ? data.date.value : this.date,trueScore: data.trueScore.present ? data.trueScore.value : this.trueScore,verdict: data.verdict.present ? data.verdict.value : this.verdict,big3Points: data.big3Points.present ? data.big3Points.value : this.big3Points,pomodoroPoints: data.pomodoroPoints.present ? data.pomodoroPoints.value : this.pomodoroPoints,taskPoints: data.taskPoints.present ? data.taskPoints.value : this.taskPoints,journalPoints: data.journalPoints.present ? data.journalPoints.value : this.journalPoints,activePoints: data.activePoints.present ? data.activePoints.value : this.activePoints,penaltyPoints: data.penaltyPoints.present ? data.penaltyPoints.value : this.penaltyPoints,focusBadgeEarned: data.focusBadgeEarned.present ? data.focusBadgeEarned.value : this.focusBadgeEarned,syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,);
}
@override
String toString() {return (StringBuffer('DailyScore(')..write('id: $id, ')..write('userId: $userId, ')..write('date: $date, ')..write('trueScore: $trueScore, ')..write('verdict: $verdict, ')..write('big3Points: $big3Points, ')..write('pomodoroPoints: $pomodoroPoints, ')..write('taskPoints: $taskPoints, ')..write('journalPoints: $journalPoints, ')..write('activePoints: $activePoints, ')..write('penaltyPoints: $penaltyPoints, ')..write('focusBadgeEarned: $focusBadgeEarned, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, userId, date, trueScore, verdict, big3Points, pomodoroPoints, taskPoints, journalPoints, activePoints, penaltyPoints, focusBadgeEarned, syncedAt, deletedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is DailyScore && other.id == this.id && other.userId == this.userId && other.date == this.date && other.trueScore == this.trueScore && other.verdict == this.verdict && other.big3Points == this.big3Points && other.pomodoroPoints == this.pomodoroPoints && other.taskPoints == this.taskPoints && other.journalPoints == this.journalPoints && other.activePoints == this.activePoints && other.penaltyPoints == this.penaltyPoints && other.focusBadgeEarned == this.focusBadgeEarned && other.syncedAt == this.syncedAt && other.deletedAt == this.deletedAt);
}class DailyScoresCompanion extends UpdateCompanion<DailyScore> {
final Value<String> id;
final Value<String> userId;
final Value<String> date;
final Value<int> trueScore;
final Value<String> verdict;
final Value<int> big3Points;
final Value<int> pomodoroPoints;
final Value<int> taskPoints;
final Value<int> journalPoints;
final Value<int> activePoints;
final Value<int> penaltyPoints;
final Value<bool> focusBadgeEarned;
final Value<DateTime?> syncedAt;
final Value<DateTime?> deletedAt;
final Value<int> rowid;
DailyScoresCompanion({this.id = const Value.absent(),this.userId = const Value.absent(),this.date = const Value.absent(),this.trueScore = const Value.absent(),this.verdict = const Value.absent(),this.big3Points = const Value.absent(),this.pomodoroPoints = const Value.absent(),this.taskPoints = const Value.absent(),this.journalPoints = const Value.absent(),this.activePoints = const Value.absent(),this.penaltyPoints = const Value.absent(),this.focusBadgeEarned = const Value.absent(),this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),});
DailyScoresCompanion.insert({required String id,required String userId,required String date,required int trueScore,required String verdict,required int big3Points,required int pomodoroPoints,required int taskPoints,required int journalPoints,required int activePoints,required int penaltyPoints,this.focusBadgeEarned = const Value.absent(),this.syncedAt = const Value.absent(),this.deletedAt = const Value.absent(),this.rowid = const Value.absent(),}): id = Value(id), userId = Value(userId), date = Value(date), trueScore = Value(trueScore), verdict = Value(verdict), big3Points = Value(big3Points), pomodoroPoints = Value(pomodoroPoints), taskPoints = Value(taskPoints), journalPoints = Value(journalPoints), activePoints = Value(activePoints), penaltyPoints = Value(penaltyPoints);
static Insertable<DailyScore> custom({Expression<String>? id, 
Expression<String>? userId, 
Expression<String>? date, 
Expression<int>? trueScore, 
Expression<String>? verdict, 
Expression<int>? big3Points, 
Expression<int>? pomodoroPoints, 
Expression<int>? taskPoints, 
Expression<int>? journalPoints, 
Expression<int>? activePoints, 
Expression<int>? penaltyPoints, 
Expression<bool>? focusBadgeEarned, 
Expression<DateTime>? syncedAt, 
Expression<DateTime>? deletedAt, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (userId != null)'user_id': userId,if (date != null)'date': date,if (trueScore != null)'true_score': trueScore,if (verdict != null)'verdict': verdict,if (big3Points != null)'big3_points': big3Points,if (pomodoroPoints != null)'pomodoro_points': pomodoroPoints,if (taskPoints != null)'task_points': taskPoints,if (journalPoints != null)'journal_points': journalPoints,if (activePoints != null)'active_points': activePoints,if (penaltyPoints != null)'penalty_points': penaltyPoints,if (focusBadgeEarned != null)'focus_badge_earned': focusBadgeEarned,if (syncedAt != null)'synced_at': syncedAt,if (deletedAt != null)'deleted_at': deletedAt,if (rowid != null)'rowid': rowid,});
}DailyScoresCompanion copyWith({Value<String>? id, Value<String>? userId, Value<String>? date, Value<int>? trueScore, Value<String>? verdict, Value<int>? big3Points, Value<int>? pomodoroPoints, Value<int>? taskPoints, Value<int>? journalPoints, Value<int>? activePoints, Value<int>? penaltyPoints, Value<bool>? focusBadgeEarned, Value<DateTime?>? syncedAt, Value<DateTime?>? deletedAt, Value<int>? rowid}) {
return DailyScoresCompanion(id: id ?? this.id,userId: userId ?? this.userId,date: date ?? this.date,trueScore: trueScore ?? this.trueScore,verdict: verdict ?? this.verdict,big3Points: big3Points ?? this.big3Points,pomodoroPoints: pomodoroPoints ?? this.pomodoroPoints,taskPoints: taskPoints ?? this.taskPoints,journalPoints: journalPoints ?? this.journalPoints,activePoints: activePoints ?? this.activePoints,penaltyPoints: penaltyPoints ?? this.penaltyPoints,focusBadgeEarned: focusBadgeEarned ?? this.focusBadgeEarned,syncedAt: syncedAt ?? this.syncedAt,deletedAt: deletedAt ?? this.deletedAt,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<String>(id.value);}
if (userId.present) {
map['user_id'] = Variable<String>(userId.value);}
if (date.present) {
map['date'] = Variable<String>(date.value);}
if (trueScore.present) {
map['true_score'] = Variable<int>(trueScore.value);}
if (verdict.present) {
map['verdict'] = Variable<String>(verdict.value);}
if (big3Points.present) {
map['big3_points'] = Variable<int>(big3Points.value);}
if (pomodoroPoints.present) {
map['pomodoro_points'] = Variable<int>(pomodoroPoints.value);}
if (taskPoints.present) {
map['task_points'] = Variable<int>(taskPoints.value);}
if (journalPoints.present) {
map['journal_points'] = Variable<int>(journalPoints.value);}
if (activePoints.present) {
map['active_points'] = Variable<int>(activePoints.value);}
if (penaltyPoints.present) {
map['penalty_points'] = Variable<int>(penaltyPoints.value);}
if (focusBadgeEarned.present) {
map['focus_badge_earned'] = Variable<bool>(focusBadgeEarned.value);}
if (syncedAt.present) {
map['synced_at'] = Variable<DateTime>(syncedAt.value);}
if (deletedAt.present) {
map['deleted_at'] = Variable<DateTime>(deletedAt.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('DailyScoresCompanion(')..write('id: $id, ')..write('userId: $userId, ')..write('date: $date, ')..write('trueScore: $trueScore, ')..write('verdict: $verdict, ')..write('big3Points: $big3Points, ')..write('pomodoroPoints: $pomodoroPoints, ')..write('taskPoints: $taskPoints, ')..write('journalPoints: $journalPoints, ')..write('activePoints: $activePoints, ')..write('penaltyPoints: $penaltyPoints, ')..write('focusBadgeEarned: $focusBadgeEarned, ')..write('syncedAt: $syncedAt, ')..write('deletedAt: $deletedAt, ')..write('rowid: $rowid')..write(')')).toString();}
}
class $SemesterGoalsTable extends SemesterGoals with TableInfo<$SemesterGoalsTable, SemesterGoal>{
@override final GeneratedDatabase attachedDatabase;
final String? _alias;
$SemesterGoalsTable(this.attachedDatabase, [this._alias]);
static const VerificationMeta _idMeta = VerificationMeta('id');
@override
late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _userIdMeta = VerificationMeta('userId');
@override
late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _titleMeta = VerificationMeta('title');
@override
late final GeneratedColumn<String> title = GeneratedColumn<String>('title', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _targetDateMeta = VerificationMeta('targetDate');
@override
late final GeneratedColumn<String> targetDate = GeneratedColumn<String>('target_date', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
static const VerificationMeta _isCompletedMeta = VerificationMeta('isCompleted');
@override
late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>('is_completed', aliasedName, false, type: DriftSqlType.bool, requiredDuringInsert: false, defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_completed" IN (0, 1))'), defaultValue: Constant(false));
static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
@override
late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');
@override
late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>('synced_at', aliasedName, true, type: DriftSqlType.dateTime, requiredDuringInsert: false);
@override
List<GeneratedColumn> get $columns => [id, userId, title, targetDate, isCompleted, createdAt, syncedAt];
@override
String get aliasedName => _alias ?? actualTableName;
@override
 String get actualTableName => $name;
static const String $name = 'semester_goals';
@override
VerificationContext validateIntegrity(Insertable<SemesterGoal> instance, {bool isInserting = false}) {
final context = VerificationContext();
final data = instance.toColumns(true);
if (data.containsKey('id')) {
context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));} else if (isInserting) {
context.missing(_idMeta);
}
if (data.containsKey('user_id')) {
context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));} else if (isInserting) {
context.missing(_userIdMeta);
}
if (data.containsKey('title')) {
context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));} else if (isInserting) {
context.missing(_titleMeta);
}
if (data.containsKey('target_date')) {
context.handle(_targetDateMeta, targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta));} else if (isInserting) {
context.missing(_targetDateMeta);
}
if (data.containsKey('is_completed')) {
context.handle(_isCompletedMeta, isCompleted.isAcceptableOrUnknown(data['is_completed']!, _isCompletedMeta));}if (data.containsKey('created_at')) {
context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));} else if (isInserting) {
context.missing(_createdAtMeta);
}
if (data.containsKey('synced_at')) {
context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));}return context;
}
@override
Set<GeneratedColumn> get $primaryKey => {id};
@override SemesterGoal map(Map<String, dynamic> data, {String? tablePrefix})  {
final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';return SemesterGoal(id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!, userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!, title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!, targetDate: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}target_date'])!, isCompleted: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!, createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!, syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']), );
}
@override
$SemesterGoalsTable createAlias(String alias) {
return $SemesterGoalsTable(attachedDatabase, alias);}}class SemesterGoal extends DataClass implements Insertable<SemesterGoal> 
{
final String id;
final String userId;
final String title;
final String targetDate;
final bool isCompleted;
final DateTime createdAt;
final DateTime? syncedAt;
SemesterGoal({required this.id, required this.userId, required this.title, required this.targetDate, required this.isCompleted, required this.createdAt, this.syncedAt});@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};map['id'] = Variable<String>(id);
map['user_id'] = Variable<String>(userId);
map['title'] = Variable<String>(title);
map['target_date'] = Variable<String>(targetDate);
map['is_completed'] = Variable<bool>(isCompleted);
map['created_at'] = Variable<DateTime>(createdAt);
if (!nullToAbsent || syncedAt != null){map['synced_at'] = Variable<DateTime>(syncedAt);
}return map; 
}
SemesterGoalsCompanion toCompanion(bool nullToAbsent) {
return SemesterGoalsCompanion(id: Value(id),userId: Value(userId),title: Value(title),targetDate: Value(targetDate),isCompleted: Value(isCompleted),createdAt: Value(createdAt),syncedAt: syncedAt == null && nullToAbsent ? const Value.absent() : Value(syncedAt),);
}
factory SemesterGoal.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return SemesterGoal(id: serializer.fromJson<String>(json['id']),userId: serializer.fromJson<String>(json['userId']),title: serializer.fromJson<String>(json['title']),targetDate: serializer.fromJson<String>(json['targetDate']),isCompleted: serializer.fromJson<bool>(json['isCompleted']),createdAt: serializer.fromJson<DateTime>(json['createdAt']),syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),);}
@override Map<String, dynamic> toJson({ValueSerializer? serializer}) {
serializer ??= driftRuntimeOptions.defaultSerializer;
return <String, dynamic>{
'id': serializer.toJson<String>(id),'userId': serializer.toJson<String>(userId),'title': serializer.toJson<String>(title),'targetDate': serializer.toJson<String>(targetDate),'isCompleted': serializer.toJson<bool>(isCompleted),'createdAt': serializer.toJson<DateTime>(createdAt),'syncedAt': serializer.toJson<DateTime?>(syncedAt),};}SemesterGoal copyWith({String? id,String? userId,String? title,String? targetDate,bool? isCompleted,DateTime? createdAt,Value<DateTime?> syncedAt = const Value.absent()}) => SemesterGoal(id: id ?? this.id,userId: userId ?? this.userId,title: title ?? this.title,targetDate: targetDate ?? this.targetDate,isCompleted: isCompleted ?? this.isCompleted,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,);SemesterGoal copyWithCompanion(SemesterGoalsCompanion data) {
return SemesterGoal(
id: data.id.present ? data.id.value : this.id,userId: data.userId.present ? data.userId.value : this.userId,title: data.title.present ? data.title.value : this.title,targetDate: data.targetDate.present ? data.targetDate.value : this.targetDate,isCompleted: data.isCompleted.present ? data.isCompleted.value : this.isCompleted,createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,);
}
@override
String toString() {return (StringBuffer('SemesterGoal(')..write('id: $id, ')..write('userId: $userId, ')..write('title: $title, ')..write('targetDate: $targetDate, ')..write('isCompleted: $isCompleted, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt')..write(')')).toString();}
@override
 int get hashCode => Object.hash(id, userId, title, targetDate, isCompleted, createdAt, syncedAt);@override
bool operator ==(Object other) => identical(this, other) || (other is SemesterGoal && other.id == this.id && other.userId == this.userId && other.title == this.title && other.targetDate == this.targetDate && other.isCompleted == this.isCompleted && other.createdAt == this.createdAt && other.syncedAt == this.syncedAt);
}class SemesterGoalsCompanion extends UpdateCompanion<SemesterGoal> {
final Value<String> id;
final Value<String> userId;
final Value<String> title;
final Value<String> targetDate;
final Value<bool> isCompleted;
final Value<DateTime> createdAt;
final Value<DateTime?> syncedAt;
final Value<int> rowid;
SemesterGoalsCompanion({this.id = const Value.absent(),this.userId = const Value.absent(),this.title = const Value.absent(),this.targetDate = const Value.absent(),this.isCompleted = const Value.absent(),this.createdAt = const Value.absent(),this.syncedAt = const Value.absent(),this.rowid = const Value.absent(),});
SemesterGoalsCompanion.insert({required String id,required String userId,required String title,required String targetDate,this.isCompleted = const Value.absent(),required DateTime createdAt,this.syncedAt = const Value.absent(),this.rowid = const Value.absent(),}): id = Value(id), userId = Value(userId), title = Value(title), targetDate = Value(targetDate), createdAt = Value(createdAt);
static Insertable<SemesterGoal> custom({Expression<String>? id, 
Expression<String>? userId, 
Expression<String>? title, 
Expression<String>? targetDate, 
Expression<bool>? isCompleted, 
Expression<DateTime>? createdAt, 
Expression<DateTime>? syncedAt, 
Expression<int>? rowid, 
}) {
return RawValuesInsertable({if (id != null)'id': id,if (userId != null)'user_id': userId,if (title != null)'title': title,if (targetDate != null)'target_date': targetDate,if (isCompleted != null)'is_completed': isCompleted,if (createdAt != null)'created_at': createdAt,if (syncedAt != null)'synced_at': syncedAt,if (rowid != null)'rowid': rowid,});
}SemesterGoalsCompanion copyWith({Value<String>? id, Value<String>? userId, Value<String>? title, Value<String>? targetDate, Value<bool>? isCompleted, Value<DateTime>? createdAt, Value<DateTime?>? syncedAt, Value<int>? rowid}) {
return SemesterGoalsCompanion(id: id ?? this.id,userId: userId ?? this.userId,title: title ?? this.title,targetDate: targetDate ?? this.targetDate,isCompleted: isCompleted ?? this.isCompleted,createdAt: createdAt ?? this.createdAt,syncedAt: syncedAt ?? this.syncedAt,rowid: rowid ?? this.rowid,);
}
@override
Map<String, Expression> toColumns(bool nullToAbsent) {
final map = <String, Expression> {};if (id.present) {
map['id'] = Variable<String>(id.value);}
if (userId.present) {
map['user_id'] = Variable<String>(userId.value);}
if (title.present) {
map['title'] = Variable<String>(title.value);}
if (targetDate.present) {
map['target_date'] = Variable<String>(targetDate.value);}
if (isCompleted.present) {
map['is_completed'] = Variable<bool>(isCompleted.value);}
if (createdAt.present) {
map['created_at'] = Variable<DateTime>(createdAt.value);}
if (syncedAt.present) {
map['synced_at'] = Variable<DateTime>(syncedAt.value);}
if (rowid.present) {
map['rowid'] = Variable<int>(rowid.value);}
return map; 
}
@override
String toString() {return (StringBuffer('SemesterGoalsCompanion(')..write('id: $id, ')..write('userId: $userId, ')..write('title: $title, ')..write('targetDate: $targetDate, ')..write('isCompleted: $isCompleted, ')..write('createdAt: $createdAt, ')..write('syncedAt: $syncedAt, ')..write('rowid: $rowid')..write(')')).toString();}
}
abstract class _$AppDatabase extends GeneratedDatabase{
_$AppDatabase(QueryExecutor e): super(e);
$AppDatabaseManager get managers => $AppDatabaseManager(this);
late final $GoalsTable goals = $GoalsTable(this);
late final $TasksTable tasks = $TasksTable(this);
late final $PomodoroSessionsTable pomodoroSessions = $PomodoroSessionsTable(this);
late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
late final $SyncOperationsTable syncOperations = $SyncOperationsTable(this);
late final $DailyScoresTable dailyScores = $DailyScoresTable(this);
late final $SemesterGoalsTable semesterGoals = $SemesterGoalsTable(this);
@override
Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
@override
List<DatabaseSchemaEntity> get allSchemaEntities => [goals, tasks, pomodoroSessions, journalEntries, syncOperations, dailyScores, semesterGoals];
}
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({required String id,required String userId,required String title,required String subject,required String date,Value<bool> isCompleted,Value<String?> semesterGoalId,Value<String?> focusWindowStart,Value<String?> focusWindowEnd,required DateTime createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({Value<String> id,Value<String> userId,Value<String> title,Value<String> subject,Value<String> date,Value<bool> isCompleted,Value<String?> semesterGoalId,Value<String?> focusWindowStart,Value<String?> focusWindowEnd,Value<DateTime> createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
class $$GoalsTableFilterComposer extends Composer<
        _$AppDatabase,
        $GoalsTable> {
        $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get subject => $composableBuilder(
      column: $table.subject,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get semesterGoalId => $composableBuilder(
      column: $table.semesterGoalId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get focusWindowStart => $composableBuilder(
      column: $table.focusWindowStart,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get focusWindowEnd => $composableBuilder(
      column: $table.focusWindowEnd,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$GoalsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $GoalsTable> {
        $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get subject => $composableBuilder(
      column: $table.subject,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get semesterGoalId => $composableBuilder(
      column: $table.semesterGoalId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get focusWindowStart => $composableBuilder(
      column: $table.focusWindowStart,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get focusWindowEnd => $composableBuilder(
      column: $table.focusWindowEnd,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$GoalsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $GoalsTable> {
        $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => column);
      
GeneratedColumn<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => column);
      
GeneratedColumn<String> get subject => $composableBuilder(
      column: $table.subject,
      builder: (column) => column);
      
GeneratedColumn<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => column);
      
GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => column);
      
GeneratedColumn<String> get semesterGoalId => $composableBuilder(
      column: $table.semesterGoalId,
      builder: (column) => column);
      
GeneratedColumn<String> get focusWindowStart => $composableBuilder(
      column: $table.focusWindowStart,
      builder: (column) => column);
      
GeneratedColumn<String> get focusWindowEnd => $composableBuilder(
      column: $table.focusWindowEnd,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => column);
      
        }
      class $$GoalsTableTableManager extends RootTableManager    <_$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal,BaseReferences<_$AppDatabase,$GoalsTable,Goal>),
    Goal,
    PrefetchHooks Function()
    > {
    $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$GoalsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$GoalsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$GoalsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<String> id = const Value.absent(),Value<String> userId = const Value.absent(),Value<String> title = const Value.absent(),Value<String> subject = const Value.absent(),Value<String> date = const Value.absent(),Value<bool> isCompleted = const Value.absent(),Value<String?> semesterGoalId = const Value.absent(),Value<String?> focusWindowStart = const Value.absent(),Value<String?> focusWindowEnd = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> GoalsCompanion(id: id,userId: userId,title: title,subject: subject,date: date,isCompleted: isCompleted,semesterGoalId: semesterGoalId,focusWindowStart: focusWindowStart,focusWindowEnd: focusWindowEnd,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        createCompanionCallback: ({required String id,required String userId,required String title,required String subject,required String date,Value<bool> isCompleted = const Value.absent(),Value<String?> semesterGoalId = const Value.absent(),Value<String?> focusWindowStart = const Value.absent(),Value<String?> focusWindowEnd = const Value.absent(),required DateTime createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> GoalsCompanion.insert(id: id,userId: userId,title: title,subject: subject,date: date,isCompleted: isCompleted,semesterGoalId: semesterGoalId,focusWindowStart: focusWindowStart,focusWindowEnd: focusWindowEnd,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$GoalsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal,BaseReferences<_$AppDatabase,$GoalsTable,Goal>),
    Goal,
    PrefetchHooks Function()
    >;typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({required String id,required String userId,required String title,required String date,Value<bool> isCompleted,Value<String?> linkedGoalId,required DateTime createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({Value<String> id,Value<String> userId,Value<String> title,Value<String> date,Value<bool> isCompleted,Value<String?> linkedGoalId,Value<DateTime> createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
class $$TasksTableFilterComposer extends Composer<
        _$AppDatabase,
        $TasksTable> {
        $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get linkedGoalId => $composableBuilder(
      column: $table.linkedGoalId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$TasksTableOrderingComposer extends Composer<
        _$AppDatabase,
        $TasksTable> {
        $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get linkedGoalId => $composableBuilder(
      column: $table.linkedGoalId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$TasksTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $TasksTable> {
        $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => column);
      
GeneratedColumn<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => column);
      
GeneratedColumn<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => column);
      
GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => column);
      
GeneratedColumn<String> get linkedGoalId => $composableBuilder(
      column: $table.linkedGoalId,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => column);
      
        }
      class $$TasksTableTableManager extends RootTableManager    <_$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task,BaseReferences<_$AppDatabase,$TasksTable,Task>),
    Task,
    PrefetchHooks Function()
    > {
    $$TasksTableTableManager(_$AppDatabase db, $TasksTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$TasksTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$TasksTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$TasksTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<String> id = const Value.absent(),Value<String> userId = const Value.absent(),Value<String> title = const Value.absent(),Value<String> date = const Value.absent(),Value<bool> isCompleted = const Value.absent(),Value<String?> linkedGoalId = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> TasksCompanion(id: id,userId: userId,title: title,date: date,isCompleted: isCompleted,linkedGoalId: linkedGoalId,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        createCompanionCallback: ({required String id,required String userId,required String title,required String date,Value<bool> isCompleted = const Value.absent(),Value<String?> linkedGoalId = const Value.absent(),required DateTime createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> TasksCompanion.insert(id: id,userId: userId,title: title,date: date,isCompleted: isCompleted,linkedGoalId: linkedGoalId,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$TasksTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task,BaseReferences<_$AppDatabase,$TasksTable,Task>),
    Task,
    PrefetchHooks Function()
    >;typedef $$PomodoroSessionsTableCreateCompanionBuilder = PomodoroSessionsCompanion Function({required String id,required String userId,Value<String?> linkedGoalId,Value<int> durationMinutes,required DateTime startedAt,Value<DateTime?> completedAt,required String idempotencyKey,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
typedef $$PomodoroSessionsTableUpdateCompanionBuilder = PomodoroSessionsCompanion Function({Value<String> id,Value<String> userId,Value<String?> linkedGoalId,Value<int> durationMinutes,Value<DateTime> startedAt,Value<DateTime?> completedAt,Value<String> idempotencyKey,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
class $$PomodoroSessionsTableFilterComposer extends Composer<
        _$AppDatabase,
        $PomodoroSessionsTable> {
        $$PomodoroSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get linkedGoalId => $composableBuilder(
      column: $table.linkedGoalId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get idempotencyKey => $composableBuilder(
      column: $table.idempotencyKey,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$PomodoroSessionsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $PomodoroSessionsTable> {
        $$PomodoroSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get linkedGoalId => $composableBuilder(
      column: $table.linkedGoalId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get idempotencyKey => $composableBuilder(
      column: $table.idempotencyKey,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$PomodoroSessionsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $PomodoroSessionsTable> {
        $$PomodoroSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => column);
      
GeneratedColumn<String> get linkedGoalId => $composableBuilder(
      column: $table.linkedGoalId,
      builder: (column) => column);
      
GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt,
      builder: (column) => column);
      
GeneratedColumn<String> get idempotencyKey => $composableBuilder(
      column: $table.idempotencyKey,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => column);
      
        }
      class $$PomodoroSessionsTableTableManager extends RootTableManager    <_$AppDatabase,
    $PomodoroSessionsTable,
    PomodoroSession,
    $$PomodoroSessionsTableFilterComposer,
    $$PomodoroSessionsTableOrderingComposer,
    $$PomodoroSessionsTableAnnotationComposer,
    $$PomodoroSessionsTableCreateCompanionBuilder,
    $$PomodoroSessionsTableUpdateCompanionBuilder,
    (PomodoroSession,BaseReferences<_$AppDatabase,$PomodoroSessionsTable,PomodoroSession>),
    PomodoroSession,
    PrefetchHooks Function()
    > {
    $$PomodoroSessionsTableTableManager(_$AppDatabase db, $PomodoroSessionsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$PomodoroSessionsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$PomodoroSessionsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$PomodoroSessionsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<String> id = const Value.absent(),Value<String> userId = const Value.absent(),Value<String?> linkedGoalId = const Value.absent(),Value<int> durationMinutes = const Value.absent(),Value<DateTime> startedAt = const Value.absent(),Value<DateTime?> completedAt = const Value.absent(),Value<String> idempotencyKey = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> PomodoroSessionsCompanion(id: id,userId: userId,linkedGoalId: linkedGoalId,durationMinutes: durationMinutes,startedAt: startedAt,completedAt: completedAt,idempotencyKey: idempotencyKey,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        createCompanionCallback: ({required String id,required String userId,Value<String?> linkedGoalId = const Value.absent(),Value<int> durationMinutes = const Value.absent(),required DateTime startedAt,Value<DateTime?> completedAt = const Value.absent(),required String idempotencyKey,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> PomodoroSessionsCompanion.insert(id: id,userId: userId,linkedGoalId: linkedGoalId,durationMinutes: durationMinutes,startedAt: startedAt,completedAt: completedAt,idempotencyKey: idempotencyKey,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$PomodoroSessionsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $PomodoroSessionsTable,
    PomodoroSession,
    $$PomodoroSessionsTableFilterComposer,
    $$PomodoroSessionsTableOrderingComposer,
    $$PomodoroSessionsTableAnnotationComposer,
    $$PomodoroSessionsTableCreateCompanionBuilder,
    $$PomodoroSessionsTableUpdateCompanionBuilder,
    (PomodoroSession,BaseReferences<_$AppDatabase,$PomodoroSessionsTable,PomodoroSession>),
    PomodoroSession,
    PrefetchHooks Function()
    >;typedef $$JournalEntriesTableCreateCompanionBuilder = JournalEntriesCompanion Function({required String id,required String userId,required String date,required String content,Value<String?> aiPrompts,required DateTime createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
typedef $$JournalEntriesTableUpdateCompanionBuilder = JournalEntriesCompanion Function({Value<String> id,Value<String> userId,Value<String> date,Value<String> content,Value<String?> aiPrompts,Value<DateTime> createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
class $$JournalEntriesTableFilterComposer extends Composer<
        _$AppDatabase,
        $JournalEntriesTable> {
        $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get content => $composableBuilder(
      column: $table.content,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get aiPrompts => $composableBuilder(
      column: $table.aiPrompts,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$JournalEntriesTableOrderingComposer extends Composer<
        _$AppDatabase,
        $JournalEntriesTable> {
        $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get aiPrompts => $composableBuilder(
      column: $table.aiPrompts,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$JournalEntriesTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $JournalEntriesTable> {
        $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => column);
      
GeneratedColumn<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => column);
      
GeneratedColumn<String> get content => $composableBuilder(
      column: $table.content,
      builder: (column) => column);
      
GeneratedColumn<String> get aiPrompts => $composableBuilder(
      column: $table.aiPrompts,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => column);
      
        }
      class $$JournalEntriesTableTableManager extends RootTableManager    <_$AppDatabase,
    $JournalEntriesTable,
    JournalEntry,
    $$JournalEntriesTableFilterComposer,
    $$JournalEntriesTableOrderingComposer,
    $$JournalEntriesTableAnnotationComposer,
    $$JournalEntriesTableCreateCompanionBuilder,
    $$JournalEntriesTableUpdateCompanionBuilder,
    (JournalEntry,BaseReferences<_$AppDatabase,$JournalEntriesTable,JournalEntry>),
    JournalEntry,
    PrefetchHooks Function()
    > {
    $$JournalEntriesTableTableManager(_$AppDatabase db, $JournalEntriesTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$JournalEntriesTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$JournalEntriesTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$JournalEntriesTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<String> id = const Value.absent(),Value<String> userId = const Value.absent(),Value<String> date = const Value.absent(),Value<String> content = const Value.absent(),Value<String?> aiPrompts = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> JournalEntriesCompanion(id: id,userId: userId,date: date,content: content,aiPrompts: aiPrompts,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        createCompanionCallback: ({required String id,required String userId,required String date,required String content,Value<String?> aiPrompts = const Value.absent(),required DateTime createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> JournalEntriesCompanion.insert(id: id,userId: userId,date: date,content: content,aiPrompts: aiPrompts,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$JournalEntriesTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $JournalEntriesTable,
    JournalEntry,
    $$JournalEntriesTableFilterComposer,
    $$JournalEntriesTableOrderingComposer,
    $$JournalEntriesTableAnnotationComposer,
    $$JournalEntriesTableCreateCompanionBuilder,
    $$JournalEntriesTableUpdateCompanionBuilder,
    (JournalEntry,BaseReferences<_$AppDatabase,$JournalEntriesTable,JournalEntry>),
    JournalEntry,
    PrefetchHooks Function()
    >;typedef $$SyncOperationsTableCreateCompanionBuilder = SyncOperationsCompanion Function({required String id,required String userId,required String operationType,required String payload,required String idempotencyKey,required DateTime createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
typedef $$SyncOperationsTableUpdateCompanionBuilder = SyncOperationsCompanion Function({Value<String> id,Value<String> userId,Value<String> operationType,Value<String> payload,Value<String> idempotencyKey,Value<DateTime> createdAt,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
class $$SyncOperationsTableFilterComposer extends Composer<
        _$AppDatabase,
        $SyncOperationsTable> {
        $$SyncOperationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get operationType => $composableBuilder(
      column: $table.operationType,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get idempotencyKey => $composableBuilder(
      column: $table.idempotencyKey,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$SyncOperationsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $SyncOperationsTable> {
        $$SyncOperationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get operationType => $composableBuilder(
      column: $table.operationType,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get idempotencyKey => $composableBuilder(
      column: $table.idempotencyKey,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$SyncOperationsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $SyncOperationsTable> {
        $$SyncOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => column);
      
GeneratedColumn<String> get operationType => $composableBuilder(
      column: $table.operationType,
      builder: (column) => column);
      
GeneratedColumn<String> get payload => $composableBuilder(
      column: $table.payload,
      builder: (column) => column);
      
GeneratedColumn<String> get idempotencyKey => $composableBuilder(
      column: $table.idempotencyKey,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => column);
      
        }
      class $$SyncOperationsTableTableManager extends RootTableManager    <_$AppDatabase,
    $SyncOperationsTable,
    SyncOperation,
    $$SyncOperationsTableFilterComposer,
    $$SyncOperationsTableOrderingComposer,
    $$SyncOperationsTableAnnotationComposer,
    $$SyncOperationsTableCreateCompanionBuilder,
    $$SyncOperationsTableUpdateCompanionBuilder,
    (SyncOperation,BaseReferences<_$AppDatabase,$SyncOperationsTable,SyncOperation>),
    SyncOperation,
    PrefetchHooks Function()
    > {
    $$SyncOperationsTableTableManager(_$AppDatabase db, $SyncOperationsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$SyncOperationsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$SyncOperationsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$SyncOperationsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<String> id = const Value.absent(),Value<String> userId = const Value.absent(),Value<String> operationType = const Value.absent(),Value<String> payload = const Value.absent(),Value<String> idempotencyKey = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> SyncOperationsCompanion(id: id,userId: userId,operationType: operationType,payload: payload,idempotencyKey: idempotencyKey,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        createCompanionCallback: ({required String id,required String userId,required String operationType,required String payload,required String idempotencyKey,required DateTime createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> SyncOperationsCompanion.insert(id: id,userId: userId,operationType: operationType,payload: payload,idempotencyKey: idempotencyKey,createdAt: createdAt,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$SyncOperationsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $SyncOperationsTable,
    SyncOperation,
    $$SyncOperationsTableFilterComposer,
    $$SyncOperationsTableOrderingComposer,
    $$SyncOperationsTableAnnotationComposer,
    $$SyncOperationsTableCreateCompanionBuilder,
    $$SyncOperationsTableUpdateCompanionBuilder,
    (SyncOperation,BaseReferences<_$AppDatabase,$SyncOperationsTable,SyncOperation>),
    SyncOperation,
    PrefetchHooks Function()
    >;typedef $$DailyScoresTableCreateCompanionBuilder = DailyScoresCompanion Function({required String id,required String userId,required String date,required int trueScore,required String verdict,required int big3Points,required int pomodoroPoints,required int taskPoints,required int journalPoints,required int activePoints,required int penaltyPoints,Value<bool> focusBadgeEarned,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
typedef $$DailyScoresTableUpdateCompanionBuilder = DailyScoresCompanion Function({Value<String> id,Value<String> userId,Value<String> date,Value<int> trueScore,Value<String> verdict,Value<int> big3Points,Value<int> pomodoroPoints,Value<int> taskPoints,Value<int> journalPoints,Value<int> activePoints,Value<int> penaltyPoints,Value<bool> focusBadgeEarned,Value<DateTime?> syncedAt,Value<DateTime?> deletedAt,Value<int> rowid,});
class $$DailyScoresTableFilterComposer extends Composer<
        _$AppDatabase,
        $DailyScoresTable> {
        $$DailyScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get trueScore => $composableBuilder(
      column: $table.trueScore,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get verdict => $composableBuilder(
      column: $table.verdict,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get big3Points => $composableBuilder(
      column: $table.big3Points,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get pomodoroPoints => $composableBuilder(
      column: $table.pomodoroPoints,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get taskPoints => $composableBuilder(
      column: $table.taskPoints,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get journalPoints => $composableBuilder(
      column: $table.journalPoints,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get activePoints => $composableBuilder(
      column: $table.activePoints,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<int> get penaltyPoints => $composableBuilder(
      column: $table.penaltyPoints,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get focusBadgeEarned => $composableBuilder(
      column: $table.focusBadgeEarned,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$DailyScoresTableOrderingComposer extends Composer<
        _$AppDatabase,
        $DailyScoresTable> {
        $$DailyScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get trueScore => $composableBuilder(
      column: $table.trueScore,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get verdict => $composableBuilder(
      column: $table.verdict,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get big3Points => $composableBuilder(
      column: $table.big3Points,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get pomodoroPoints => $composableBuilder(
      column: $table.pomodoroPoints,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get taskPoints => $composableBuilder(
      column: $table.taskPoints,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get journalPoints => $composableBuilder(
      column: $table.journalPoints,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get activePoints => $composableBuilder(
      column: $table.activePoints,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<int> get penaltyPoints => $composableBuilder(
      column: $table.penaltyPoints,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get focusBadgeEarned => $composableBuilder(
      column: $table.focusBadgeEarned,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$DailyScoresTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $DailyScoresTable> {
        $$DailyScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => column);
      
GeneratedColumn<String> get date => $composableBuilder(
      column: $table.date,
      builder: (column) => column);
      
GeneratedColumn<int> get trueScore => $composableBuilder(
      column: $table.trueScore,
      builder: (column) => column);
      
GeneratedColumn<String> get verdict => $composableBuilder(
      column: $table.verdict,
      builder: (column) => column);
      
GeneratedColumn<int> get big3Points => $composableBuilder(
      column: $table.big3Points,
      builder: (column) => column);
      
GeneratedColumn<int> get pomodoroPoints => $composableBuilder(
      column: $table.pomodoroPoints,
      builder: (column) => column);
      
GeneratedColumn<int> get taskPoints => $composableBuilder(
      column: $table.taskPoints,
      builder: (column) => column);
      
GeneratedColumn<int> get journalPoints => $composableBuilder(
      column: $table.journalPoints,
      builder: (column) => column);
      
GeneratedColumn<int> get activePoints => $composableBuilder(
      column: $table.activePoints,
      builder: (column) => column);
      
GeneratedColumn<int> get penaltyPoints => $composableBuilder(
      column: $table.penaltyPoints,
      builder: (column) => column);
      
GeneratedColumn<bool> get focusBadgeEarned => $composableBuilder(
      column: $table.focusBadgeEarned,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt,
      builder: (column) => column);
      
        }
      class $$DailyScoresTableTableManager extends RootTableManager    <_$AppDatabase,
    $DailyScoresTable,
    DailyScore,
    $$DailyScoresTableFilterComposer,
    $$DailyScoresTableOrderingComposer,
    $$DailyScoresTableAnnotationComposer,
    $$DailyScoresTableCreateCompanionBuilder,
    $$DailyScoresTableUpdateCompanionBuilder,
    (DailyScore,BaseReferences<_$AppDatabase,$DailyScoresTable,DailyScore>),
    DailyScore,
    PrefetchHooks Function()
    > {
    $$DailyScoresTableTableManager(_$AppDatabase db, $DailyScoresTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$DailyScoresTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$DailyScoresTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$DailyScoresTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<String> id = const Value.absent(),Value<String> userId = const Value.absent(),Value<String> date = const Value.absent(),Value<int> trueScore = const Value.absent(),Value<String> verdict = const Value.absent(),Value<int> big3Points = const Value.absent(),Value<int> pomodoroPoints = const Value.absent(),Value<int> taskPoints = const Value.absent(),Value<int> journalPoints = const Value.absent(),Value<int> activePoints = const Value.absent(),Value<int> penaltyPoints = const Value.absent(),Value<bool> focusBadgeEarned = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> DailyScoresCompanion(id: id,userId: userId,date: date,trueScore: trueScore,verdict: verdict,big3Points: big3Points,pomodoroPoints: pomodoroPoints,taskPoints: taskPoints,journalPoints: journalPoints,activePoints: activePoints,penaltyPoints: penaltyPoints,focusBadgeEarned: focusBadgeEarned,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        createCompanionCallback: ({required String id,required String userId,required String date,required int trueScore,required String verdict,required int big3Points,required int pomodoroPoints,required int taskPoints,required int journalPoints,required int activePoints,required int penaltyPoints,Value<bool> focusBadgeEarned = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<DateTime?> deletedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> DailyScoresCompanion.insert(id: id,userId: userId,date: date,trueScore: trueScore,verdict: verdict,big3Points: big3Points,pomodoroPoints: pomodoroPoints,taskPoints: taskPoints,journalPoints: journalPoints,activePoints: activePoints,penaltyPoints: penaltyPoints,focusBadgeEarned: focusBadgeEarned,syncedAt: syncedAt,deletedAt: deletedAt,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$DailyScoresTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $DailyScoresTable,
    DailyScore,
    $$DailyScoresTableFilterComposer,
    $$DailyScoresTableOrderingComposer,
    $$DailyScoresTableAnnotationComposer,
    $$DailyScoresTableCreateCompanionBuilder,
    $$DailyScoresTableUpdateCompanionBuilder,
    (DailyScore,BaseReferences<_$AppDatabase,$DailyScoresTable,DailyScore>),
    DailyScore,
    PrefetchHooks Function()
    >;typedef $$SemesterGoalsTableCreateCompanionBuilder = SemesterGoalsCompanion Function({required String id,required String userId,required String title,required String targetDate,Value<bool> isCompleted,required DateTime createdAt,Value<DateTime?> syncedAt,Value<int> rowid,});
typedef $$SemesterGoalsTableUpdateCompanionBuilder = SemesterGoalsCompanion Function({Value<String> id,Value<String> userId,Value<String> title,Value<String> targetDate,Value<bool> isCompleted,Value<DateTime> createdAt,Value<DateTime?> syncedAt,Value<int> rowid,});
class $$SemesterGoalsTableFilterComposer extends Composer<
        _$AppDatabase,
        $SemesterGoalsTable> {
        $$SemesterGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnFilters<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<String> get targetDate => $composableBuilder(
      column: $table.targetDate,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnFilters(column));
      
ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnFilters(column));
      
        }
      class $$SemesterGoalsTableOrderingComposer extends Composer<
        _$AppDatabase,
        $SemesterGoalsTable> {
        $$SemesterGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<String> get targetDate => $composableBuilder(
      column: $table.targetDate,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => 
      ColumnOrderings(column));
      
ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => 
      ColumnOrderings(column));
      
        }
      class $$SemesterGoalsTableAnnotationComposer extends Composer<
        _$AppDatabase,
        $SemesterGoalsTable> {
        $$SemesterGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
          GeneratedColumn<String> get id => $composableBuilder(
      column: $table.id,
      builder: (column) => column);
      
GeneratedColumn<String> get userId => $composableBuilder(
      column: $table.userId,
      builder: (column) => column);
      
GeneratedColumn<String> get title => $composableBuilder(
      column: $table.title,
      builder: (column) => column);
      
GeneratedColumn<String> get targetDate => $composableBuilder(
      column: $table.targetDate,
      builder: (column) => column);
      
GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => column);
      
GeneratedColumn<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt,
      builder: (column) => column);
      
        }
      class $$SemesterGoalsTableTableManager extends RootTableManager    <_$AppDatabase,
    $SemesterGoalsTable,
    SemesterGoal,
    $$SemesterGoalsTableFilterComposer,
    $$SemesterGoalsTableOrderingComposer,
    $$SemesterGoalsTableAnnotationComposer,
    $$SemesterGoalsTableCreateCompanionBuilder,
    $$SemesterGoalsTableUpdateCompanionBuilder,
    (SemesterGoal,BaseReferences<_$AppDatabase,$SemesterGoalsTable,SemesterGoal>),
    SemesterGoal,
    PrefetchHooks Function()
    > {
    $$SemesterGoalsTableTableManager(_$AppDatabase db, $SemesterGoalsTable table) : super(
      TableManagerState(
        db: db,
        table: table,
        createFilteringComposer: () => $$SemesterGoalsTableFilterComposer($db: db,$table:table),
        createOrderingComposer: () => $$SemesterGoalsTableOrderingComposer($db: db,$table:table),
        createComputedFieldComposer: () => $$SemesterGoalsTableAnnotationComposer($db: db,$table:table),
        updateCompanionCallback: ({Value<String> id = const Value.absent(),Value<String> userId = const Value.absent(),Value<String> title = const Value.absent(),Value<String> targetDate = const Value.absent(),Value<bool> isCompleted = const Value.absent(),Value<DateTime> createdAt = const Value.absent(),Value<DateTime?> syncedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> SemesterGoalsCompanion(id: id,userId: userId,title: title,targetDate: targetDate,isCompleted: isCompleted,createdAt: createdAt,syncedAt: syncedAt,rowid: rowid,),
        createCompanionCallback: ({required String id,required String userId,required String title,required String targetDate,Value<bool> isCompleted = const Value.absent(),required DateTime createdAt,Value<DateTime?> syncedAt = const Value.absent(),Value<int> rowid = const Value.absent(),})=> SemesterGoalsCompanion.insert(id: id,userId: userId,title: title,targetDate: targetDate,isCompleted: isCompleted,createdAt: createdAt,syncedAt: syncedAt,rowid: rowid,),
        withReferenceMapper: (p0) => p0
              .map(
                  (e) =>
                     (e.readTable(table), BaseReferences(db, table, e))
                  )
              .toList(),
        prefetchHooksCallback: null,
        ));
        }
    typedef $$SemesterGoalsTableProcessedTableManager = ProcessedTableManager    <_$AppDatabase,
    $SemesterGoalsTable,
    SemesterGoal,
    $$SemesterGoalsTableFilterComposer,
    $$SemesterGoalsTableOrderingComposer,
    $$SemesterGoalsTableAnnotationComposer,
    $$SemesterGoalsTableCreateCompanionBuilder,
    $$SemesterGoalsTableUpdateCompanionBuilder,
    (SemesterGoal,BaseReferences<_$AppDatabase,$SemesterGoalsTable,SemesterGoal>),
    SemesterGoal,
    PrefetchHooks Function()
    >;class $AppDatabaseManager {
final _$AppDatabase _db;
$AppDatabaseManager(this._db);
$$GoalsTableTableManager get goals => $$GoalsTableTableManager(_db, _db.goals);
$$TasksTableTableManager get tasks => $$TasksTableTableManager(_db, _db.tasks);
$$PomodoroSessionsTableTableManager get pomodoroSessions => $$PomodoroSessionsTableTableManager(_db, _db.pomodoroSessions);
$$JournalEntriesTableTableManager get journalEntries => $$JournalEntriesTableTableManager(_db, _db.journalEntries);
$$SyncOperationsTableTableManager get syncOperations => $$SyncOperationsTableTableManager(_db, _db.syncOperations);
$$DailyScoresTableTableManager get dailyScores => $$DailyScoresTableTableManager(_db, _db.dailyScores);
$$SemesterGoalsTableTableManager get semesterGoals => $$SemesterGoalsTableTableManager(_db, _db.semesterGoals);
}
