// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PomodoroState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int secondsRemaining, int totalSeconds) running,
    required TResult Function(int secondsRemaining, int totalSeconds) paused,
    required TResult Function(PomodoroSession session) completed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int secondsRemaining, int totalSeconds)? running,
    TResult? Function(int secondsRemaining, int totalSeconds)? paused,
    TResult? Function(PomodoroSession session)? completed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int secondsRemaining, int totalSeconds)? running,
    TResult Function(int secondsRemaining, int totalSeconds)? paused,
    TResult Function(PomodoroSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    TResult Function(_Paused value)? paused,
    TResult Function(_Completed value)? completed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PomodoroStateCopyWith<$Res> {
  factory $PomodoroStateCopyWith(
          PomodoroState value, $Res Function(PomodoroState) then) =
      _$PomodoroStateCopyWithImpl<$Res, PomodoroState>;
}

/// @nodoc
class _$PomodoroStateCopyWithImpl<$Res, $Val extends PomodoroState>
    implements $PomodoroStateCopyWith<$Res> {
  _$PomodoroStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PomodoroStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'PomodoroState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int secondsRemaining, int totalSeconds) running,
    required TResult Function(int secondsRemaining, int totalSeconds) paused,
    required TResult Function(PomodoroSession session) completed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int secondsRemaining, int totalSeconds)? running,
    TResult? Function(int secondsRemaining, int totalSeconds)? paused,
    TResult? Function(PomodoroSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int secondsRemaining, int totalSeconds)? running,
    TResult Function(int secondsRemaining, int totalSeconds)? paused,
    TResult Function(PomodoroSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    TResult Function(_Paused value)? paused,
    TResult Function(_Completed value)? completed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PomodoroState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$RunningImplCopyWith<$Res> {
  factory _$$RunningImplCopyWith(
          _$RunningImpl value, $Res Function(_$RunningImpl) then) =
      __$$RunningImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int secondsRemaining, int totalSeconds});
}

