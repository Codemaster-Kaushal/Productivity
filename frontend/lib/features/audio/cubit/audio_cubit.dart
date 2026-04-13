import 'package:flutter_bloc/flutter_bloc.dart';
import 'audio_state.dart';

/// Lightweight audio cubit. Actual audio playback uses HTML5 Audio on web.
/// For a richer experience on Windows/Android, replace with just_audio later.
class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(const AudioState.stopped());

  void play(String trackName, String trackUrl) {
    emit(AudioState.playing(trackName: trackName, trackUrl: trackUrl));
  }

  void pause() {
    state.maybeWhen(
      playing: (name, url) {
        emit(AudioState.paused(trackName: name, trackUrl: url));
      },
      orElse: () {},
    );
  }

  void resume() {
    state.maybeWhen(
      paused: (name, url) {
        emit(AudioState.playing(trackName: name, trackUrl: url));
      },
      orElse: () {},
    );
  }

  void stop() {
    emit(const AudioState.stopped());
  }
}
