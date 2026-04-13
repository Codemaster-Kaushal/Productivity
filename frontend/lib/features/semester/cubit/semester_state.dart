import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/semester_goal.dart';

part 'semester_state.freezed.dart';

@freezed
class SemesterState with _$SemesterState {
  const factory SemesterState.initial() = _Initial;
  const factory SemesterState.loading() = _Loading;
  const factory SemesterState.loaded(List<SemesterGoal> goals) = _Loaded;
  const factory SemesterState.error(String message) = _Error;
}
