import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:good_dream/fun/clockTimer.dart';
import 'package:good_dream/screens/menu.dart';
import 'package:good_dream/services/admob_service.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'TabView/tabViewOne.dart';
import 'TabView/tabViewTwo.dart';
import 'TabView/tabViewThree.dart';

void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => DataProvider(),
    child: GoodDream(),
  ));
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await Firebase.initializeApp();
}

class GoodDream extends StatefulWidget {
  //Functions to Show Dialog
  GoodDream({
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

class _State extends State<GoodDream> {
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
            drawer: Drawer(
              child: Menu(),
            ),
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Color(0xFF16222A), Color(0xFF3A6073)],
                        stops: [0.5, 0.9])),
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

           //   title: Center(child: Text('Good Dream')),
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
                        // TODO  ListView1
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
                              child: TabViewOne(),
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
                                      colors: [
                                    Color(0xFF16222A),
                                    Color(0xFF3A6073)
                                  ],
                                      stops: [
                                    0.5,
                                    0.7
                                  ])),
                              // width: 50.0,
                              height: screenSize.height / 1.6,
                              //  color: Colors.black12,
                              child: TabViewTwo(),
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
                                      colors: [
                                    Color(0xFF16222A),
                                    Color(0xFF3A6073)
                                  ],
                                      stops: [
                                    0.6,
                                    0.7
                                  ])),
                              //  width: 50.0,
                              height: screenSize.height / 1.6,
                              // color: Colors.black12,
                              child: TabViewThree(),
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
