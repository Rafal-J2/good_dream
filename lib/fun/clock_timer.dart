
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/fun/toast.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => DataProvider(),
    child: const ClockTimer(),
  ));

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await Firebase.initializeApp();
}

class ClockTimer extends StatefulWidget {
  const ClockTimer({super.key});




  @override
  State createState() => _State();
}

class _State extends State<ClockTimer> {


  @override
  void initState() {
    super.initState();
    _loadSeconds();
  }


  setClock() {
    Navigator.of(context)
        .pop(Duration(hours: _hours, minutes: _minutes));
  }

  Timer? timer;
  int? minuteDialog;
  int? hoursDialog;
  bool counting = false;
  int _minutes = 0;
  int _seconds = 0;
  final int _hours = 0;
  bool  _isFav = false;
 // int _setTime = 0;


  resetRemainingTime5() {
    _isFav = true;
    setState(()  {
      _saveSeconds();
      _minutes = 5;
    });
  }

  _resetRemainingTime10() {
    _isFav = true;
    setState(() {
      _saveSeconds();
      _minutes = 10;

    });
  }

  _resetRemainingTime15() {
    _isFav = true;
    setState(() {
      _saveSeconds();
      _minutes = 15;
    });
  }

  _resetRemainingTime30() {
    _isFav = true;
    setState(() {
      _saveSeconds();
      _minutes = 30;
    });
  }

  _resetRemainingTime60() {
    _isFav = true;
    setState(() {
      _saveSeconds();
      _minutes = 60;
    });
  }

  _resetRemainingTime120() {
    _isFav = true;
    setState(() {
      _saveSeconds();
      _minutes = 120;
    });
  }

  _resetRemainingTime180() {
    _isFav = true;
    setState(() {
      _saveSeconds();
      _minutes = 180;
    });
  }

  _resetRemainingTime240() {
    _isFav = true;
    setState(() {
      _saveSeconds();
      _minutes = 240;
    });
  }

  _startTimer() {
    _seconds = _hours * 3600 + _minutes * 60;
    _cancelTimer();
    // _resetRemainingTime();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });
  }

  void _saveSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('counter', _seconds);
    });
  }

  //Incrementing counter after click
  void _loadSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _seconds = (prefs.getInt('counter') ?? 3600);
   //   prefs.setInt('counter', _counter);
    });
  }

  _renderClock()  {
    final duration = Duration(seconds: _seconds);
    final hours = _twoDigits(duration.inHours.remainder(60));
    final minutes = _twoDigits(duration.inMinutes.remainder(60));
    final seconds = _twoDigits(duration.inSeconds.remainder(60));

    return Text(
      "$hours:$minutes:$seconds",
      style: const TextStyle(fontSize: 40.0, color: Colors.white),
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

  _tick() {
    setState(() {
      _seconds -= 1;
    //  _saveSeconds();
      if (_seconds <= 0) {
        _cancelTimer();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }

  _twoDigits(int n) {
    return n.toString().padLeft(2, "0");
  }

  final ButtonStyle raiseButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
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
                  onPressed: () {
                    _isFav = !_isFav;
                    if(_isFav) {
                      _loadSeconds();
                      _startTimer();
                    } else {
                      _cancelTimer();
                      _loadSeconds();
                    }

                  },
                  child: _isFav ? const Text("Stop Time") : const Text('Start Timer'),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
                child: ElevatedButton(
                  style: raiseButtonStyle,
                  onPressed: () {
                  _showDialog();
                  },
                  child: const Text("Set Time"),
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
            title: const Center(child: Text('Set Time')),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    resetRemainingTime5();
                    _startTimer();
                    toast3();
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                  },
                  child: const Text('5 MINUTES'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _resetRemainingTime10();
                    _startTimer();
                    toast3();
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                  },
                  child: const Text('10 MINUTES'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime15();
                    _startTimer();
                    toast3();
                  },
                  child: const Text('15 MINUTES'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime30();
                    _startTimer();
                    toast3();
                  },
                  child: const Text('30 MINUTES'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime60();
                    _startTimer();
                    toast3();
                  },
                  child: const Text('1 HOURS'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime120();
                    _startTimer();
                    toast3();
                  },
                  child: const Text('2 HOURS'),
                ),
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime180();
                    _startTimer();
                    toast3();
                  },
                  child: const Text('3 HOURS'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(Duration(hours: _hours, minutes: _minutes));
                    _resetRemainingTime240();
                    _startTimer();
                    toast3();
                  },
                  child: const Text('4 HOURS'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 65, top: 25),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('CLOSE'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _cancelTimer();
                        _loadSeconds();
                        _isFav = false;
                        Navigator.of(context).pop();
                      },
                      child: const Text('STOP'),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}



