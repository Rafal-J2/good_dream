import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';


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

  int get secondsRemaining => _secondsRemaining;
}
