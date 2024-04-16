import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_control/media_control_cubit.dart';
import '../models/audio_clip.dart';
import '../style/theme_text_styles.dart';
import 'widgets/volume_control.dart';

class AudioControlCenter extends StatefulWidget {
  final String category;
  final Map<String, List<AudioClip>> soundsByCategory;
  const AudioControlCenter({
    super.key,
    required this.category,
    required this.soundsByCategory,
  });

  @override
  State createState() => _AudioControlCenterState();
}

class _AudioControlCenterState extends State<AudioControlCenter> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
    List<AudioClip> audioClips = widget.soundsByCategory[widget.category] ?? [];
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
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
              AudioClip sound = audioClips[index];
              return InkWell(
                onTap: () {
                  context
                      .read<MediaControlCubit>()
                      .toggleSound(widget.category, sound);
                },
                child: Column(
                  children: [
                    Image(
                      height: imageSize['height'],
                      image: AssetImage(audioClips[index].isControlActive
                          ? audioClips[index].enableIcon ??
                              'assets/images/default_enabled_icon_on.png'
                          : audioClips[index].disableIcon ??
                              'assets/images/default_enabled_icon_w.png'),
                    ),
                    audioClips[index].isControlActive
                        ? VolumeControl(
                            player: audioClips[index].player,
                            audioFileId: audioClips[index].audioFile!,
                          )
                        : Padding(
                            padding: AppPaddings.paddingTopBetweenTextAndImage,
                            child: Text(
                              audioClips[index].iconTitleText!,
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
