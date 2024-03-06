import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/utils/toast_notifications.dart';
import 'package:numberpicker/numberpicker.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({super.key});

  @override
  State createState() => _State();
}

Timer? timer;
late int _seconds;
bool _isTimerRunning = false;
int _selectedHour = 1;
int _selectedMinute = 15;

class _State extends State<ClockTimer> {
  @override
  void initState() {
    super.initState();
    _seconds = 4500;
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void resetRemainingTime() {
    setState(() {
      _isTimerRunning = true;
      _seconds = _selectedHour * 3600 + _selectedMinute * 60;
    });
  }

  _startTimer() {
    _cancelTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });
  }

  _renderClock() {
    final duration = Duration(seconds: _seconds);
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

  _cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    setState(() {
      _seconds = _selectedHour * 3600 + _selectedMinute * 60;
    });
  }

  _tick() {
    setState(() {
      _seconds -= 1;
      if (_seconds <= 0) {
        _cancelTimer();
        _exitApp();
      }
    });
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
                    if (_isTimerRunning) {
                      _cancelTimer();
                      setState(() {
                        _seconds = _selectedHour * 3600 + _selectedMinute * 60;
                      });
                    } else {
                      _startTimer();
                    }
                    _isTimerRunning = !_isTimerRunning;
                  },
                  child: _isTimerRunning
                      ? const Text("Reset Time")
                      : const Text('Start Timer'),
                ),
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
    int selectedHour = _selectedHour;
    int selectedMinute = _selectedMinute;
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
                        value: selectedHour,
                        minValue: 0,
                        maxValue: 8,
                        onChanged: (value) =>
                            setState(() => selectedHour = value),
                      ),
                      const Text(':',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      NumberPicker(
                        value: selectedMinute,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (value) =>
                            setState(() => selectedMinute = value),
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
                          setState(() {
                            _selectedHour = selectedHour;
                            _selectedMinute = selectedMinute;
                            resetRemainingTime();
                            _startTimer();
                          });
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
