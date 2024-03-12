import 'package:good_dream/models/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/media_control/media_control_cubit.dart';
import '../bloc/media_control/sounds_cubit.dart';
import '../models/audio_clip.dart';
import '../sounds/water_sounds.dart';

class TabViewTwo extends StatefulWidget {
  final String selectedCategory;
  const TabViewTwo({super.key, required this.selectedCategory});
  @override
  State createState() => _State();
}

class _State extends State<TabViewTwo> {
  String selectedCategory = 'waterSounds';
  @override
  Widget build(BuildContext context) {
    Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: GridView.builder(
            itemCount: waterSounds.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:
                    MediaQuery.of(context).size.width > 450 ? 1.3 : 1.0,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    AudioClip sound = soundsByCategory[selectedCategory]![index];
                    context
                        .read<MediaControlCubit>()
                        .toggleSound(selectedCategory, sound);
                  },
                  child: Column(
                    children: [
                      Image(
                        height: imageSize['height'],
                        image: AssetImage(waterSounds[index].isControlActive
                            ? waterSounds[index].enableIcon ??
                                'assets/images/default_enabled_icon_on.png'
                            : waterSounds[index].disableIcon ??
                                'assets/images/default_enabled_icon_w.png'),
                      ),
                      waterSounds[index].isControlActive
                          ? PlayerBuilder.volume(
                              player: waterSounds[index].player,
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
                                            waterSounds[index]
                                                .player
                                                .setVolume(v);
                                          },
                                        );
                                      },
                                      onChangeEnd: (v) {
                                        String soundId =
                                            waterSounds[index].audioFile!;
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
                                waterSounds[index].iconTitleText!,
                                style: ThemeTextStyles.textStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ],
                  ),
                );
            }),
      );
    });
  }
}
