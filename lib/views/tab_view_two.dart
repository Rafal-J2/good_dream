import 'package:good_dream/utils/toast_notifications.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/services/foreground_service.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../sounds/water_sounds.dart';

class TabViewTwo extends StatefulWidget {
  const TabViewTwo({super.key});
  @override
  State createState() => _State();
}

class _State extends State<TabViewTwo> {
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
                  if (cart.count <= 5) {
                    waterSounds[index].isControlActive =
                        !waterSounds[index].isControlActive;
                    waterSounds[index].isControlActive
                        ? waterSounds[index].player.open(
                            Audio(waterSounds[index].audioFile!),
                            volume: 0.5,
                            loopMode: LoopMode.single)
                        : waterSounds[index].player.pause();

                    /// Add image to page two
                    waterSounds[index].isControlActive
                        ? cart.add(waterSounds[index])
                        : cart.remove(waterSounds[index]);
                  } else if (cart.count == 6) {
                    cart.remove(waterSounds[index]);
                    waterSounds[index].isControlActive = false;
                    waterSounds[index].player.pause();
   
                    if (cart.count == 6) {
                      notifyMaxSoundsReached();
                    }
                  }

                  if (cart.count == 1) {
                    startForegroundService();
                  } else if (cart.count == 0 && cart.count2 == 0) {
                    stopForegroundService();
                  }
                },
                child: Column(
                  children: [
                    Image(
                      height: imageSize['height'],
                      width: imageSize['width'],
                      image: AssetImage(waterSounds[index].isControlActive
                          ? waterSounds[index].enableIcon!
                          : waterSounds[index].disableIcon!),
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
                                      setState(() {
                                        waterSounds[index].player.setVolume(v);
                                      });
                                    }),
                              );
                            })
                        : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
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
