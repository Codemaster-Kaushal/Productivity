import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/daily_score.dart';

part 'scores_state.freezed.dart';

@freezed
class ScoresState with _$ScoresState {
  const factory ScoresState.initial() = _Initial;
  const factory ScoresState.loading() = _Loading;
  const factory ScoresState.loaded({
    required DailyScore todayScore,
    required List<DailyScore> history,
  }) = _Loaded;
  const factory ScoresState.error(String message) = _Error;
}
