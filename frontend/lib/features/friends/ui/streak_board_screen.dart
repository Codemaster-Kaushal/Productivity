import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/friends_cubit.dart';
import '../cubit/friends_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/theme/aurora_theme.dart';

class StreakBoardScreen extends StatelessWidget {
  const StreakBoardScreen({super.key});

  void _showAddFriendDialog(BuildContext context) {
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Connect User', style: AppTextStyles.h2),
        content: TextField(
          controller: codeController,
          textCapitalization: TextCapitalization.characters,
          maxLength: 6,
          decoration: const InputDecoration(
            hintText: 'Enter 6-letter frequency code',
          ),
          style: AppTextStyles.body.copyWith(letterSpacing: 2),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: AppTextStyles.bodySecondary),
          ),
          AuroraTheme.gradientButton(
            text: 'Add Connection',
            onPressed: () {
              if (codeController.text.length == 6) {
                context.read<FriendsCubit>().addFriend(codeController.text);
                Navigator.pop(dialogContext);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<FriendsCubit, FriendsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(msg, style: const TextStyle(color: AppColors.scoreRed))),
            loaded: (friends, myCode) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuroraTheme.sectionHeader('Celestial Universe'),
                    const SizedBox(height: 32),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Global Network', style: AppTextStyles.h1),
                            const SizedBox(height: 8),
                            Text('Your position within the synced collective.', style: AppTextStyles.bodySecondary),
                          ],
                        ),
                        AuroraTheme.gradientButton(
                          text: 'Add Connection',
                          onPressed: () => _showAddFriendDialog(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 800;
                        final connectionCode = _buildConnectionCode(context, myCode);
                        final streaks = _buildOrbitalStreaks(friends);

                        if (isWide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: streaks),
                              const SizedBox(width: 32),
                              Expanded(flex: 1, child: connectionCode),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              connectionCode,
                              const SizedBox(height: 32),
                              streaks,
                            ],
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildOrbitalStreaks(List friends) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Orbital Streaks', style: AppTextStyles.h3),
            Text('TOP 10', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: AuroraTheme.card,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.isEmpty ? 1 : friends.length,
            separatorBuilder: (_, _) => Divider(color: AppColors.surfaceBorder, height: 1),
            itemBuilder: (context, index) {
              if (friends.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text('No connections yet. Share your identity code.', style: AppTextStyles.bodySecondary),
                  ),
                );
              }
              final f = friends[index];
              final isTop = index == 0;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text('0${index + 1}', style: AppTextStyles.label.copyWith(color: isTop ? AppColors.primary : AppColors.textSecondary)),
                    ),
                    const SizedBox(width: 16),
                    CircleAvatar(
                      backgroundColor: isTop ? AppColors.primary.withOpacity(0.2) : AppColors.surfaceBorder,
                      child: Text(f.displayName.substring(0, 1).toUpperCase(), 
                        style: TextStyle(color: isTop ? AppColors.primary : AppColors.textPrimary)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f.displayName, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                          Text(f.code, style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department, color: AppColors.primary, size: 16),
                        const SizedBox(width: 4),
                        Text('${f.streak}', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildConnectionCode(BuildContext context, String? myCode) {
    return Container(
      decoration: AuroraTheme.card,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.hub_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('Identity Node', style: AppTextStyles.h3),
            ],
          ),
          const SizedBox(height: 24),
          Text('YOUR FREQUENCY CODE', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (myCode != null) {
                Clipboard.setData(ClipboardData(text: myCode));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Frequency code copied.'), backgroundColor: AppColors.primary)
                );
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  myCode ?? '...',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    letterSpacing: 8,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Share this code with other nodes to sync your progress within the collective.', style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
          const SizedBox(height: 32),

          Text('CURRENT STATUS', style: AppTextStyles.label.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          Row(
            children: [
              AuroraTheme.statusTag('ONLINE', color: AppColors.scoreGreen),
              const SizedBox(width: 8),
              AuroraTheme.statusTag('HIGH ALIGNMENT', color: AppColors.primaryLight),
            ],
          )
        ],
      ),
    );
  }
}
