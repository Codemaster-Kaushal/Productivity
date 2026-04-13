// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get semesterGoalId => throw _privateConstructorUsedError;
  String? get focusWindowStart => throw _privateConstructorUsedError;
  String? get focusWindowEnd => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String subject,
      String date,
      bool isCompleted,
      String? semesterGoalId,
      String? focusWindowStart,
      String? focusWindowEnd,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? subject = null,
    Object? date = null,
    Object? isCompleted = null,
    Object? semesterGoalId = freezed,
    Object? focusWindowStart = freezed,
    Object? focusWindowEnd = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      semesterGoalId: freezed == semesterGoalId
          ? _value.semesterGoalId
          : semesterGoalId // ignore: cast_nullable_to_non_nullable
              as String?,
      focusWindowStart: freezed == focusWindowStart
          ? _value.focusWindowStart
          : focusWindowStart // ignore: cast_nullable_to_non_nullable
              as String?,
      focusWindowEnd: freezed == focusWindowEnd
          ? _value.focusWindowEnd
          : focusWindowEnd // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$GoalImplCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$GoalImplCopyWith(
          _$GoalImpl value, $Res Function(_$GoalImpl) then) =
      __$$GoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String subject,
      String date,
      bool isCompleted,
      String? semesterGoalId,
      String? focusWindowStart,
      String? focusWindowEnd,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class __$$GoalImplCopyWithImpl<$Res>
    extends _$GoalCopyWithImpl<$Res, _$GoalImpl>
    implements _$$GoalImplCopyWith<$Res> {
  __$$GoalImplCopyWithImpl(_$GoalImpl _value, $Res Function(_$GoalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? subject = null,
    Object? date = null,
    Object? isCompleted = null,
    Object? semesterGoalId = freezed,
    Object? focusWindowStart = freezed,
    Object? focusWindowEnd = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
  }) {
    return _then(_$GoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      semesterGoalId: freezed == semesterGoalId
          ? _value.semesterGoalId
          : semesterGoalId // ignore: cast_nullable_to_non_nullable
              as String?,
      focusWindowStart: freezed == focusWindowStart
          ? _value.focusWindowStart
          : focusWindowStart // ignore: cast_nullable_to_non_nullable
              as String?,
      focusWindowEnd: freezed == focusWindowEnd
          ? _value.focusWindowEnd
          : focusWindowEnd // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$GoalImpl extends _Goal {
  const _$GoalImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.subject,
      required this.date,
      this.isCompleted = false,
      this.semesterGoalId,
      this.focusWindowStart,
      this.focusWindowEnd,
      required this.createdAt,
      this.syncedAt})
      : super._();

  factory _$GoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String subject;
  @override
  final String date;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final String? semesterGoalId;
  @override
  final String? focusWindowStart;
  @override
  final String? focusWindowEnd;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;

  @override
  String toString() {
    return 'Goal(id: $id, userId: $userId, title: $title, subject: $subject, date: $date, isCompleted: $isCompleted, semesterGoalId: $semesterGoalId, focusWindowStart: $focusWindowStart, focusWindowEnd: $focusWindowEnd, createdAt: $createdAt, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.semesterGoalId, semesterGoalId) ||
                other.semesterGoalId == semesterGoalId) &&
            (identical(other.focusWindowStart, focusWindowStart) ||
                other.focusWindowStart == focusWindowStart) &&
            (identical(other.focusWindowEnd, focusWindowEnd) ||
                other.focusWindowEnd == focusWindowEnd) &&
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
      title,
      subject,
      date,
      isCompleted,
      semesterGoalId,
      focusWindowStart,
      focusWindowEnd,
      createdAt,
      syncedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      __$$GoalImplCopyWithImpl<_$GoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalImplToJson(
      this,
    );
  }
}

abstract class _Goal extends Goal {
  const factory _Goal(
      {required final String id,
      required final String userId,
      required final String title,
      required final String subject,
      required final String date,
      final bool isCompleted,
      final String? semesterGoalId,
      final String? focusWindowStart,
      final String? focusWindowEnd,
      required final DateTime createdAt,
      final DateTime? syncedAt}) = _$GoalImpl;
  const _Goal._() : super._();

  factory _Goal.fromJson(Map<String, dynamic> json) = _$GoalImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get subject;
  @override
  String get date;
  @override
  bool get isCompleted;
  @override
  String? get semesterGoalId;
  @override
  String? get focusWindowStart;
  @override
  String? get focusWindowEnd;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt;
  @override
  @JsonKey(ignore: true)
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
