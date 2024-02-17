
import 'package:good_dream/fun/toast.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/fun/foreground_service.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../fun/arrays_3_4.dart';
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
      return  Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: GridView.builder(
              itemCount: arrays4.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.0, crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (cart.count <= 5) {
                          arrays4[index].isFav = !arrays4[index].isFav!;
                          arrays4[index].isFav!
                              ? arrays4[index].player!.open(
                                  Audio(arrays4[index].sounds!),
                                  volume: 0.5,
                                  loopMode: LoopMode.single)
                              : arrays4[index].player!.pause();
          
                          /// Add image to page two
                          arrays4[index].isFav!
                              ? cart.add(arrays4[index])
                              : cart.remove(arrays4[index]);
                        } else if (cart.count == 6) {
                          cart.remove(arrays4[index]);
                          arrays4[index].isFav = false;
                          arrays4[index].player!.pause();
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
                      child: Image(
                        height: imageSize['height'],
                        width: imageSize['width'],
                        image: AssetImage(arrays4[index].isFav!
                            ? arrays4[index].picOn!
                            : arrays4[index].picOff!),
                      ),
                    ),

                    arrays4[index].isFav!
                        ? AnimatedOpacity(
                            duration: const Duration(milliseconds: 800),
                            opacity: arrays4[index].isFav!
                                ? arrays4[index].opacityOn!
                                : arrays4[index].opacityOff!,
                            child: PlayerBuilder.volume(
                                player: arrays4[index].player!,
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
                                            arrays4[index].player!.setVolume(v);
                                          });
                                        }),
                                  );
                                }),
                          )
                        : Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                              arrays4[index].title!,
                              style: ThemeTextStyles.texStyle,
                              textAlign: TextAlign.center,
                            ),
                        ),
                  ],
                );
              }),
        );
    });
  }
  @override
  bool get wantKeepAlive => true;
}
