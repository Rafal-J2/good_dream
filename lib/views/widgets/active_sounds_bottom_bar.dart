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
import '../../bloc/timer/timer_cubit.dart';
import '../../bloc/timer/timer_state.dart';
import '../playing_sounds_controller.dart';

class ActiveSoundsBottomBar extends StatefulWidget {
  const ActiveSoundsBottomBar({super.key});

  @override
  State<ActiveSoundsBottomBar> createState() => _ActiveSoundsBottomBarState();
}

class _ActiveSoundsBottomBarState extends State<ActiveSoundsBottomBar> {
  int _selectedHour = 1;
  int _selectedMinute = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerCubit, TimerState>(
      listenWhen: (previous, current) =>
          previous.isTimerRunning &&
          !current.isTimerRunning &&
          current.remainingTime == 0,
      listener: (context, timerState) {
        _closeAppAfterTimer(context);
      },
      builder: (context, timerState) {
        return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
          builder: (context, mediaState) {
            final activeCount = mediaState.activeSounds.length;
            final isVisible = activeCount > 0 || timerState.isTimerRunning;

            return AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              child: !isVisible
                  ? const SizedBox.shrink()
                  : SafeArea(
                      bottom: true,
                      top: false,
                      left: false,
                      right: false,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F0B29).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Lewa strona - tylko cyfry wg wytycznych
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: ElevatedButton(
                                        onPressed: () => _showActiveSoundsModal(),
                                        child: Text(
                                          'Aktywne: $activeCount / ${MediaControlCubit.maxActiveSounds}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold, 
                                            fontSize: 13,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white.withOpacity(0.1),
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                          minimumSize: const Size(0, 38),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Środek - Przycisk STOP
                                  IconButton(
                                    icon: const Icon(Icons.stop_circle_rounded, color: Colors.redAccent, size: 30),
                                    onPressed: () {
                                      context.read<MediaControlCubit>().disableAllSoundsAndIcons();
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  // Prawa strona - Timer
                                  _buildTimerButton(context, timerState),
                                ],
                              ),
                            ),
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

  Widget _buildTimerButton(BuildContext context, TimerState timerState) {
    if (timerState.isTimerRunning) {
      final duration = Duration(seconds: timerState.remainingTime);
      final h = duration.inHours > 0 ? '${duration.inHours}:' : '';
      final m = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
      final s = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
      final timeStr = "$h$m:$s";

      return ElevatedButton(
        onPressed: () {
          context.read<TimerCubit>().cancelTimer();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          foregroundColor: Colors.redAccent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          minimumSize: const Size(80, 36),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: BorderSide(color: Colors.redAccent.withOpacity(0.5), width: 1.5),
        ),
        child: Text(timeStr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      );
    } else {
      return ElevatedButton(
        onPressed: () => _showModalBottomSheet(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.1),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          minimumSize: const Size(80, 36),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text(
          'Timer', 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
        ),
      );
    }
  }

  Future<void> _closeAppAfterTimer(BuildContext context) async {
    final mediaControlCubit = context.read<MediaControlCubit>();
    await mediaControlCubit.disableAllSoundsAndIcons();
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) {
      return;
    }
    if (!kReleaseMode) return;
    if (kIsWeb) return;
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      SystemNavigator.pop();
    }
  }

  Future<void> _showActiveSoundsModal() async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: const Color(0xFF0F0B29).withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                  width: 1.5,
                ),
              ),
              child: const PlayingSoundsController(),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showModalBottomSheet() async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
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
                                  setModalState(() => _selectedHour = value),
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
                                  setModalState(() => _selectedMinute = value),
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
