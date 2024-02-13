import 'package:good_dream/fun/toast.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/fun/foreground_service.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../fun/arrays_1_2.dart';


class TabViewTwo extends StatefulWidget {
  const TabViewTwo({super.key});


  @override
  State createState() => _State();
}

class _State extends State<TabViewTwo> {



  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (
        context,
        cart,
        child,
        ) {
      return GridView.builder(
        itemCount: arrays2.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0, crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Column(
            children: [
              TextButton(
                onPressed: () async {
                  if (cart.count <= 5) {
                    /// Bool checking
                    arrays2[index].isFav = !arrays2[index].isFav!;
                    // Click_events Analytics
               
                    /// Play or Stop sounds
                    arrays2[index].isFav!
                        ? arrays2[index].player!.open(
                        Audio(arrays2[index].sounds!),
                        volume: 0.5,
                        loopMode: LoopMode.single)
                        : arrays2[index].player!.pause();

                    /// Add image to page two
                    arrays2[index].isFav!
                        ? cart.add(arrays2[index])
                        : cart.remove(arrays2[index]);
                  } else if (cart.count == 6) {
                    cart.remove(arrays2[index]);
                    arrays2[index].isFav = false;
                    arrays2[index].player!.pause();
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
                      height: 50,
                      width: 120,
                      //  height: 50.0,
                      image: AssetImage(arrays2[index].isFav!
                          ? arrays2[index].picOn!
                          : arrays2[index].picOff!),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    arrays2[index].isFav!
                        ? AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: arrays2[index].isFav!
                          ? arrays2[index].opacityOn!
                          : arrays2[index].opacityOff!,
                      child: PlayerBuilder.volume(
                          player: arrays2[index].player!,
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
                                      arrays2[index].player!.setVolume(v);
                                    });
                                  }),
                            );
                          }),
                    )
                        : Text(
                      arrays2[index].title!,
                      style: const TextStyle(
                          fontSize: 13.0,
                          //   height: 2.5,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
