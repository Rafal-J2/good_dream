import 'dart:async';

class TimerService {
  Timer? _timer;
  int _secondsRemaining;

  TimerService(this._secondsRemaining);

  void setAndStartTimer(int newSeconds, Function(int) onTick) {
    _secondsRemaining = newSeconds;
    startTimer(onTick);
  }

  void startTimer(Function onTick) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        onTick(_secondsRemaining);
      } else {
        cancelTimer();
      }
    });
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
