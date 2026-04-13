import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_state.freezed.dart';

@freezed
class AudioState with _$AudioState {
  const factory AudioState.stopped() = _Stopped;
  const factory AudioState.playing({required String trackName, required String trackUrl}) = _Playing;
  const factory AudioState.paused({required String trackName, required String trackUrl}) = _Paused;
}
