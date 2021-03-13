import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:good_dream/screens/mainScreen.dart';
import 'package:provider/provider.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/services.dart';


void main() {
// FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// Firebase

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
  //    navigatorObservers: <NavigatorObserver>[observer],
      home: SplashScreen(
        'assets/intro2.flr',
        GoodDream(          
       analytics: analytics,
        observer: observer,
        ),
        startAnimation: 'intro',
        backgroundColor: Color(0xff000000),
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: materialApp,
    );
  }
}