/// @nodoc
class __$$RunningImplCopyWithImpl<$Res>
    extends _$PomodoroStateCopyWithImpl<$Res, _$RunningImpl>
    implements _$$RunningImplCopyWith<$Res> {
  __$$RunningImplCopyWithImpl(
      _$RunningImpl _value, $Res Function(_$RunningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secondsRemaining = null,
    Object? totalSeconds = null,
  }) {
    return _then(_$RunningImpl(
      secondsRemaining: null == secondsRemaining
          ? _value.secondsRemaining
          : secondsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      totalSeconds: null == totalSeconds
          ? _value.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RunningImpl implements _Running {
  const _$RunningImpl(
      {required this.secondsRemaining, required this.totalSeconds});

  @override
  final int secondsRemaining;
  @override
  final int totalSeconds;

  @override
  String toString() {
    return 'PomodoroState.running(secondsRemaining: $secondsRemaining, totalSeconds: $totalSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RunningImpl &&
            (identical(other.secondsRemaining, secondsRemaining) ||
                other.secondsRemaining == secondsRemaining) &&
            (identical(other.totalSeconds, totalSeconds) ||
                other.totalSeconds == totalSeconds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, secondsRemaining, totalSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RunningImplCopyWith<_$RunningImpl> get copyWith =>
      __$$RunningImplCopyWithImpl<_$RunningImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int secondsRemaining, int totalSeconds) running,
    required TResult Function(int secondsRemaining, int totalSeconds) paused,
    required TResult Function(PomodoroSession session) completed,
    required TResult Function(String message) error,
  }) {
    return running(secondsRemaining, totalSeconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int secondsRemaining, int totalSeconds)? running,
    TResult? Function(int secondsRemaining, int totalSeconds)? paused,
    TResult? Function(PomodoroSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return running?.call(secondsRemaining, totalSeconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int secondsRemaining, int totalSeconds)? running,
    TResult Function(int secondsRemaining, int totalSeconds)? paused,
    TResult Function(PomodoroSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(secondsRemaining, totalSeconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Error value) error,
  }) {
    return running(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Error value)? error,
  }) {
    return running?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    TResult Function(_Paused value)? paused,
    TResult Function(_Completed value)? completed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(this);
    }
    return orElse();
  }
}

abstract class _Running implements PomodoroState {
  const factory _Running(
      {required final int secondsRemaining,
      required final int totalSeconds}) = _$RunningImpl;

  int get secondsRemaining;
  int get totalSeconds;
  @JsonKey(ignore: true)
  _$$RunningImplCopyWith<_$RunningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PausedImplCopyWith<$Res> {
  factory _$$PausedImplCopyWith(
          _$PausedImpl value, $Res Function(_$PausedImpl) then) =
      __$$PausedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int secondsRemaining, int totalSeconds});
}

/// @nodoc
class __$$PausedImplCopyWithImpl<$Res>
    extends _$PomodoroStateCopyWithImpl<$Res, _$PausedImpl>
    implements _$$PausedImplCopyWith<$Res> {
  __$$PausedImplCopyWithImpl(
      _$PausedImpl _value, $Res Function(_$PausedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secondsRemaining = null,
    Object? totalSeconds = null,
  }) {
    return _then(_$PausedImpl(
      secondsRemaining: null == secondsRemaining
          ? _value.secondsRemaining
          : secondsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      totalSeconds: null == totalSeconds
          ? _value.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PausedImpl implements _Paused {
  const _$PausedImpl(
      {required this.secondsRemaining, required this.totalSeconds});

  @override
  final int secondsRemaining;
  @override
  final int totalSeconds;

  @override
  String toString() {
    return 'PomodoroState.paused(secondsRemaining: $secondsRemaining, totalSeconds: $totalSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PausedImpl &&
            (identical(other.secondsRemaining, secondsRemaining) ||
                other.secondsRemaining == secondsRemaining) &&
            (identical(other.totalSeconds, totalSeconds) ||
                other.totalSeconds == totalSeconds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, secondsRemaining, totalSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PausedImplCopyWith<_$PausedImpl> get copyWith =>
      __$$PausedImplCopyWithImpl<_$PausedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int secondsRemaining, int totalSeconds) running,
    required TResult Function(int secondsRemaining, int totalSeconds) paused,
    required TResult Function(PomodoroSession session) completed,
    required TResult Function(String message) error,
  }) {
    return paused(secondsRemaining, totalSeconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int secondsRemaining, int totalSeconds)? running,
    TResult? Function(int secondsRemaining, int totalSeconds)? paused,
    TResult? Function(PomodoroSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return paused?.call(secondsRemaining, totalSeconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int secondsRemaining, int totalSeconds)? running,
    TResult Function(int secondsRemaining, int totalSeconds)? paused,
    TResult Function(PomodoroSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(secondsRemaining, totalSeconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Error value) error,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Error value)? error,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    TResult Function(_Paused value)? paused,
    TResult Function(_Completed value)? completed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }
}

abstract class _Paused implements PomodoroState {
  const factory _Paused(
      {required final int secondsRemaining,
      required final int totalSeconds}) = _$PausedImpl;

  int get secondsRemaining;
  int get totalSeconds;
  @JsonKey(ignore: true)
  _$$PausedImplCopyWith<_$PausedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompletedImplCopyWith<$Res> {
  factory _$$CompletedImplCopyWith(
          _$CompletedImpl value, $Res Function(_$CompletedImpl) then) =
      __$$CompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PomodoroSession session});

  $PomodoroSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$CompletedImplCopyWithImpl<$Res>
    extends _$PomodoroStateCopyWithImpl<$Res, _$CompletedImpl>
    implements _$$CompletedImplCopyWith<$Res> {
  __$$CompletedImplCopyWithImpl(
      _$CompletedImpl _value, $Res Function(_$CompletedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$CompletedImpl(
      null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as PomodoroSession,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PomodoroSessionCopyWith<$Res> get session {
    return $PomodoroSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$CompletedImpl implements _Completed {
  const _$CompletedImpl(this.session);

  @override
  final PomodoroSession session;

  @override
  String toString() {
    return 'PomodoroState.completed(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompletedImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompletedImplCopyWith<_$CompletedImpl> get copyWith =>
      __$$CompletedImplCopyWithImpl<_$CompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int secondsRemaining, int totalSeconds) running,
    required TResult Function(int secondsRemaining, int totalSeconds) paused,
    required TResult Function(PomodoroSession session) completed,
    required TResult Function(String message) error,
  }) {
    return completed(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int secondsRemaining, int totalSeconds)? running,
    TResult? Function(int secondsRemaining, int totalSeconds)? paused,
    TResult? Function(PomodoroSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int secondsRemaining, int totalSeconds)? running,
    TResult Function(int secondsRemaining, int totalSeconds)? paused,
    TResult Function(PomodoroSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Error value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Error value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    TResult Function(_Paused value)? paused,
    TResult Function(_Completed value)? completed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class _Completed implements PomodoroState {
  const factory _Completed(final PomodoroSession session) = _$CompletedImpl;

  PomodoroSession get session;
  @JsonKey(ignore: true)
  _$$CompletedImplCopyWith<_$CompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$PomodoroStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PomodoroState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int secondsRemaining, int totalSeconds) running,
    required TResult Function(int secondsRemaining, int totalSeconds) paused,
    required TResult Function(PomodoroSession session) completed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int secondsRemaining, int totalSeconds)? running,
    TResult? Function(int secondsRemaining, int totalSeconds)? paused,
    TResult? Function(PomodoroSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int secondsRemaining, int totalSeconds)? running,
    TResult Function(int secondsRemaining, int totalSeconds)? paused,
    TResult Function(PomodoroSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    TResult Function(_Paused value)? paused,
    TResult Function(_Completed value)? completed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements PomodoroState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
