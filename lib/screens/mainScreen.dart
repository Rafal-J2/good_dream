import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:good_dream/fun/clockTimer.dart';

import 'package:good_dream/services/admob_service.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'TabView/tabViewOne.dart';
import 'TabView/tabViewTwo.dart';
import 'TabView/tabViewThree.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

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
    this.observer,
  }) : super(key: key);

// Firebase Analytics
  //final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  // Dialogs global
  final Widget confirmWidget;
  final Widget cancelWidget;
  final String title;

  @override
  _State createState() => _State(observer);
}

class _State extends State<GoodDream>   {
  _State(
   // this.analytics,
    this.observer,
  );
  //final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

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
    /// This is Verications
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
        theme: FlexColorScheme
            .light(scheme: FlexScheme.red,
        //  onPrimary: Colors.white,
               onSecondary: Colors.white,
        //    surface: Colors.black,

         //   onSeconday: Colors.green,
            scaffoldBackground: Color(0xFF20124d),
           // surface: Colors.yellow
        )
            .toTheme,
        // The Mandy red, dark theme.
        darkTheme: FlexColorScheme
            .dark(scheme: FlexScheme.red,
            scaffoldBackground: Colors.black45,

         // surface: Colors.yellow
        )
            .toTheme,
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.system,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            //  backgroundColor: Colors.grey,
         /*   drawer: Drawer(
              child: Menu(),
            ),*/
            appBar: PreferredSize(
             preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
                flexibleSpace: SizedBox(
                  child: TabBar(
                    labelPadding: EdgeInsets.only(top: 28),
                    tabs: [
                      Tab(
                        child: Text("Nature"),
                      ),
                      Center(
                          child: Tab(
                        child: Text("Mechanical"),
                      )),
                      Tab(
                        child: Text("Music"),
                      ),
                    ],
                  ),
                ),
                // title: Text('Tabs Demo'),

           //   title: Center(child: Text('Good Dream')),
              ),
            ),
            body: Container(
          decoration: BoxDecoration(
         //     color: Color(0xFF20124d),
          ),
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
                              height: screenSize.height / 1.6,
                              child: TabViewOne(
                              ),
                            ),
                          ],
                        ),
                        // TODO  ListView2
                        ListView(
                          children: <Widget>[
                            // TODO  Tab2
                            Container(
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
                              height: screenSize.height / 1.6,
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
              /*     child: AdmobBanner(
                      adUnitId: ams.getBannerAdId(),
                      adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                          width: MediaQuery.of(context).size.width.toInt()),
                    ),*/
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
