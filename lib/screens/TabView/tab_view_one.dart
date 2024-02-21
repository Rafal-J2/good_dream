import 'package:good_dream/models/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../fun/arrays_1_2.dart';
import '../../fun/foreground_service.dart';
import '../../fun/toast.dart';
import '../../main.dart';

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
    return Consumer<DataProvider>(
      builder: (
        context,
        cart,
        child,
      ) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: GridView.builder(
              itemCount: arrays.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                      MediaQuery.of(context).size.width > 450 ? 1.3 : 1.0,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (cart.count <= 5) {
                      arrays[index].isFav = !arrays[index].isFav!;
                      arrays[index].isFav!
                          ? arrays[index].player!.open(
                              Audio(arrays[index].audioFile!),
                              volume: 0.5,
                              loopMode: LoopMode.single)
                          : arrays[index].player!.pause();

                      /// Add image to page two
                      arrays[index].isFav!
                          ? cart.add(arrays[index])
                          : cart.remove(arrays[index]);
                    } else if (cart.count == 6) {
                      cart.remove(arrays[index]);
                      arrays[index].isFav = false;
                      arrays[index].player!.pause();
                      //Toast Text
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
                        image: AssetImage(arrays[index].isFav!
                            ? arrays[index].enableIcon!
                            : arrays[index].disableIcon!),
                      ),
                      arrays[index].isFav!
                          ? PlayerBuilder.volume(
                              player: arrays[index].player!,
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
                                          arrays[index]
                                              .player!
                                              .setVolume(v);
                                        });
                                      }),
                                );
                              })
                          : Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                arrays[index].iconTitleText!,
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
