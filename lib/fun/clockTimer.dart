import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:provider/provider.dart';
import 'functions.dart';
import 'package:good_dream/fun/functions.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => DataProvider(),
    child: ClockTimer(),
  ));

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await Firebase.initializeApp();
}

class ClockTimer extends StatefulWidget {
  ClockTimer({
    Key? key,
    this.analytics,
    // this.observer,
  }) : super(key: key);

  final FirebaseAnalytics? analytics;
// final FirebaseAnalyticsObserver observer;

  @override
  _State createState() => _State(analytics);
}

class _State extends State<ClockTimer> {
  late FirebaseAnalytics _analytics;
  _State(FirebaseAnalytics? analytics);

  @override
  void initState() {
    _analytics = FirebaseAnalytics();
    super.initState();
    _resetRemainingTime();

/*   Test Crash
    FirebaseCrashlytics.instance.crash();
    _showDialogStat = GlobalKey();*/
  }

  // Number picker
/*  Decoration _decoration = new BoxDecoration(
    border: new Border(
      top: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
      bottom: new BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
    ),
  );*/

  sendAnalyticsTrackSounds() {
    _analytics.logEvent(
      name: 'click_trackSounds',
    );
  }

  sendAnalyticsTrackPiano() {
    _analytics.logEvent(
      name: 'click_trackPiano',
    );
  }

  sendAnalyticsSetTime() {
    _analytics.logEvent(
      name: 'set_times',
    );
  }

  Timer? timer;
  int? minuteDialog;
  int? hoursDialog;
  bool counting = false;
  int _minutes = 0;
  int _seconds = 3600;
  int _hours = 0;

  _resetRemainingTime() {
    setState(() {
      debugPrint('reset 1 ------');
      _seconds = 0;
      _minutes = 5;
      _hours = 0;
    });
  }

  _resetRemainingTime2() {
    setState(() {
      debugPrint('reset 2 -------');
      _seconds = 0;
      _minutes = 15;
      _hours = 0;
    });
  }

  _resetRemainingTime3() {
    setState(() {
      debugPrint('reset 2 -------');
      _seconds = 0;
      _minutes = 30;
      _hours = 0;
    });
  }

  _resetRemainingTime4() {
    setState(() {
      debugPrint('reset 2 -------');
      _seconds = 0;
      _minutes = 60;
      _hours = 0;
    });
  }

  _resetRemainingTime5() {
    setState(() {
      debugPrint('reset 2 -------');
      _seconds = 0;
      _minutes = 180;
      _hours = 0;
    });
  }

  _startTimer() {
    debugPrint('START TIME ----------');
    _seconds = _hours * 3600 + _minutes * 60;

    _cancelTimer();
    // _resetRemainingTime();

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      _tick();
    });
  }

  _renderClock() {
    final duration = Duration(seconds: _seconds);
    final hours = _twoDigits(duration.inHours.remainder(60));
    final minutes = _twoDigits(duration.inMinutes.remainder(60));
    final seconds = _twoDigits(duration.inSeconds.remainder(60));

    return Text(
      "$hours:$minutes:$seconds",
      style: TextStyle(fontSize: 40.0, color: Colors.white),
    );
  }

  _cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    setState(() {
      counting = false;
    });
  }

  // TODO _tick
  _tick() {
    setState(() {
      _seconds -= 1;
      if (_seconds <= 0) {
        _cancelTimer();
        _resetRemainingTime();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }

  _twoDigits(int n) {
    return n.toString().padLeft(2, "0");
  }

  final ButtonStyle raiseButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    //  final Size screenSize = MediaQuery.of(context).size;

    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
                child: ElevatedButton(
                  style: raiseButtonStyle,
                  //     color: Colors.black26,
                  onPressed: () {
                    //    sendAnalyticsSetTime();
                    _showDialog();
                    //  _cancelTimer();
                    // showBanner();
                  },
                  child: Text("Set Time"),
                ),
              ),
            ],
          ),
          _renderClock(),
        ],
      );
    });
  }

  Future<void> _showDialog() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            //  backgroundColor: Colors.grey,
            title: Center(child: Text('Set Time')),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(new Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime();
                    _startTimer();
                    toast3();
                  },
                  child: Text('5 MINUTES'),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(new Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime2();
                    _startTimer();
                    toast3();
                  },
                  child: Text('15 MINUTES'),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(new Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime3();
                    _startTimer();
                    toast3();
                  },
                  child: Text('30 MINUTES'),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(new Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime4();
                    _startTimer();
                    toast3();
                  },
                  child: Text('1 HOURS'),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(new Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime5();
                    _startTimer();
                    toast3();
                  },
                  child: Text('3 HOURS'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 65, top: 25),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('CLOSE'),
                    ),
                    TextButton(
                      onPressed: () {
                        _cancelTimer();
                        Navigator.of(context).pop();
                      },
                      child: Text('STOP TIMER'),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
