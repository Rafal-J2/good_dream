import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'arrays 3-4.dart';


class Analytics extends StatefulWidget {
  Analytics({
    Key? key,
    this.analytics,
    this.observer,
  }) : super(key: key);

  // Firebase Analytics
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  @override
  _AnalyticsState createState() => _AnalyticsState(analytics, observer);
}

class _AnalyticsState extends State<Analytics> {
  _AnalyticsState(
      this.analytics,
      this.observer
      );

  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  String _message = '';

  Future<void> logEvent() async {
    await analytics!.logEvent(
      name: arrays3[0].events!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

