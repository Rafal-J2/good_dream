import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/views/main_tab_bar_controller.dart';



class TutorialService {
  static final storage = GetStorage();
  
  // Global keys to identify our spotlight targets across screens
  static final GlobalKey tuneButtonKey = GlobalKey();
  static final GlobalKey firstSoundTileKey = GlobalKey();
  static final GlobalKey firstSoundSliderKey = GlobalKey();
  static final GlobalKey activeSoundsBottomBarKey = GlobalKey();
  static final GlobalKey saveMixButtonKey = GlobalKey();
  static final GlobalKey timerButtonKey = GlobalKey();

  static const String _completedKey = 'has_completed_tutorial';
  static const String _stepKey = 'current_tutorial_step';

  static bool isTutorialActive = false;
  static VoidCallback? onStep3TargetTapped;
  static VoidCallback? onStep5TargetTapped;

  /// Check if the user has already finished the entire tutorial.
  static bool hasCompleted() {
    return storage.read<bool>(_completedKey) ?? false;
  }

  /// Get the current tutorial step (0 to 5).
  static int getStep() {
    return storage.read<int>(_stepKey) ?? 0;
  }

  /// Update the current tutorial step.
  static void setStep(int step) {
    storage.write(_stepKey, step);
  }

  /// Mark the tutorial as completely finished.
  static void finishTutorial() {
    storage.write(_completedKey, true);
    storage.write(_stepKey, 6);
  }

  /// Reset the tutorial to start over (useful for debugging or manual retries).
  static void resetTutorial() {
    storage.write(_completedKey, false);
    storage.write(_stepKey, 0);

    // Ensure 'Głęboka Medytacja' is present in favorites when resetting
    List favs = storage.read<List>('favorites') ?? [];
    bool containsDeepMeditation = favs.any((element) {
      final name = (element as Map)['name'] as String? ?? '';
      return name.toLowerCase().trim() == 'głęboka medytacja' || name.toLowerCase().trim() == 'deep meditation';
    });
    
    if (!containsDeepMeditation) {
      final deepMeditationMix = {
        'name': 'Głęboka Medytacja',
        'image': 'meditation_cover.webp',
        'sounds': [
          {'id': 'Meditation', 'volume': 0.9},
          {'id': 'Sea', 'volume': 0.3},
        ]
      };
      // Insert at the beginning so it is prominently visible first
      favs.insert(0, deepMeditationMix);
      // Ensure we don't exceed the max favorites limit (6)
      if (favs.length > 6) {
        favs = favs.sublist(0, 6);
      }
      storage.write('favorites', favs);
    }
  }

