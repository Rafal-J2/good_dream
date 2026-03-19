import 'dart:async';

typedef TimerTick = void Function(int secondsRemaining);
typedef TimerFinished = void Function();

class TimerService {
  TimerService(this._secondsRemaining);
  int _secondsRemaining;
  Timer? _timer;

  void startTimer({
    required TimerTick onTick,
    TimerFinished? onFinished,
  }) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsRemaining <= 0) {
        cancelTimer();
        onFinished?.call();
        return;
      }

      _secondsRemaining--;
      onTick(_secondsRemaining);

      if (_secondsRemaining == 0) {
        cancelTimer();
        onFinished?.call();
      }
    });
  }

  void setAndStartTimer(
    int newSeconds, {
    required TimerTick onTick,
    TimerFinished? onFinished,
  }) {
    _secondsRemaining = newSeconds;
    onTick(_secondsRemaining);

    if (_secondsRemaining <= 0) {
      cancelTimer();
      onFinished?.call();
      return;
    }

    startTimer(onTick: onTick, onFinished: onFinished);
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  int get secondsRemaining => _secondsRemaining;
}
