import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/friends_cubit.dart';
import '../cubit/friends_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class StreakBoardScreen extends StatelessWidget {
  const StreakBoardScreen({super.key});

  void _showAddFriendDialog(BuildContext context) {
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add Friend', style: AppTextStyles.h2),
        content: TextField(
          controller: codeController,
          textCapitalization: TextCapitalization.characters,
          maxLength: 6,
          decoration: InputDecoration(
            hintText: 'Enter 6-letter code',
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              letterSpacing: 4,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade400)),
          ),
          ElevatedButton(
            onPressed: () {
              if (codeController.text.length == 6) {
                context.read<FriendsCubit>().addFriend(codeController.text);
                Navigator.pop(dialogContext);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streak Board', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddFriendDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.person_add),
      ),
      body: BlocBuilder<FriendsCubit, FriendsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(
                child: Text(msg,
                    style: const TextStyle(color: AppColors.scoreRed))),
            loaded: (friends, myCode) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // My code card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.2),
                            AppColors.primary.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: AppColors.primary.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Text('Your Friend Code',
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 13)),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              if (myCode != null) {
                                Clipboard.setData(ClipboardData(text: myCode));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Code copied!'),
                                    backgroundColor: AppColors.scoreGreen,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  myCode ?? '...',
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 6,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.copy_rounded,
                                    color: AppColors.primary, size: 20),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text('Tap to copy • Share with friends',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 12)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    if (friends.isEmpty) ...[
                      const SizedBox(height: 40),
                      Icon(Icons.people_outline,
                          size: 64, color: Colors.grey.shade600),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text('No friends yet',
                            style: AppTextStyles.bodySecondary),
                      ),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                            'Share your code or tap + to add a friend',
                            style: AppTextStyles.bodySecondary),
                      ),
                    ] else ...[
                      Text('Leaderboard 🏆',
                          style: AppTextStyles.h2.copyWith(fontSize: 18)),
                      const SizedBox(height: 12),
                      ...friends.asMap().entries.map((e) {
                        final i = e.key;
                        final f = e.value;
                        final medal = i == 0
                            ? '🥇'
                            : i == 1
                                ? '🥈'
                                : i == 2
                                    ? '🥉'
                                    : '  ';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: i == 0
                                ? Border.all(
                                    color:
                                        AppColors.scoreAmber.withOpacity(0.3))
                                : null,
                          ),
                          child: Row(
                            children: [
                              Text(medal,
                                  style: const TextStyle(fontSize: 22)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(f.displayName,
                                        style: AppTextStyles.body.copyWith(
                                            fontWeight: FontWeight.w600)),
                                    Text(f.code,
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 11)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Text('🔥',
                                      style: TextStyle(fontSize: 16)),
                                  const SizedBox(width: 4),
                                  Text('${f.streak}',
                                      style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
