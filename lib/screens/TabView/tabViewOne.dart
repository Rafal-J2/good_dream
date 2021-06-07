import 'package:good_dream/fun/arrays_1-2.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:good_dream/fun/functions.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class TabViewOne extends StatefulWidget {
  TabViewOne({
    Key? key,
    this.analytics,
    //   this.observer,
  }) : super(key: key);

  // Firebase Analytics
  final FirebaseAnalytics? analytics;
//  final FirebaseAnalyticsObserver observer;

  @override
  _State createState() => _State(analytics);
}

class _State extends State<TabViewOne> with AutomaticKeepAliveClientMixin {
  final PageStorageBucket bucket = PageStorageBucket();
  // Firebase Analytics
  late FirebaseAnalytics _analytics;

  _State(FirebaseAnalytics? analytics);

  @override
  void initState() {
    _analytics = FirebaseAnalytics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<DataProvider>(builder: (
        context,
        cart,
        child,
        ) {
      return GridView.builder(
        itemCount: arrays.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0, crossAxisCount: 3),
        itemBuilder: (context, index) {
          //   final shopList = snapshot.data["shop items"];
          return Column(
            children: [
              TextButton(
                ///  padding: EdgeInsets.only(top: 10),
                onPressed: () async {
                  if (cart.count <= 5) {
                    //Bool checking
                    arrays[index].isFav = !arrays[index].isFav!;
                    // Click_events - if isFav is true
                    if (arrays[index].isFav!) {
                    /*  await _analytics.logEvent(
                        name: arrays[index].events!,
                      );*/
                    }
                    // Play or Stop sounds
                    arrays[index].isFav!
                        ? arrays[index].player.open(
                        Audio(
                          arrays[index].sounds!,
                        ),
                        volume: 0.5,
                        //  showNotification: true,
                        loopMode: LoopMode.single)
                        : arrays[index].player.pause();
                    arrays[index].isFav!
                        ? cart.add(arrays[index])
                        : cart.remove(arrays[index]);
                    //Add image to page two. If is isFav = true, add entire arrays.
                    // Table number is depends on from the selected item
                    // for example:  arrays[0].isFav = true.
                    // If is true add to cart provider entire items  "picOff, isFav, sounds, vol, player"
                    // basketItems is the receiver i find screenTwo.dart
                  } else if (cart.count == 6) {
                    cart.remove(arrays[index]);
                    arrays[index].isFav = false;
                    arrays[index].player.pause();
                    //Toast Text
                    if (cart.count == 6) {
                      toast();
                    }
                  }
                  // foregroundService START or STOP
                  if (cart.count == 1) {
                    foregroundService();
                  } else if (cart.count == 0 && cart.count2 == 0) {
                    foregroundServiceStop();
                  }
                },
                child: Column(
                  children: [
                    Image(
                      fit: BoxFit.contain,
                      height: 50,
                      width: 120,
                      image: AssetImage(arrays[index].isFav!
                          ? arrays[index].picOn!
                          : arrays[index].picOff!),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    arrays[index].isFav!
                        ? AnimatedOpacity(
                      opacity: arrays[index].isFav!
                          ? arrays[index].opacityOn
                          : arrays[index].opacityOff,
                      duration: Duration(milliseconds: 800),
                      child: PlayerBuilder.volume(
                          player: arrays[index].player,
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
                                      arrays[index].player.setVolume(v);
                                    });
                                  }),
                            );
                          }),
                    )
                        : Text(
                      arrays[index].title!,
                      style: TextStyle(
                          fontSize: 12.0,
                          //    height: 2.5,
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

  @override
  bool get wantKeepAlive => true;
}
