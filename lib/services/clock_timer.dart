import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:good_dream/services/timer_service.dart';
import 'package:good_dream/utils/toast_notifications.dart';
import 'package:numberpicker/numberpicker.dart';
import '../bloc/timer/timer_cubit.dart';
import '../bloc/timer/timer_state.dart';
import '../main.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({super.key});

  @override
  State createState() => _State();
}

class _State extends State<ClockTimer> {
  final TimerService _timerService = GetIt.I<TimerService>();
  bool _isTimerRunning = true;
  int _selectedHour = 1;
  int _selectedMinute = 0;


  final ButtonStyle raiseButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ElevatedButton(
                        style: raiseButtonStyle,
                        onPressed: () {
                          int newDurationInSeconds =
                              _selectedHour * 3600 + _selectedMinute * 60;
                          if (_isTimerRunning) {
                            logger.i("timer start");
                            context
                                .read<TimerCubit>()
                                .startTimer(newDurationInSeconds);
                          _isTimerRunning = false;
                          } else {
                            logger.i("timer reset");
                            context.read<TimerCubit>().cancelTimer();
                          _isTimerRunning = true;
                          }
                        },
                        child: Text(
                            _isTimerRunning ? "Start Timer" : "Reset Time")),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ElevatedButton(
                      style: raiseButtonStyle,
                      onPressed: () {
                        _showModalBottomSheet();
                      },
                      child: const Text("Set Time"),
                    ),
                  ),
                ),
              ],
            ),
            _timerService.renderClock(state),
          ],
        );
      },
    );
  }

  Future<void> _showModalBottomSheet() async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Custom Duration',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        value: _selectedHour,
                        minValue: 0,
                        maxValue: 8,
                        onChanged: (value) =>
                            setState(() => _selectedHour = value),
                      ),
                      const Text(':',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      NumberPicker(
                        value: _selectedMinute,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (value) =>
                            setState(() => _selectedMinute = value),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          int newDurationInSeconds =
                              _selectedHour * 3600 + _selectedMinute * 60;
                          context
                              .read<TimerCubit>()
                              .startTimer(newDurationInSeconds);
                          _isTimerRunning = false;
                          notificationStartCountdown();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}