  // --- STEP 1: Highlight the Mixer Tune button on Favorites page ---
  static void startStep1(BuildContext context) {
    if (hasCompleted() || getStep() != 0 || isTutorialActive) return;

    // Auto-play the 'Głęboka Medytacja' mix when tutorial starts/resets
    try {
      context.read<MediaControlCubit>().playDeepMeditationMix();
    } catch (_) {}

    isTutorialActive = true;
    final localizations = AppLocalizations.of(context)!;
    
    // Create the target focus
    final targets = [
      TargetFocus(
        identify: "tuneButton",
        keyTarget: tuneButtonKey,
        alignSkip: Alignment.topLeft,
        shape: ShapeLightFocus.Circle,
        radius: 24,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildPremiumBubble(
                context: context,
                title: localizations.tutorialStep1Title,
                description: localizations.tutorialStep1Desc,
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      )
    ];

    late TutorialCoachMark tutorial;
    tutorial = TutorialCoachMark(
      targets: targets,
      colorShadow: const Color(0xDC070514),
      skipWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          localizations.tutorialSkip.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
      onClickTarget: (target) {
        // Increment step so the next page knows to start Step 2
        setStep(1);
        isTutorialActive = false;
        tutorial.finish();
        // Programmatically push MainTabBarController on the very first click
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainTabBarController(),
          ),
        );
      },
      onSkip: () {
        finishTutorial();
        isTutorialActive = false;
        return true;
      },
      onFinish: () {
        setStep(1);
        isTutorialActive = false;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainTabBarController(),
          ),
        );
        return true;
      },
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (context.mounted) {
        tutorial.show(context: context);
      }
    });
  }

  // --- STEP 2: Highlight the first sound card in Mikser ---
  static void startStep2(BuildContext context, VoidCallback onFirstSoundTapped) {
    if (hasCompleted() || getStep() != 1 || isTutorialActive) return;

    isTutorialActive = true;
    final localizations = AppLocalizations.of(context)!;

    final targets = [
      TargetFocus(
        identify: "firstSoundTile",
        keyTarget: firstSoundTileKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        paddingFocus: 4,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildPremiumBubble(
                context: context,
                title: localizations.tutorialStep2Title,
                description: localizations.tutorialStep2Desc,
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      )
    ];

    late TutorialCoachMark tutorial;
    tutorial = TutorialCoachMark(
      targets: targets,
      colorShadow: const Color(0xDC070514),
      skipWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          localizations.tutorialSkip.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
      onClickTarget: (target) {
        onFirstSoundTapped(); // Programmatic callback to toggle the sound
        setStep(2);
        isTutorialActive = false;
        tutorial.finish();
        // Trigger Step 3 with a slight delay so the slider is fully rendered
        Future.delayed(const Duration(milliseconds: 600), () {
          if (context.mounted) {
            startStep3(context);
          }
        });
      },
      onSkip: () {
        finishTutorial();
        isTutorialActive = false;
        return true;
      },
      onFinish: () {
        onFirstSoundTapped(); // Programmatic callback to toggle the sound
        setStep(2);
        isTutorialActive = false;
        Future.delayed(const Duration(milliseconds: 600), () {
          if (context.mounted) {
            startStep3(context);
          }
        });
        return true;
      },
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        tutorial.show(context: context);
      }
    });
  }

  // --- STEP 3: Highlight the active sounds drawer launcher button ---
  static void startStep3(BuildContext context) {
    if (hasCompleted() || getStep() != 2 || isTutorialActive) return;

    isTutorialActive = true;
    final localizations = AppLocalizations.of(context)!;

    final targets = [
      TargetFocus(
        identify: "activeBar",
        keyTarget: activeSoundsBottomBarKey,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildPremiumBubble(
                context: context,
                title: localizations.tutorialStep3Title,
                description: localizations.tutorialStep3Desc,
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      )
    ];

    late TutorialCoachMark tutorial;
    tutorial = TutorialCoachMark(
      targets: targets,
      colorShadow: const Color(0xDC070514),
      skipWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          localizations.tutorialSkip.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
      onClickTarget: (target) {
        isTutorialActive = false;
        tutorial.finish();
        // Delay opening modal by 350ms to allow overlay fade-out to complete and avoid race condition
        Future.delayed(const Duration(milliseconds: 350), () {
          setStep(3);
          if (onStep3TargetTapped != null) {
            onStep3TargetTapped!();
          }
        });
      },
      onSkip: () {
        finishTutorial();
        isTutorialActive = false;
        return true;
      },
      onFinish: () {
        isTutorialActive = false;
        // Delay opening modal by 350ms to allow overlay fade-out to complete and avoid race condition
        Future.delayed(const Duration(milliseconds: 350), () {
          setStep(3);
          if (onStep3TargetTapped != null) {
            onStep3TargetTapped!();
          }
        });
        return true;
      },
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (context.mounted) {
        tutorial.show(context: context);
      }
    });
  }

  // --- STEP 4: Highlight the slider of the newly active sound inside bottom sheet ---
  static void startStep4(BuildContext context) {
    if (hasCompleted() || getStep() != 3 || isTutorialActive) return;

    isTutorialActive = true;
    final localizations = AppLocalizations.of(context)!;

    final targets = [
      TargetFocus(
        identify: "firstSoundSlider",
        keyTarget: firstSoundSliderKey,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        paddingFocus: 2,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildPremiumBubble(
                context: context,
                title: localizations.tutorialStep4Title,
                description: localizations.tutorialStep4Desc,
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      )
    ];

    late TutorialCoachMark tutorial;
    tutorial = TutorialCoachMark(
      targets: targets,
      colorShadow: const Color(0xDC070514),
      skipWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          localizations.tutorialSkip.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
      onClickTarget: (target) {
        // Programmatically set the volume of the last added sound to 70% (0.7) and update UI
        try {
          final cubit = context.read<MediaControlCubit>();
          if (cubit.state.activeSounds.isNotEmpty) {
            final lastActive = cubit.state.activeSounds.last;
            cubit.setVolume(lastActive.clip.id, 0.7);
          }
        } catch (_) {}

        setStep(4);
        isTutorialActive = false;
        tutorial.finish();
        Future.delayed(const Duration(milliseconds: 600), () {
          if (context.mounted) {
            startStep5(context);
          }
        });
      },
      onSkip: () {
        finishTutorial();
        isTutorialActive = false;
        return true;
      },
      onFinish: () {
        // Programmatically set the volume of the last added sound to 70% (0.7) and update UI
        try {
          final cubit = context.read<MediaControlCubit>();
          if (cubit.state.activeSounds.isNotEmpty) {
            final lastActive = cubit.state.activeSounds.last;
            cubit.setVolume(lastActive.clip.id, 0.7);
          }
        } catch (_) {}

        setStep(4);
        isTutorialActive = false;
        Future.delayed(const Duration(milliseconds: 600), () {
          if (context.mounted) {
            startStep5(context);
          }
        });
        return true;
      },
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (context.mounted) {
        tutorial.show(context: context);
      }
    });
  }

  // --- STEP 5: Highlight the golden heart icon inside PlayingSoundsController sheet ---
  static void startStep5(BuildContext context) {
    if (hasCompleted() || getStep() != 4 || isTutorialActive) return;

    isTutorialActive = true;
    final localizations = AppLocalizations.of(context)!;

    final targets = [
      TargetFocus(
        identify: "saveMix",
        keyTarget: saveMixButtonKey,
        shape: ShapeLightFocus.Circle,
        radius: 24,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildPremiumBubble(
                context: context,
                title: localizations.tutorialStep5Title,
                description: localizations.tutorialStep5Desc,
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
                isLast: true,
              );
            },
          )
        ],
      )
    ];

    late TutorialCoachMark tutorial;
    tutorial = TutorialCoachMark(
      targets: targets,
      colorShadow: const Color(0xDC070514),
      skipWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          localizations.tutorialSkip.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
      onClickTarget: (target) {
        finishTutorial();
        isTutorialActive = false;
        tutorial.finish();
        // Delay opening save dialog by 350ms to allow overlay fade-out to complete and avoid race condition
        Future.delayed(const Duration(milliseconds: 350), () {
          if (onStep5TargetTapped != null) {
            onStep5TargetTapped!();
          }
        });
      },
      onSkip: () {
        finishTutorial();
        isTutorialActive = false;
        return true;
      },
      onFinish: () {
        finishTutorial();
        isTutorialActive = false;
        // Delay opening save dialog by 350ms to allow overlay fade-out to complete and avoid race condition
        Future.delayed(const Duration(milliseconds: 350), () {
          if (onStep5TargetTapped != null) {
            onStep5TargetTapped!();
          }
        });
        return true;
      },
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (context.mounted) {
        tutorial.show(context: context);
      }
    });
  }

  /// Glassmorphic premium helper to build tutorial cards.
  static Widget _buildPremiumBubble({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onNext,
    required VoidCallback onSkip,
    bool isLast = false,
  }) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF140F35).withOpacity(0.96),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.amberAccent.withOpacity(0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amberAccent.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onSkip,
                child: Text(
                  localizations.tutorialSkip,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ),
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isLast ? localizations.tutorialFinish : localizations.tutorialNext,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
