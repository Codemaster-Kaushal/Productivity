import 'package:freezed_annotation/freezed_annotation.dart';

part 'friends_state.freezed.dart';

@freezed
class FriendsState with _$FriendsState {
  const factory FriendsState.initial() = _Initial;
  const factory FriendsState.loading() = _Loading;
  const factory FriendsState.loaded({
    required List<FriendStreak> friends,
    String? myCode,
  }) = _Loaded;
  const factory FriendsState.error(String message) = _Error;
}

class FriendStreak {
  final String displayName;
  final String code;
  final int streak;

  FriendStreak({
    required this.displayName,
    required this.code,
    required this.streak,
  });
}
