import 'dart:developer';
import 'package:good_dream/fun/arrays_3-4.dart';
import 'package:good_dream/fun/toast.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:good_dream/fun/foregroundService.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class TabViewFour extends StatefulWidget {
  TabViewFour({
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

class _State extends State<TabViewFour> with AutomaticKeepAliveClientMixin {
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
        itemCount: arrays4.length,
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
                    arrays4[index].isFav = !arrays4[index].isFav!;
                    // Click_events - if isFav is true
                    if (arrays4[index].isFav!) {
                      await _analytics.logEvent(
                        name: arrays4[index].events!,
                      );
                    }
                    // Play or Stop sounds
                    arrays4[index].isFav!
                        ? arrays4[index].player.open(
                        Audio(
                          arrays4[index].sounds!,
                        ),
                        volume: 0.5,
                        //  showNotification: true,
                        loopMode: LoopMode.single)
                        : arrays4[index].player.pause();
                    arrays4[index].isFav!
                        ? cart.add(arrays4[index])
                        : cart.remove(arrays4[index]);
                    //Add image to page two. If is isFav = true, add entire arrays.
                    // Table number is depends on from the selected item
                    // for example:  arrays[0].isFav = true.
                    // If is true add to cart provider entire items  "picOff, isFav, sounds, vol, player"
                    // basketItems is the receiver i find screenTwo.dart
                  } else if (cart.count == 6) {
                    cart.remove(arrays4[index]);
                    arrays4[index].isFav = false;
                    arrays4[index].player.pause();
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
                      image: AssetImage(arrays4[index].isFav!
                          ? arrays4[index].picOn!
                          : arrays4[index].picOff!),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    arrays4[index].isFav!
                        ? AnimatedOpacity(
                      opacity: arrays4[index].isFav!
                          ? arrays4[index].opacityOn
                          : arrays4[index].opacityOff,
                      duration: Duration(milliseconds: 800),
                      child: PlayerBuilder.volume(
                          player: arrays4[index].player,
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
                                      arrays4[index].player.setVolume(v);
                                    });
                                  }),
                            );
                          }),
                    )
                        : Text(
                      arrays4[index].title!,
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
