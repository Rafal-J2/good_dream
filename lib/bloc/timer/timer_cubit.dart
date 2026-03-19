import 'package:bloc/bloc.dart';
import 'package:good_dream/services/timer_service.dart';
import 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final TimerService _timerService;

  TimerCubit(this._timerService)
      : super(TimerState(remainingTime: _timerService.secondsRemaining));

  void startTimer(int seconds) {
    _timerService.setAndStartTimer(
      seconds,
      onTick: (secondsRemaining) {
        emit(state.copyWith(
          remainingTime: secondsRemaining,
          isTimerRunning: true,
        ));
      },
      onFinished: () {
        emit(state.copyWith(
          remainingTime: 0,
          isTimerRunning: false,
        ));
      },
    );
  }

  void cancelTimer() {
    _timerService.cancelTimer();
    emit(state.copyWith(isTimerRunning: false));
  }

  @override
  Future<void> close() {
    _timerService.cancelTimer();
    return super.close();
  }
}
