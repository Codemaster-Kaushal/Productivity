import 'package:freezed_annotation/freezed_annotation.dart';

part 'quick_capture_state.freezed.dart';

@freezed
class QuickCaptureState with _$QuickCaptureState {
  const factory QuickCaptureState.idle() = _Idle;
  const factory QuickCaptureState.parsing() = _Parsing;
  const factory QuickCaptureState.saved(String title, String type) = _Saved;
  const factory QuickCaptureState.error(String message) = _Error;
}
