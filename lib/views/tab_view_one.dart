import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/mediaControlCubit/media_control_cubit_cubit.dart';
import 'package:good_dream/bloc/nature_sounds/nature_sounds_cubit.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../fun/foreground_service.dart';
import '../fun/toast.dart';
import '../main.dart';
import '../sounds/nature_sounds.dart';

class TabViewOne extends StatefulWidget {
  const TabViewOne({super.key});
  @override
  State createState() => _State();
}

class _State extends State<TabViewOne> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> imageSize = ThemeTextStyles.getImageSize(context);
    double screenWidth = MediaQuery.of(context).size.width;
    logger.i("Width screen $screenWidth");
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: GridView.builder(
              itemCount: natureSounds.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                      MediaQuery.of(context).size.width > 450 ? 1.3 : 1.0,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (context.read<MediaControlCubit>().selectedCount <= 5) {
                      context
                          .read<NatureSoundsCubit>()
                          .toggleSound(natureSounds[index]);

                      /// Add image to page two
                      natureSounds[index].isControlActive
                          ? context
                              .read<MediaControlCubit>()
                              .addSound(natureSounds[index])
                          : context
                              .read<MediaControlCubit>()
                              .removeSound(natureSounds[index]);
                    } else if (context
                            .read<MediaControlCubit>()
                            .selectedCount == 6) {
                      context
                          .read<MediaControlCubit>()
                          .removeSound(natureSounds[index]);
                      natureSounds[index].isControlActive = false;
                      natureSounds[index].player.pause();
                      //Toast Text
                      if (context.read<MediaControlCubit>().selectedCount ==
                          6) {
                        toast();
                      }
                    }

                    /// foregroundService START or STOP
                    if (context.read<MediaControlCubit>().selectedCount == 1) {
                      foregroundService();
                    } else if (context
                            .read<MediaControlCubit>()
                            .selectedCount ==
                        0) {
                      foregroundServiceStop();
                    }
                  },
                  child: Column(
                    children: [
                      Image(
                        height: imageSize['height'],
                        //  width: imageSize['width'],
                        image: AssetImage(natureSounds[index].isControlActive
                            ? natureSounds[index].enableIcon!
                            : natureSounds[index].disableIcon!),
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
                                        setState(() {
                                          natureSounds[index]
                                              .player
                                              .setVolume(v);
                                        });
                                      }),
                                );
                              })
                          : Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                natureSounds[index].iconTitleText!,
                                style: ThemeTextStyles.texStyle,
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
