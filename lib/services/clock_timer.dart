import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:good_dream/services/timer_service.dart';
import 'package:good_dream/utils/toast_notifications.dart';
import 'package:numberpicker/numberpicker.dart';

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
  int _remainingTime = 3600;

  void updateUIFunction(int secondsRemaining) {
    if (mounted) {
      setState(() {
        _remainingTime = secondsRemaining;
        if (_remainingTime <= 0) {
          _exitApp();
        }
      });
    }
  }

  _renderClock() {
    final duration = Duration(seconds: _remainingTime);
    final hours = _formatNumberWithLeadingZero(duration.inHours.remainder(60));
    final minutes =
        _formatNumberWithLeadingZero(duration.inMinutes.remainder(60));
    final seconds =
        _formatNumberWithLeadingZero(duration.inSeconds.remainder(60));

    return Text(
      "$hours:$minutes:$seconds",
      style: const TextStyle(fontSize: 40.0, color: Colors.white),
    );
  }

  _formatNumberWithLeadingZero(int n) {
    return n.toString().padLeft(2, "0");
  }

  final ButtonStyle raiseButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
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
                        _timerService.setAndStartTimer(
                            newDurationInSeconds, updateUIFunction);
                        _isTimerRunning = false;
                      } else {
                        logger.i("timer reset");
                        _timerService.cancelTimer();
                        _isTimerRunning = true;
                        updateUIFunction(newDurationInSeconds);
                      }
                    },
                    child:
                        Text(_isTimerRunning ? "Start Timer" : "Reset Time")),
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
        _renderClock(),
      ],
    );
  }

  Future<void> _showModalBottomSheet() async {
  //  int selectedHour = _selectedHour;
 //   int selectedMinute = _selectedMinute;
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
                          _timerService.setAndStartTimer(
                              newDurationInSeconds, updateUIFunction);
                          _isTimerRunning = false;
                      //    setState(() {
                         //   _selectedHour = selectedHour;
                          //  _selectedMinute = selectedMinute;
                      //    });
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

void _exitApp() {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}
