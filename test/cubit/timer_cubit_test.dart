import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/bloc/timer/timer_cubit.dart';
import 'package:good_dream/bloc/timer/timer_state.dart';
import 'package:good_dream/services/timer_service.dart';
import 'package:mocktail/mocktail.dart';

class MockTimerService extends Mock implements TimerService {}

void main() {
  group('TimerCubit Tests', () {
    late MockTimerService mockTimerService;
    late TimerCubit timerCubit;

    setUp(() {
      mockTimerService = MockTimerService();
      when(() => mockTimerService.secondsRemaining).thenReturn(3600);
      timerCubit = TimerCubit(mockTimerService);
    });

    tearDown(() {
      timerCubit.close();
    });

    test('initial state should have remainingTime from timerService', () {
      expect(timerCubit.state, const TimerState(remainingTime: 3600));
    });

    blocTest<TimerCubit, TimerState>(
      'cancelTimer should invoke cancelTimer on TimerService and emit non-running state',
      build: () {
        when(() => mockTimerService.cancelTimer()).thenAnswer((_) {});
        return timerCubit;
      },
      act: (cubit) => cubit.cancelTimer(),
      expect: () => [
        const TimerState(remainingTime: 3600, isTimerRunning: false),
      ],
      verify: (_) {
        verify(() => mockTimerService.cancelTimer()).called(2);
      },
    );

    blocTest<TimerCubit, TimerState>(
      'startTimer should start timer on TimerService and emit updates on tick and finish',
      build: () {
        when(() => mockTimerService.setAndStartTimer(
              any(),
              onTick: any(named: 'onTick'),
              onFinished: any(named: 'onFinished'),
            )).thenAnswer((invocation) {
          final onTick = invocation.namedArguments[Symbol('onTick')] as TimerTick;
          final onFinished = invocation.namedArguments[Symbol('onFinished')] as TimerFinished?;
          
          // Simulate a tick to 10 seconds
          onTick(10);
          // Simulate finish
          onFinished?.call();
        });
        return timerCubit;
      },
      act: (cubit) => cubit.startTimer(10),
      expect: () => [
        const TimerState(remainingTime: 10, isTimerRunning: true),
        const TimerState(remainingTime: 0, isTimerRunning: false),
      ],
    );
  });
}
