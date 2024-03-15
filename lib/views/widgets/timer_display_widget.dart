import 'package:flutter/material.dart';
import '../../bloc/timer/timer_state.dart';

class TimerDisplayWidget extends StatelessWidget {
  final TimerState state;

  const TimerDisplayWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final duration = Duration(seconds: state.remainingTime);
    final hours = formatNumberWithLeadingZero(duration.inHours.remainder(24));
    final minutes = formatNumberWithLeadingZero(duration.inMinutes.remainder(60));
    final seconds = formatNumberWithLeadingZero(duration.inSeconds.remainder(60));

    return Text(
      "$hours:$minutes:$seconds",
      style: const TextStyle(fontSize: 40.0, color: Colors.white),
    );
  }

  String formatNumberWithLeadingZero(int n) {
    return n.toString().padLeft(2, "0");
  }
}
