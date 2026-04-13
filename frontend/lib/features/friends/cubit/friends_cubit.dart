import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'friends_state.dart';
import '../data/friends_repository.dart';

class FriendsCubit extends Cubit<FriendsState> {
  final FriendsRepository _repository;

  FriendsCubit(this._repository) : super(const FriendsState.initial()) {
    loadBoard();
  }

  Future<void> loadBoard() async {
    emit(const FriendsState.loading());
    try {
      final myCode = await _repository.getOrCreateMyCode();
      final profiles = await _repository.getFriendsBoard();

      final friends = profiles
          .map((p) => FriendStreak(
                displayName: p['display_name'] ?? 'Student',
                code: p['username_code'] ?? '',
                streak: p['current_streak'] ?? 0,
              ))
          .toList();

      emit(FriendsState.loaded(friends: friends, myCode: myCode));
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      emit(const FriendsState.error('Failed to load friends.'));
    }
  }

  Future<void> addFriend(String code) async {
    try {
      await _repository.addFriendByCode(code);
      await loadBoard();
    } catch (e) {
      emit(FriendsState.error(e.toString()));
    }
  }
}
