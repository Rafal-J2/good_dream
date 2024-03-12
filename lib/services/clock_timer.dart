import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/utils/toast_notifications.dart';
import 'package:numberpicker/numberpicker.dart';
import '../bloc/timer/timer_cubit.dart';
import '../bloc/timer/timer_state.dart';
import '../main.dart';
import '../style/theme_text_styles.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({super.key});

  @override
  State createState() => _State();
}

class _State extends State<ClockTimer> {
 // final TimerService _timerService = GetIt.I<TimerService>();
  int _selectedHour = 1;
  int _selectedMinute = 0;

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
                        style:  Button.buttonForTimer,
                        onPressed: () {
                          int newDurationInSeconds =
                              _selectedHour * 3600 + _selectedMinute * 60;
                          if (state.isTimerRunning) {
                            logger.i('read state: ${state.isTimerRunning}');
                             logger.i("timer start");
                            context
                                .read<TimerCubit>()
                                .startTimer(newDurationInSeconds);
                          } else {
                            logger.i("timer reset");
                            context.read<TimerCubit>().cancelTimer();                  
                          }
                        },
                        child: Text(
                            state.isTimerRunning ? "Start Timer" : "Reset Time")),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ElevatedButton(
                      style: Button.buttonForTimer,
                      onPressed: () {
                        _showModalBottomSheet();
                      },
                      child: const Text("Set Time"),
                    ),
                  ),
                ),
              ],
            ),
            renderClock(state),
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


