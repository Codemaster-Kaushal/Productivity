// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PomodoroSession _$PomodoroSessionFromJson(Map<String, dynamic> json) {
  return _PomodoroSession.fromJson(json);
}

/// @nodoc
mixin _$PomodoroSession {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get goalId => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PomodoroSessionCopyWith<PomodoroSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PomodoroSessionCopyWith<$Res> {
  factory $PomodoroSessionCopyWith(
          PomodoroSession value, $Res Function(PomodoroSession) then) =
      _$PomodoroSessionCopyWithImpl<$Res, PomodoroSession>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String goalId,
      int durationMinutes,
      DateTime startTime,
      DateTime? endTime,
      bool isCompleted,
      String date,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class _$PomodoroSessionCopyWithImpl<$Res, $Val extends PomodoroSession>
    implements $PomodoroSessionCopyWith<$Res> {
  _$PomodoroSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? goalId = null,
    Object? durationMinutes = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? isCompleted = null,
    Object? date = null,
    Object? createdAt = null,
    Object? syncedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PomodoroSessionImplCopyWith<$Res>
    implements $PomodoroSessionCopyWith<$Res> {
  factory _$$PomodoroSessionImplCopyWith(_$PomodoroSessionImpl value,
          $Res Function(_$PomodoroSessionImpl) then) =
      __$$PomodoroSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String goalId,
      int durationMinutes,
      DateTime startTime,
      DateTime? endTime,
      bool isCompleted,
      String date,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class __$$PomodoroSessionImplCopyWithImpl<$Res>
    extends _$PomodoroSessionCopyWithImpl<$Res, _$PomodoroSessionImpl>
    implements _$$PomodoroSessionImplCopyWith<$Res> {
  __$$PomodoroSessionImplCopyWithImpl(
      _$PomodoroSessionImpl _value, $Res Function(_$PomodoroSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? goalId = null,
    Object? durationMinutes = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? isCompleted = null,
    Object? date = null,
    Object? createdAt = null,
    Object? syncedAt = freezed,
  }) {
    return _then(_$PomodoroSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PomodoroSessionImpl extends _PomodoroSession {
  const _$PomodoroSessionImpl(
      {required this.id,
      required this.userId,
      required this.goalId,
      required this.durationMinutes,
      required this.startTime,
      this.endTime,
      required this.isCompleted,
      required this.date,
      required this.createdAt,
      this.syncedAt})
      : super._();

  factory _$PomodoroSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PomodoroSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String goalId;
  @override
  final int durationMinutes;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  final bool isCompleted;
  @override
  final String date;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;

  @override
  String toString() {
    return 'PomodoroSession(id: $id, userId: $userId, goalId: $goalId, durationMinutes: $durationMinutes, startTime: $startTime, endTime: $endTime, isCompleted: $isCompleted, date: $date, createdAt: $createdAt, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PomodoroSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      goalId,
      durationMinutes,
      startTime,
      endTime,
      isCompleted,
      date,
      createdAt,
      syncedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PomodoroSessionImplCopyWith<_$PomodoroSessionImpl> get copyWith =>
      __$$PomodoroSessionImplCopyWithImpl<_$PomodoroSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PomodoroSessionImplToJson(
      this,
    );
  }
}

abstract class _PomodoroSession extends PomodoroSession {
  const factory _PomodoroSession(
      {required final String id,
      required final String userId,
      required final String goalId,
      required final int durationMinutes,
      required final DateTime startTime,
      final DateTime? endTime,
      required final bool isCompleted,
      required final String date,
      required final DateTime createdAt,
      final DateTime? syncedAt}) = _$PomodoroSessionImpl;
  const _PomodoroSession._() : super._();

  factory _PomodoroSession.fromJson(Map<String, dynamic> json) =
      _$PomodoroSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get goalId;
  @override
  int get durationMinutes;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  bool get isCompleted;
  @override
  String get date;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt;
  @override
  @JsonKey(ignore: true)
  _$$PomodoroSessionImplCopyWith<_$PomodoroSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
