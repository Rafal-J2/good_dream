import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:good_dream/fun/arrays.dart';
import 'package:good_dream/fun/clockTimer.dart';
import 'package:good_dream/services/admob_service.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:good_dream/fun/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => DataProvider(),
    child: MainSounds(),
  ));

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await Firebase.initializeApp();
}

class MainSounds extends StatefulWidget {
  //Functions to Show Dialog
  MainSounds({
    Key key,
    this.confirmWidget,
    this.cancelWidget,
    this.title,
    this.analytics,
    this.observer,
  }) : super(key: key);



// Firebase Analytics
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  // Dialogs global
  final Widget confirmWidget;
  final Widget cancelWidget;
  final String title;

  @override
  _State createState() => _State(analytics, observer);
}

class _State extends State<MainSounds> {
  _State(
      this.analytics,
      this.observer,
      );







  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String _message = '';

  final ams = AdMobService();


  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel("com.retroportalstudio.messages");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Consumer<DataProvider>(builder: (
        context,
        cart,
        child,
        ) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            //  backgroundColor: Colors.grey,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Color(0xFF16222A),
                          Color(0xFF3A6073)],
                        stops: [
                          0.5,
                          0.9
                        ])),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text("Nature"),
                  ),
                  Center(
                      child: Tab(
                        child: Text("Mechanical"),
                      )),
                  Tab(
                    child: Text("Piano"),
                  ),
                ],
              ),
              // title: Text('Tabs Demo'),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF16222A), Color(0xFF3A6073)],
                      stops: [1.0, 0.7])),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        ListView(
                          children: <Widget>[
                            // TODO  Tab1
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF16222A),
                                        Color(0xFF3A6073)
                                      ],
                                      stops: [
                                        0.4,
                                        0.7
                                      ])),
                              //    width: 50.0,
                              height: screenSize.height / 1.6,
                              //   color: Color.fromRGBO(0, 0, 20, 1),
                              child: GridView.builder(
                                itemCount: arrays.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      FlatButton(
                                        padding: EdgeInsets.all(20),
                                        onPressed: () async {
                                          if (cart.count <= 5) {
                                            //Bool checking
                                            arrays[index].isFav =
                                            !arrays[index].isFav;
                                            // Click_events - if isFav is true
                                            if (arrays[index].isFav) {
                                              await analytics.logEvent(
                                                name: arrays[index].events,
                                              );
                                            }
                                            // Play or Stop sounds
                                            arrays[index].isFav
                                                ? arrays[index].player.open(
                                                Audio(
                                                  arrays[index].sounds,
                                                ),
                                                //  showNotification: true,
                                                loopMode: LoopMode.single)
                                                : arrays[index].player.pause();
                                            //Add image to page two
                                            arrays[index].isFav
                                                ? cart.add(arrays[index])
                                                : cart.remove(arrays[index]);
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
                                          } else if (cart.count == 0 &&
                                              cart.count2 == 0) {
                                            foregroundServiceStop();
                                          }
                                        },
                                        child: Image(
                                          height: screenSize.height / 16,
                                          //  height: 50.0,
                                          image: AssetImage(arrays[index].isFav
                                              ? arrays[index].picOn
                                              : arrays[index].picOff),
                                        ),
                                      ),
                                      Text(
                                        arrays[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      AnimatedOpacity(
                                        opacity: arrays[index].isFav
                                            ? arrays[index].opacityOn
                                            : arrays[index].opacityOff,
                                        duration: Duration(milliseconds: 800),
                                        child: PlayerBuilder.volume(
                                            player: arrays[index].player,
                                            builder: (context, _volume) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.white,
                                                highlightColor: Colors.grey,
                                                child: Slider(
                                                    value: _volume,
                                                    min: 0,
                                                    max: 1,
                                                    divisions: 50,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        arrays[index]
                                                            .player
                                                            .setVolume(_volume = value);
                                                      });
                                                    }),
                                              );
                                            }),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        // TODO  ListView2
                        ListView(
                          children: <Widget>[
                            // TODO  Tab2
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color(0xFF16222A),
                                        Color(0xFF3A6073)],
                                      stops: [0.5, 0.7])),
                              // width: 50.0,
                              height: screenSize.height / 1.6,
                              //  color: Colors.black12,
                              child: GridView.builder(
                                itemCount: arrays2.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      FlatButton(
                                        padding: EdgeInsets.all(20),
                                        onPressed: () async {
                                          if (cart.count <= 5) {
                                            //Bool checking
                                            arrays2[index].isFav =
                                            !arrays2[index].isFav;
                                            // Click_events
                                            if (arrays2[index].isFav) {
                                              await analytics.logEvent(
                                                name: arrays2[index].events,
                                              );
                                            }
                                            // Play or Stop sounds
                                            arrays2[index].isFav
                                                ? arrays2[index].player.open(
                                                Audio(
                                                    arrays2[index].sounds),
                                                loopMode: LoopMode.single)
                                                : arrays2[index].player.pause();
                                            //Add image to page two
                                            arrays2[index].isFav
                                                ? cart.add(arrays2[index])
                                                : cart.remove(arrays2[index]);
                                          } else if (cart.count == 6) {
                                            cart.remove(arrays2[index]);
                                            arrays2[index].isFav = false;
                                            arrays2[index].player.pause();
                                            //Toast Text
                                            if (cart.count == 6) {
                                              toast();
                                            }
                                          }
                                          // foregroundService START or STOP
                                          if (cart.count == 1) {
                                            foregroundService();
                                          } else if (cart.count == 0 &&
                                              cart.count2 == 0) {
                                            foregroundServiceStop();
                                          }
                                        },
                                        child: Image(
                                          height: screenSize.height / 16,
                                          //   height: screenSize.width / 8,
                                          // data.height == 200 ? height: 50 :
                                          //  height: 50,
                                          image: AssetImage(arrays2[index].isFav
                                              ? arrays2[index].picOn
                                              : arrays2[index].picOff),
                                        ),
                                      ),
                                      Text(arrays2[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),

                                      ),
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 800),
                                        opacity: arrays2[index].isFav
                                            ? arrays2[index].opacityOn
                                            : arrays2[index].opacityOff,
                                        child: PlayerBuilder.volume(
                                            player: arrays2[index].player,
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
                                                        arrays2[index]
                                                            .player
                                                            .setVolume(v);
                                                      });
                                                    }),
                                              );
                                            }),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        ListView(
                          children: <Widget>[
                            // TODO Tab3
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color(0xFF16222A),
                                        Color(0xFF3A6073)],
                                      stops: [0.6, 0.7])),
                              //  width: 50.0,
                              height: screenSize.height / 1.6,
                              // color: Colors.black12,
                              child: GridView.builder(
                                itemCount: arrays3.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      FlatButton(
                                        padding: EdgeInsets.all(20),
                                        onPressed: () async {
                                          if (cart.count2 <= 0) {
                                            //Bool checking
                                            arrays3[index].isFav =
                                            !arrays3[index].isFav;
                                            if (arrays3[index].isFav) {
                                              await analytics.logEvent(
                                                name: arrays3[index].events,
                                              );
                                              print(arrays3[index].log);
                                            }
                                            // Play or Stop sounds
                                            arrays3[index].isFav
                                                ? arrays3[index].player.open(
                                                Audio(
                                                    arrays3[index].sounds),
                                                loopMode: LoopMode.single)
                                                : arrays3[index].player.pause();
                                            //Add image to page two
                                            // Counter to piano
                                            arrays3[index].isFav
                                                ? cart.add2(arrays3[index])
                                                : cart.remove2(arrays3[index]);
                                          } else if (cart.count2 <= 1) {
                                            cart.remove(arrays3[index]);
                                            cart.remove2(arrays3[index]);
                                            arrays3[index].isFav = false;
                                            arrays3[index].player.pause();
                                            //Toast Text
                                            if (cart.count2 == 1) {
                                              toast2();
                                            }
                                          }
                                          // foregroundService START or STOP
                                          if (cart.count2 == 1) {
                                            foregroundService();
                                          } else if (cart.count2 == 0 &&
                                              cart.count == 0) {
                                            foregroundServiceStop();
                                          }
                                        },
                                        child: Shimmer.fromColors(
                                          highlightColor: Colors.white,
                                          baseColor: Colors.grey,
                                          child: Image(
                                            // height: 50.0,
                                            height: screenSize.height / 16,
                                            image: AssetImage(
                                                arrays3[index].isFav
                                                    ? arrays3[index].picOn
                                                    : arrays3[index].picOff),
                                          ),
                                        ),
                                      ),
                                      Text(arrays3[index].title,
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 700),
                                        opacity: arrays3[index].isFav
                                            ? arrays3[index].opacityOn
                                            : arrays3[index].opacityOff,
                                        child: PlayerBuilder.volume(
                                            player: arrays3[index].player,
                                            builder: (context, volume) {
                                              return Slider(
                                                  activeColor: Colors.grey,
                                                  value: volume,
                                                  min: 0,
                                                  max: 1,
                                                  divisions: 50,
                                                  onChanged: (v) {
                                                    setState(() {
                                                      arrays3[index]
                                                          .player
                                                          .setVolume(v);
                                                    });
                                                  });
                                            }),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // TODO bottom buttons
                  //  SlideCountdownClock(duration: _duration,),
                  ClockTimer(),
                  //   TODO Bannerflu
                  Container(
                    //     width: 400,
                    child: AdmobBanner(
                      adUnitId: ams.getBannerAdId(),
                      adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                          width: MediaQuery.of(context).size.width.toInt()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
