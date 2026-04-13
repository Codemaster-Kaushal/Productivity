// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SemesterGoal _$SemesterGoalFromJson(Map<String, dynamic> json) {
  return _SemesterGoal.fromJson(json);
}

/// @nodoc
mixin _$SemesterGoal {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get semesterLabel => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SemesterGoalCopyWith<SemesterGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterGoalCopyWith<$Res> {
  factory $SemesterGoalCopyWith(
          SemesterGoal value, $Res Function(SemesterGoal) then) =
      _$SemesterGoalCopyWithImpl<$Res, SemesterGoal>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String subject,
      String title,
      String semesterLabel,
      String startDate,
      String endDate,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class _$SemesterGoalCopyWithImpl<$Res, $Val extends SemesterGoal>
    implements $SemesterGoalCopyWith<$Res> {
  _$SemesterGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? subject = null,
    Object? title = null,
    Object? semesterLabel = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? isActive = null,
    Object? createdAt = null,
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
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      semesterLabel: null == semesterLabel
          ? _value.semesterLabel
          : semesterLabel // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemesterGoalImplCopyWith<$Res>
    implements $SemesterGoalCopyWith<$Res> {
  factory _$$SemesterGoalImplCopyWith(
          _$SemesterGoalImpl value, $Res Function(_$SemesterGoalImpl) then) =
      __$$SemesterGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String subject,
      String title,
      String semesterLabel,
      String startDate,
      String endDate,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class __$$SemesterGoalImplCopyWithImpl<$Res>
    extends _$SemesterGoalCopyWithImpl<$Res, _$SemesterGoalImpl>
    implements _$$SemesterGoalImplCopyWith<$Res> {
  __$$SemesterGoalImplCopyWithImpl(
      _$SemesterGoalImpl _value, $Res Function(_$SemesterGoalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? subject = null,
    Object? title = null,
    Object? semesterLabel = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_$SemesterGoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      semesterLabel: null == semesterLabel
          ? _value.semesterLabel
          : semesterLabel // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SemesterGoalImpl extends _SemesterGoal {
  const _$SemesterGoalImpl(
      {required this.id,
      required this.userId,
      required this.subject,
      required this.title,
      required this.semesterLabel,
      required this.startDate,
      required this.endDate,
      this.isActive = true,
      required this.createdAt})
      : super._();

  factory _$SemesterGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$SemesterGoalImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String subject;
  @override
  final String title;
  @override
  final String semesterLabel;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SemesterGoal(id: $id, userId: $userId, subject: $subject, title: $title, semesterLabel: $semesterLabel, startDate: $startDate, endDate: $endDate, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.semesterLabel, semesterLabel) ||
                other.semesterLabel == semesterLabel) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, subject, title,
      semesterLabel, startDate, endDate, isActive, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterGoalImplCopyWith<_$SemesterGoalImpl> get copyWith =>
      __$$SemesterGoalImplCopyWithImpl<_$SemesterGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SemesterGoalImplToJson(
      this,
    );
  }
}

abstract class _SemesterGoal extends SemesterGoal {
  const factory _SemesterGoal(
      {required final String id,
      required final String userId,
      required final String subject,
      required final String title,
      required final String semesterLabel,
      required final String startDate,
      required final String endDate,
      final bool isActive,
      required final DateTime createdAt}) = _$SemesterGoalImpl;
  const _SemesterGoal._() : super._();

  factory _SemesterGoal.fromJson(Map<String, dynamic> json) =
      _$SemesterGoalImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get subject;
  @override
  String get title;
  @override
  String get semesterLabel;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$SemesterGoalImplCopyWith<_$SemesterGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
