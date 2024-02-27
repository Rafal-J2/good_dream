import 'package:good_dream/fun/toast.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/fun/foreground_service.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../sounds/mechanical_sounds.dart';
import '../../style/theme_text_styles.dart';

class TabViewFour extends StatefulWidget {
  const TabViewFour({super.key});

  @override
  State createState() => _State();
}

class _State extends State<TabViewFour> with AutomaticKeepAliveClientMixin {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    Map<String, double> imageSize = ThemeTextStyles.getImageSize(context);
    super.build(context);
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: GridView.builder(
            itemCount: mechanicalSounds.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:
                    MediaQuery.of(context).size.width > 450 ? 1.3 : 1.0,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (cart.count <= 5) {
                    mechanicalSounds[index].isControlActive =
                        !mechanicalSounds[index].isControlActive;
                    mechanicalSounds[index].isControlActive
                        ? mechanicalSounds[index].player.open(
                            Audio(mechanicalSounds[index].audioFile!),
                            volume: 0.5,
                            loopMode: LoopMode.single)
                        : mechanicalSounds[index].player.pause();

                    /// Add image to page two
                    mechanicalSounds[index].isControlActive
                        ? cart.add(mechanicalSounds[index])
                        : cart.remove(mechanicalSounds[index]);
                  } else if (cart.count == 6) {
                    cart.remove(mechanicalSounds[index]);
                    mechanicalSounds[index].isControlActive = false;
                    mechanicalSounds[index].player.pause();
                    if (cart.count == 6) {
                      toast();
                    }
                  }

                  /// foregroundService START or STOP
                  if (cart.count == 1) {
                    foregroundService();
                  } else if (cart.count == 0 && cart.count2 == 0) {
                    foregroundServiceStop();
                  }
                },
                child: Column(
                  children: [
                    Image(
                      height: imageSize['height'],
                      width: imageSize['width'],
                      image: AssetImage(mechanicalSounds[index].isControlActive
                          ? mechanicalSounds[index].enableIcon!
                          : mechanicalSounds[index].disableIcon!),
                    ),
                    mechanicalSounds[index].isControlActive
                        ? PlayerBuilder.volume(
                            player: mechanicalSounds[index].player,
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
                                        mechanicalSounds[index]
                                            .player
                                            .setVolume(v);
                                      });
                                    }),
                              );
                            })
                        : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              mechanicalSounds[index].iconTitleText!,
                              style: ThemeTextStyles.texStyle,
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

  @override
  bool get wantKeepAlive => true;
}
