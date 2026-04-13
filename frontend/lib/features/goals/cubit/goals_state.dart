import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/goal.dart';

part 'goals_state.freezed.dart';

@freezed
class GoalsState with _$GoalsState {
  const factory GoalsState.initial() = _Initial;
  const factory GoalsState.loading() = _Loading;
  const factory GoalsState.loaded(List<Goal> goals) = _Loaded;
  const factory GoalsState.error(String message) = _Error;
}
