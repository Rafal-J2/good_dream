import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:good_dream/screens/navigatrors.dart';
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
      home: SplashScreen.navigate(
        name:'assets/intro2.flr',
       next: (context) => Navigators(
        ),
        until: () => Future.delayed(Duration(seconds: 3)),
        startAnimation: 'intro',
      //  backgroundColor: Color(0xff000000),
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: materialApp,
    );
  }
}
