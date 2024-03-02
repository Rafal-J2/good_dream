import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/mediaControlCubit/media_control_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import 'package:shimmer/shimmer.dart';
import '../sounds/nature_sounds.dart';

class TabViewOne extends StatefulWidget {
  const TabViewOne({super.key});
  @override
  State createState() => _State();
}

class _State extends State<TabViewOne> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        return Padding(
          padding: AppPaddings.paddingTopForGridView,
          child: GridView.builder(
              itemCount: natureSounds.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                      MediaQuery.of(context).size.width > 450 ? 1.3 : 1.0,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    AudioClip sound = natureSounds[index];
                    context.read<MediaControlCubit>().toggleSound(sound);
                  },
                  child: Column(
                    children: [
                      Image(
                        height: imageSize['height'],
                        image: AssetImage(natureSounds[index].isControlActive
                            ? natureSounds[index].enableIcon ??
                                'assets/images/default_enabled_icon_on.png'
                            : natureSounds[index].disableIcon ??
                                'assets/images/default_enabled_icon_w.png'),
                      ),
                      natureSounds[index].isControlActive
                          ? PlayerBuilder.volume(
                              player: natureSounds[index].player,
                              builder: (context, volume) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey,
                                  child: Slider(
                                      value: volume,
                                      min: 0,
                                      max: 1,
                                      divisions: 50,
                                      onChanged: (v) {
                                        setState(
                                          () {
                                            natureSounds[index]
                                                .player
                                                .setVolume(v);
                                          },
                                        );
                                      },
                                      onChangeEnd: (v) {
                                        String soundId =
                                            natureSounds[index].audioFile!;
                                        context
                                            .read<MediaControlCubit>()
                                            .setVolume(soundId, v);
                                      }),
                                );
                              })
                          : Padding(
                              padding:
                                  AppPaddings.paddingTopBetweenTextAndImage,
                              child: Text(
                                natureSounds[index].iconTitleText!,
                                style: ThemeTextStyles.textStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
