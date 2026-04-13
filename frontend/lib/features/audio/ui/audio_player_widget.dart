import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/audio_cubit.dart';
import '../cubit/audio_state.dart';
import '../data/audio_tracks.dart';
import '../../../core/constants/app_colors.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🎧',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text('Focus Sounds',
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                  const Spacer(),
                  state.maybeWhen(
                    playing: (name, _) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.scoreGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Playing: $name',
                          style: TextStyle(
                              color: AppColors.scoreGreen, fontSize: 11)),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isPlaying
                            ? AppColors.primary.withOpacity(0.2)
                            : isPaused
                                ? AppColors.scoreAmber.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: isPlaying
                            ? Border.all(
                                color: AppColors.primary.withOpacity(0.5))
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(track.icon, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(track.name,
                              style: TextStyle(
                                color: isPlaying
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: isPlaying
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                          if (isPlaying) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.pause_rounded,
                                size: 14, color: AppColors.primary),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Stop button
              state.maybeWhen(
                playing: (_, __) => _buildStopButton(context),
                paused: (_, __) => _buildStopButton(context),
                orElse: () => const SizedBox.shrink(),
              ),
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
