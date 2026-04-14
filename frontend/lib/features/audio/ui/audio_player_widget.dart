import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/audio_cubit.dart';
import '../cubit/audio_state.dart';
import '../data/audio_tracks.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceBorder.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.waves, color: AppColors.primary, size: 18),
                  const SizedBox(width: 8),
                  Text('Focus Sounds',
                      style: GoogleFonts.inter(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  state.maybeWhen(
                    playing: (name, _) => _buildStopButton(context),
                    paused: (name, _) => _buildStopButton(context),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: audioTracks.map((track) {
                  final isPlaying = state.maybeWhen(
                    playing: (name, _) => name == track.name,
                    orElse: () => false,
                  );
                  final isPaused = state.maybeWhen(
                    paused: (name, _) => name == track.name,
                    orElse: () => false,
                  );

                  return GestureDetector(
                    onTap: () {
                      final cubit = context.read<AudioCubit>();
                      if (isPlaying) {
                        cubit.pause();
                      } else if (isPaused) {
                        cubit.resume();
                      } else {
                        cubit.play(track.name, track.url);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isPlaying ? AppColors.primary.withOpacity(0.15) : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(12),
                        border: isPlaying ? Border.all(color: AppColors.primary) : Border.all(color: Colors.transparent),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(track.icon, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text(track.name,
                              style: GoogleFonts.inter(
                                color: isPlaying ? AppColors.textPrimary : AppColors.textSecondary,
                                fontSize: 13,
                                fontWeight: isPlaying ? FontWeight.w600 : FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text('VOLUME', style: AppTextStyles.label),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.65, // Static for UI mock
                      backgroundColor: AppColors.surfaceBorder,
                      color: AppColors.primary,
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('65%', style: GoogleFonts.inter(fontSize: 12, color: AppColors.primaryLight, fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildStopButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () => context.read<AudioCubit>().stop(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.scoreRed.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.stop_rounded, size: 16, color: AppColors.scoreRed),
              const SizedBox(width: 4),
              Text('Stop',
                  style: TextStyle(color: AppColors.scoreRed, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
