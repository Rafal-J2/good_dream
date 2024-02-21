import 'package:good_dream/fun/arrays_3_4.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../fun/foreground_service.dart';
import '../../style/theme_text_styles.dart';

class TabViewThree extends StatefulWidget {
  const TabViewThree({super.key});
  @override
  State createState() => _State();
}

class _State extends State<TabViewThree> {
  ThemeMode themeMode = ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    Map<String, double> imageSize = ThemeTextStyles.getImageSize(context);
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: GridView.builder(
            itemCount: arrays3.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:
                    MediaQuery.of(context).size.width > 450 ? 1.3 : 1.0,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  if (cart.count2 == 1 && arrays3[index].isFav == false) {
                    for (int i = 0; i < arrays3.length; i++) {
                      arrays3[i].player?.pause();
                      cart.remove2(arrays3[i]);
                      cart.remove(arrays3[i]);
                      arrays3[i].isFav = false;
                    }
                  }
                  if (cart.count2 <= 1 && arrays3[index].isFav == false) {
                    arrays3[index].player!.open(
                        Audio(arrays3[index].audioFile!),
                        volume: 0.5,
                        loopMode: LoopMode.single);
                    cart.add2(arrays3[index]);
                    cart.add(arrays3[index]);
                    arrays3[index].isFav = true;
                  } else {
                    arrays3[index].player!.pause();
                    cart.remove2(arrays3[index]);
                    cart.remove(arrays3[index]);
                    arrays3[index].isFav = false;
                  }

                  /// foregroundService START or STOP
                  if (cart.count2 == 1) {
                    foregroundService();
                  } else if (cart.count2 == 0 && cart.count == 0) {
                    foregroundServiceStop();
                  }
                },
                child: Column(
                  children: [
                    Image(
                      height: imageSize['height'],
                      width: imageSize['width'],
                      image: AssetImage(arrays3[index].isFav!
                          ? arrays3[index].enableIcon!
                          : arrays3[index].disableIcon!),
                    ),
                    arrays3[index].isFav!
                        ? AnimatedOpacity(
                            duration: const Duration(milliseconds: 800),
                            opacity: arrays3[index].isFav!
                                ? arrays3[index].opacityOn!
                                : arrays3[index].opacityOff!,
                            child: PlayerBuilder.volume(
                                player: arrays3[index].player!,
                                builder: (context, volume) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.white,
                                      highlightColor: Colors.grey,
                                    child: Slider(
                                        activeColor: Colors.grey,
                                        value: volume,
                                        min: 0,
                                        max: 1,
                                        divisions: 50,
                                        onChanged: (v) {
                                          setState(() {
                                            arrays3[index].player!.setVolume(v);
                                          });
                                        }),
                                  );
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              arrays3[index].iconTitleText!,
                              style: ThemeTextStyles.texStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ],
                ),
              );
            },
          ));
    });
  }
}
