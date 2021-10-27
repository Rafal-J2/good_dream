import 'package:good_dream/fun/arrays_1-2.dart';
import 'package:good_dream/fun/toast.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:good_dream/fun/foregroundService.dart';
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
    var cart = Provider.of<DataProvider>(context);
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
                  cart.addAll(index);
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
