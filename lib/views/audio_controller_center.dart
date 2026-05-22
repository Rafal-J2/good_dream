import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/media_control/media_control_cubit.dart';
import '../models/audio_clip.dart';
import '../style/theme_text_styles.dart';

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
    final Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
    final List<AudioClip> audioClips = soundsByCategory[category] ?? [];
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        final cubit = context.read<MediaControlCubit>();
        return Padding(
          padding: AppPaddings.paddingTopForGridView,
          child: GridView.builder(
            itemCount: audioClips.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio:
                  MediaQuery.sizeOf(context).width > 450 ? 1.3 : 1.0,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              final clip = audioClips[index];
              final isActive = cubit.isSoundActive(clip.id);
              // Find the ActiveSound for volume control if active
              final activeSound = isActive
                  ? state.activeSounds.firstWhere((s) => s.clip.id == clip.id)
                  : null;

              return InkWell(
                onTap: () {
                  cubit.toggleSound(category, clip);
                },
                child: Column(
                  children: [
                    Image(
                      height: imageSize['height'],
                      fit: BoxFit.contain,
                      image: AssetImage(isActive ? clip.enableIcon : clip.disableIcon),
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: imageSize['height'] ?? 40,
                        );
                      },
                    ),
                    isActive && activeSound != null
                        ? Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Slider(
                              value: activeSound.volume,
                              min: 0,
                              max: 1,
                              divisions: 50,
                              onChanged: (v) {
                                cubit.setVolume(clip.id, v);
                              },
                            ),
                          )
                        : Padding(
                            padding: AppPaddings.paddingTopBetweenTextAndImage,
                            child: Text(
                              clip.iconTitleText,
                              style: ThemeTextStyles.textStyleTabBar,
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
