import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:numberpicker/numberpicker.dart';
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
  Key key,
  this.confirmWidget,
  this.cancelWidget,
  this.analytics,
 // this.observer,
}) : super(key: key);

final FirebaseAnalytics analytics;
// final FirebaseAnalyticsObserver observer;
final Widget confirmWidget;
final Widget cancelWidget;

  @override
  _State createState() => _State(analytics);
}

class _State extends State<ClockTimer> {
  FirebaseAnalytics _analytics;
  _State(FirebaseAnalytics analytics);

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
  Decoration _decoration = new BoxDecoration(
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
  );

 sendAnalyticsTrackSounds()  {
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

  Timer timer;
  int minuteDialog;
  int hoursDialog;
  bool counting = false;
  int _minutes = 0;
  int _seconds = 1800;
  int _hours = 0;

  _resetRemainingTime() {
    setState(() {
      _seconds = 0;
      _minutes = 15;
      _hours = 0;
    });
  }

  _startTimer() {
    _seconds = _hours * 3600 + _minutes * 60;
    if (counting) {
      _cancelTimer();
      _resetRemainingTime();
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        _tick();
      });
      setState(() {
        counting = true;
      });
    }
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
      timer.cancel();
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
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 15),
                child: ElevatedButton(
                  style: raiseButtonStyle,
             //     color: Colors.black26,
                  onPressed: () {
                //    sendAnalyticsSetTime();
                    _showDialog();
                    _cancelTimer();
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
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 NumberPicker(
               //   listViewWidth: 65,
                  value: _hours,
                  decoration: _decoration,
                  minValue: 0,
                  maxValue: 12,
                  zeroPad: true,
                  onChanged: (value) {
                    setState(() {
                      _hours = value;
                    });
                  },
                ),
                Text(
                  ':',
                  style: TextStyle(fontSize: 30),
                ),
                 NumberPicker(
              //    listViewWidth: 65,
                  value: _minutes,
                  decoration: _decoration,
                  minValue: 1,
                  maxValue: 59,
                  zeroPad: true,
                  onChanged: (value) => setState(() => _minutes = value),
                )
              ],
            ),
            actions: [
              new TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(new Duration(hours: _hours, minutes: _minutes));
                  _startTimer();
                  toast3();
                },
                child: widget.confirmWidget ?? Text('START TIME'),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: widget.cancelWidget ?? Text('CANCEL'),
              ),
            ],
          );
        });
  }


}
