import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_control/media_control_cubit.dart';
import '../models/audio_clip.dart';

class AudioControlCenter extends StatelessWidget {
  final String category;
  final Map<String, List<AudioClip>> soundsByCategory;

  const AudioControlCenter({
    super.key,
    required this.category,
    required this.soundsByCategory,
  });

  @override
  Widget build(BuildContext context) {
    final List<AudioClip> audioClips = soundsByCategory[category] ?? [];
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        final cubit = context.read<MediaControlCubit>();
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
          child: GridView.builder(
            itemCount: audioClips.length,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.95,
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              final clip = audioClips[index];
              final isActive = cubit.isSoundActive(clip.id);
              final activeSound = isActive
                  ? state.activeSounds.firstWhere((s) => s.clip.id == clip.id)
                  : null;

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.amberAccent.withOpacity(0.08)
                            : Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: isActive
                              ? Colors.amberAccent.withOpacity(0.4)
                              : Colors.white.withOpacity(0.06),
                          width: 1.5,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          cubit.toggleSound(category, clip);
                        },
                        borderRadius: BorderRadius.circular(16.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isActive
                                      ? Colors.amberAccent.withOpacity(0.12)
                                      : Colors.white.withOpacity(0.02),
                                ),
                                child: Image(
                                  height: 38.0,
                                  width: 38.0,
                                  fit: BoxFit.contain,
                                  image: AssetImage(isActive ? clip.enableIcon : clip.disableIcon),
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.music_note,
                                      color: Colors.white70,
                                      size: 32,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Expanded(
                                child: isActive && activeSound != null
                                    ? Center(
                                        child: SliderTheme(
                                          data: SliderThemeData(
                                            trackHeight: 2.5,
                                            activeTrackColor: Colors.amberAccent,
                                            inactiveTrackColor: Colors.white.withOpacity(0.1),
                                            thumbColor: Colors.amberAccent,
                                            overlayColor: Colors.amberAccent.withOpacity(0.2),
                                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4.5),
                                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                                          ),
                                          child: Slider(
                                            value: activeSound.volume,
                                            min: 0,
                                            max: 1,
                                            divisions: 50,
                                            onChanged: (v) {
                                              cubit.setVolume(clip.id, v);
                                            },
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            clip.iconTitleText,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
