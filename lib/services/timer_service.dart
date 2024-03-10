import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/timer/timer_state.dart';

class TimerService {
  TimerService(this._secondsRemaining);
  int _secondsRemaining;
  Timer? _timer;

  void startTimer(Function onTick) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        onTick(_secondsRemaining);
      } else {
        cancelTimer();
        _exitApp();
      }
    });
  }

  void _exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  void setAndStartTimer(int newSeconds, Function(int) onTick) {
    _secondsRemaining = newSeconds;
    startTimer(onTick);
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resetTimer(int newSeconds, Function(int) onTick) {
    _secondsRemaining = newSeconds;
    startTimer(onTick);
  }

  void stopTimer() {
  _timer?.cancel();
}


  formatNumberWithLeadingZero(int n) {
    return n.toString().padLeft(2, "0");
  }


    Widget renderClock(TimerState state) {
    final duration = Duration(seconds: state.remainingTime);
    final hours = formatNumberWithLeadingZero(duration.inHours.remainder(24));
    final minutes =
        formatNumberWithLeadingZero(duration.inMinutes.remainder(60));
    final seconds =
        formatNumberWithLeadingZero(duration.inSeconds.remainder(60));
    return Text(
      "$hours:$minutes:$seconds",
      style: const TextStyle(fontSize: 40.0, color: Colors.white),
    );
  }


  int get secondsRemaining => _secondsRemaining;
}
