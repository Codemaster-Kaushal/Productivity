// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_operation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncOperation _$SyncOperationFromJson(Map<String, dynamic> json) {
  return _SyncOperation.fromJson(json);
}

/// @nodoc
mixin _$SyncOperation {
  String get id => throw _privateConstructorUsedError;
  String get collection => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncOperationCopyWith<SyncOperation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncOperationCopyWith<$Res> {
  factory $SyncOperationCopyWith(
          SyncOperation value, $Res Function(SyncOperation) then) =
      _$SyncOperationCopyWithImpl<$Res, SyncOperation>;
  @useResult
  $Res call(
      {String id,
      String collection,
      String method,
      String payload,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class _$SyncOperationCopyWithImpl<$Res, $Val extends SyncOperation>
    implements $SyncOperationCopyWith<$Res> {
  _$SyncOperationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? collection = null,
    Object? method = null,
    Object? payload = null,
    Object? createdAt = null,
    Object? syncedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SyncOperationImplCopyWith<$Res>
    implements $SyncOperationCopyWith<$Res> {
  factory _$$SyncOperationImplCopyWith(
          _$SyncOperationImpl value, $Res Function(_$SyncOperationImpl) then) =
      __$$SyncOperationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String collection,
      String method,
      String payload,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class __$$SyncOperationImplCopyWithImpl<$Res>
    extends _$SyncOperationCopyWithImpl<$Res, _$SyncOperationImpl>
    implements _$$SyncOperationImplCopyWith<$Res> {
  __$$SyncOperationImplCopyWithImpl(
      _$SyncOperationImpl _value, $Res Function(_$SyncOperationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? collection = null,
    Object? method = null,
    Object? payload = null,
    Object? createdAt = null,
    Object? syncedAt = freezed,
  }) {
    return _then(_$SyncOperationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
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
class _$SyncOperationImpl extends _SyncOperation {
  const _$SyncOperationImpl(
      {required this.id,
      required this.collection,
      required this.method,
      required this.payload,
      required this.createdAt,
      this.syncedAt})
      : super._();

  factory _$SyncOperationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncOperationImplFromJson(json);

  @override
  final String id;
  @override
  final String collection;
  @override
  final String method;
  @override
  final String payload;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;

  @override
  String toString() {
    return 'SyncOperation(id: $id, collection: $collection, method: $method, payload: $payload, createdAt: $createdAt, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncOperationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, collection, method, payload, createdAt, syncedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncOperationImplCopyWith<_$SyncOperationImpl> get copyWith =>
      __$$SyncOperationImplCopyWithImpl<_$SyncOperationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncOperationImplToJson(
      this,
    );
  }
}

abstract class _SyncOperation extends SyncOperation {
  const factory _SyncOperation(
      {required final String id,
      required final String collection,
      required final String method,
      required final String payload,
      required final DateTime createdAt,
      final DateTime? syncedAt}) = _$SyncOperationImpl;
  const _SyncOperation._() : super._();

  factory _SyncOperation.fromJson(Map<String, dynamic> json) =
      _$SyncOperationImpl.fromJson;

  @override
  String get id;
  @override
  String get collection;
  @override
  String get method;
  @override
  String get payload;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt;
  @override
  @JsonKey(ignore: true)
  _$$SyncOperationImplCopyWith<_$SyncOperationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
