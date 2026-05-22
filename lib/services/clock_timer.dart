import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/utils/toast_notifications.dart';
import 'package:numberpicker/numberpicker.dart';
import '../bloc/timer/timer_cubit.dart';
import '../bloc/timer/timer_state.dart';
import '../views/widgets/timer_display_widget.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({super.key});

  @override
  State createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer> {
  int _selectedHour = 1;
  int _selectedMinute = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerCubit, TimerState>(
      listenWhen: (previous, current) =>
          previous.isTimerRunning &&
          !current.isTimerRunning &&
          current.remainingTime == 0,
      listener: (context, state) {
        _closeAppAfterTimer(context);
      },
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.isTimerRunning 
                              ? Colors.redAccent.withOpacity(0.8) 
                              : Colors.white.withOpacity(0.04),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          side: BorderSide(
                            color: state.isTimerRunning 
                                ? Colors.redAccent 
                                : Colors.white.withOpacity(0.08),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          int newDurationInSeconds =
                              _selectedHour * 3600 + _selectedMinute * 60;
                          if (!state.isTimerRunning) {
                            context
                                .read<TimerCubit>()
                                .startTimer(newDurationInSeconds);
                          } else {
                            context.read<TimerCubit>().cancelTimer();
                          }
                        },
                        child: Text(
                            state.isTimerRunning 
                                ? AppLocalizations.of(context)!.stop 
                                : AppLocalizations.of(context)!.start,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.04),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.08),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        _showModalBottomSheet();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.setDuration,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TimerDisplayWidget(state: state)
          ],
        );
      },
    );
  }

  Future<void> _closeAppAfterTimer(BuildContext context) async {
    final mediaControlCubit = context.read<MediaControlCubit>();
    await mediaControlCubit.disableAllSoundsAndIcons();
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) {
      return;
    }
    // Keep emulator/debug stable. Release still closes the app on timer end.
    if (!kReleaseMode) {
      return;
    }
    if (kIsWeb) {
      return;
    }
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      SystemNavigator.pop();
    }
  }

  Future<void> _showModalBottomSheet() async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final textColor = Colors.white;
            final mutedTextColor = Colors.white.withOpacity(0.5);

            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F0B29).withOpacity(0.75),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.customDurationTitle,
                          style: TextStyle(
                            fontSize: 22, 
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NumberPicker(
                              value: _selectedHour,
                              minValue: 0,
                              maxValue: 8,
                              onChanged: (value) =>
                                  setState(() => _selectedHour = value),
                              textStyle: TextStyle(color: mutedTextColor),
                              selectedTextStyle: const TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.white.withOpacity(0.1)),
                                  bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                                ),
                              ),
                              textMapper: (numberText) => numberText.padLeft(2, '0'),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(':',
                                  style: TextStyle(color: Colors.amberAccent, fontSize: 28, fontWeight: FontWeight.bold)),
                            ),
                            NumberPicker(
                              value: _selectedMinute,
                              minValue: 1,
                              maxValue: 59,
                              onChanged: (value) =>
                                  setState(() => _selectedMinute = value),
                              textStyle: TextStyle(color: mutedTextColor),
                              selectedTextStyle: const TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.white.withOpacity(0.1)),
                                  bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                                ),
                              ),
                              textMapper: (numberText) => numberText.padLeft(2, '0'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.cancel, 
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final startMsg = AppLocalizations.of(context)?.timeStarted;
                                Navigator.of(context).pop();
                                int newDurationInSeconds =
                                    _selectedHour * 3600 + _selectedMinute * 60;
                                context
                                    .read<TimerCubit>()
                                    .startTimer(newDurationInSeconds);
                                notificationStartCountdown(startMsg);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amberAccent,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 4,
                                shadowColor: Colors.amberAccent.withOpacity(0.3),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.apply, 
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
