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
    this.themeMode,
    this.onThemeModeChanged,
  }) : super(key: key);

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

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
  ThemeMode themeMode = ThemeMode.light;
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
    /// This is for verification
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
               onSecondary: Colors.white,
            scaffoldBackground: Color(0xFF20124d)
        )
            .toTheme,
        darkTheme: FlexColorScheme
            .dark(scheme: FlexScheme.red,
            onPrimary: Colors.white,
        )
            .toTheme,
        themeMode: cart.basketItems3.isEmpty  ? ThemeMode.system : cart.basketItems3[0].themeMode,
        home: DefaultTabController(
          length: 3,
          child: WillPopScope(
            onWillPop: () => onBackPressed(),
            child: Scaffold(
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
                ),
              ),
              body: Container(
            decoration: BoxDecoration(
            ),
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          ListView(
                            children: <Widget>[
                              Container(
                                height: screenSize.height / 1.6,
                                child: TabViewOne(
                                ),
                              ),

                            ],
                          ),
                          ListView(
                            children: <Widget>[
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
                              Container(
                                height: screenSize.height / 1.6,
                                child: TabViewThree(),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    ClockTimer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    ) ?? false;
  }
}
