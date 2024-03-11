import 'package:bloc/bloc.dart';
import 'package:good_dream/services/timer_service.dart';
import 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final TimerService _timerService;

  TimerCubit(this._timerService)
      : super(TimerState(remainingTime: _timerService.secondsRemaining));

  void startTimer(int seconds) {
    _timerService.setAndStartTimer(seconds, (secondsRemaining) {
      emit(state.copyWith(
          remainingTime: secondsRemaining, isTimerRunning: false));
    });
  }

    void cancelTimer() {
    _timerService.cancelTimer();
    emit(state.copyWith(isTimerRunning: true));
  }

}
