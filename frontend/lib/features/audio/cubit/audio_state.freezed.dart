// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function(String trackName, String trackUrl) playing,
    required TResult Function(String trackName, String trackUrl) paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function(String trackName, String trackUrl)? playing,
    TResult? Function(String trackName, String trackUrl)? paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function(String trackName, String trackUrl)? playing,
    TResult Function(String trackName, String trackUrl)? paused,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Stopped value) stopped,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Stopped value)? stopped,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Stopped value)? stopped,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStateCopyWith<$Res> {
  factory $AudioStateCopyWith(
          AudioState value, $Res Function(AudioState) then) =
      _$AudioStateCopyWithImpl<$Res, AudioState>;
}

/// @nodoc
class _$AudioStateCopyWithImpl<$Res, $Val extends AudioState>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StoppedImplCopyWith<$Res> {
  factory _$$StoppedImplCopyWith(
          _$StoppedImpl value, $Res Function(_$StoppedImpl) then) =
      __$$StoppedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StoppedImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$StoppedImpl>
    implements _$$StoppedImplCopyWith<$Res> {
  __$$StoppedImplCopyWithImpl(
      _$StoppedImpl _value, $Res Function(_$StoppedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StoppedImpl implements _Stopped {
  const _$StoppedImpl();

  @override
  String toString() {
    return 'AudioState.stopped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StoppedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function(String trackName, String trackUrl) playing,
    required TResult Function(String trackName, String trackUrl) paused,
  }) {
    return stopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function(String trackName, String trackUrl)? playing,
    TResult? Function(String trackName, String trackUrl)? paused,
  }) {
    return stopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function(String trackName, String trackUrl)? playing,
    TResult Function(String trackName, String trackUrl)? paused,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Stopped value) stopped,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) {
    return stopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Stopped value)? stopped,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) {
    return stopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Stopped value)? stopped,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped(this);
    }
    return orElse();
  }
}

abstract class _Stopped implements AudioState {
  const factory _Stopped() = _$StoppedImpl;
}

/// @nodoc
abstract class _$$PlayingImplCopyWith<$Res> {
  factory _$$PlayingImplCopyWith(
          _$PlayingImpl value, $Res Function(_$PlayingImpl) then) =
      __$$PlayingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String trackName, String trackUrl});
}

/// @nodoc
class __$$PlayingImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$PlayingImpl>
    implements _$$PlayingImplCopyWith<$Res> {
  __$$PlayingImplCopyWithImpl(
      _$PlayingImpl _value, $Res Function(_$PlayingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackName = null,
    Object? trackUrl = null,
  }) {
    return _then(_$PlayingImpl(
      trackName: null == trackName
          ? _value.trackName
          : trackName // ignore: cast_nullable_to_non_nullable
              as String,
      trackUrl: null == trackUrl
          ? _value.trackUrl
          : trackUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PlayingImpl implements _Playing {
  const _$PlayingImpl({required this.trackName, required this.trackUrl});

  @override
  final String trackName;
  @override
  final String trackUrl;

  @override
  String toString() {
    return 'AudioState.playing(trackName: $trackName, trackUrl: $trackUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayingImpl &&
            (identical(other.trackName, trackName) ||
                other.trackName == trackName) &&
            (identical(other.trackUrl, trackUrl) ||
                other.trackUrl == trackUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trackName, trackUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      __$$PlayingImplCopyWithImpl<_$PlayingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function(String trackName, String trackUrl) playing,
    required TResult Function(String trackName, String trackUrl) paused,
  }) {
    return playing(trackName, trackUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function(String trackName, String trackUrl)? playing,
    TResult? Function(String trackName, String trackUrl)? paused,
  }) {
    return playing?.call(trackName, trackUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function(String trackName, String trackUrl)? playing,
    TResult Function(String trackName, String trackUrl)? paused,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(trackName, trackUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Stopped value) stopped,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Stopped value)? stopped,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Stopped value)? stopped,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class _Playing implements AudioState {
  const factory _Playing(
      {required final String trackName,
      required final String trackUrl}) = _$PlayingImpl;

  String get trackName;
  String get trackUrl;
  @JsonKey(ignore: true)
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PausedImplCopyWith<$Res> {
  factory _$$PausedImplCopyWith(
          _$PausedImpl value, $Res Function(_$PausedImpl) then) =
      __$$PausedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String trackName, String trackUrl});
}

/// @nodoc
class __$$PausedImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$PausedImpl>
    implements _$$PausedImplCopyWith<$Res> {
  __$$PausedImplCopyWithImpl(
      _$PausedImpl _value, $Res Function(_$PausedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackName = null,
    Object? trackUrl = null,
  }) {
    return _then(_$PausedImpl(
      trackName: null == trackName
          ? _value.trackName
          : trackName // ignore: cast_nullable_to_non_nullable
              as String,
      trackUrl: null == trackUrl
          ? _value.trackUrl
          : trackUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PausedImpl implements _Paused {
  const _$PausedImpl({required this.trackName, required this.trackUrl});

  @override
  final String trackName;
  @override
  final String trackUrl;

  @override
  String toString() {
    return 'AudioState.paused(trackName: $trackName, trackUrl: $trackUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PausedImpl &&
            (identical(other.trackName, trackName) ||
                other.trackName == trackName) &&
            (identical(other.trackUrl, trackUrl) ||
                other.trackUrl == trackUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trackName, trackUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PausedImplCopyWith<_$PausedImpl> get copyWith =>
      __$$PausedImplCopyWithImpl<_$PausedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function(String trackName, String trackUrl) playing,
    required TResult Function(String trackName, String trackUrl) paused,
  }) {
    return paused(trackName, trackUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function(String trackName, String trackUrl)? playing,
    TResult? Function(String trackName, String trackUrl)? paused,
  }) {
    return paused?.call(trackName, trackUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function(String trackName, String trackUrl)? playing,
    TResult Function(String trackName, String trackUrl)? paused,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(trackName, trackUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Stopped value) stopped,
    required TResult Function(_Playing value) playing,
    required TResult Function(_Paused value) paused,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Stopped value)? stopped,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_Paused value)? paused,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Stopped value)? stopped,
    TResult Function(_Playing value)? playing,
    TResult Function(_Paused value)? paused,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }
}

abstract class _Paused implements AudioState {
  const factory _Paused(
      {required final String trackName,
      required final String trackUrl}) = _$PausedImpl;

  String get trackName;
  String get trackUrl;
  @JsonKey(ignore: true)
  _$$PausedImplCopyWith<_$PausedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
