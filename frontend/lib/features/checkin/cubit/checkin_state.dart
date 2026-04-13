import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkin_state.freezed.dart';

@freezed
class CheckinState with _$CheckinState {
  const factory CheckinState.initial() = _Initial;
  const factory CheckinState.saving() = _Saving;
  const factory CheckinState.saved() = _Saved;
  const factory CheckinState.error(String message) = _Error;
}
