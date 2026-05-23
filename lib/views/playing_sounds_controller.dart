import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:get_storage/get_storage.dart';

class PlayingSoundsController extends StatefulWidget {
  const PlayingSoundsController({super.key});
  @override
  PlayingSoundsControllerState createState() => PlayingSoundsControllerState();
}

class PlayingSoundsControllerState extends State<PlayingSoundsController>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        final cubit = context.read<MediaControlCubit>();
        final selectedCount = cubit.selectedCount;
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.01),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.06),
                    width: 1.5,
                  ),
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.activeSoundsTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    actions: [
                      if (selectedCount > 0)
                        IconButton(
                          onPressed: () => _saveCurrentMix(context, state.activeSounds),
                          icon: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.amberAccent,
                          ),
                          tooltip: 'Zapisz miks',
                        ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
            children: <Widget>[
              if (selectedCount == 0) ...[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.noActiveSounds,
                      style: const TextStyle(
                        fontSize: 22.0, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 200,
                    child: Lottie.asset('assets/lottieFiles/relax.json'),
                  ),
                )
              ],
              ...state.activeSounds.map((activeSound) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amberAccent.withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.03),
                          ),
                          child: Image(
                            height: 42.0,
                            width: 42.0,
                            image: AssetImage(activeSound.clip.enableIcon),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${activeSound.clip.getLocalizedName(context)} (${(activeSound.volume * 100).toInt()}%)',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 4,
                                  activeTrackColor: Colors.amberAccent,
                                  inactiveTrackColor: Colors.white.withOpacity(0.1),
                                  thumbColor: Colors.amberAccent,
                                  overlayColor: Colors.amberAccent.withOpacity(0.2),
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                ),
                                child: Slider(
                                  value: activeSound.volume,
                                  min: 0,
                                  max: 1,
                                  divisions: 50,
                                  onChanged: (volume) {
                                    cubit.setVolume(activeSound.clip.id, volume);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                          onPressed: () {
                            cubit.toggleSound('', activeSound.clip);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _saveCurrentMix(BuildContext context, List<dynamic> activeSounds) {
    final localizations = AppLocalizations.of(context)!;
    final storage = GetStorage();
    List favs = storage.read<List>('favorites') ?? [];
    
    if (favs.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.aiMixSaveLimit,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF1E1242),
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      );
      return;
    }

    final nameController = TextEditingController();
    
    // Auto-detect a recommended cover based on active sounds
    final soundIds = activeSounds.map((s) => s.clip.id.toLowerCase() as String).toList();
    String recommendedCover = 'default_cover.webp';
    for (final id in soundIds) {
      if (id.contains('sea') || id.contains('ocean')) {
        recommendedCover = 'ocean_cover.webp';
        break;
      }
      if (id.contains('waterfall')) {
        recommendedCover = 'waterfall_cover.webp';
        break;
      }
      if (id.contains('thunder') || id.contains('storm')) {
        recommendedCover = 'storm_cover.webp';
        break;
      }
      if (id.contains('fireplace')) {
        recommendedCover = 'fireplace_cover.webp';
        break;
      }
      if (id.contains('cricket')) {
        recommendedCover = 'meadow_cover.webp';
        break;
      }
      if (id.contains('noise') ||
          id.contains('vacuum') ||
          id.contains('hair') ||
          id.contains('conditioner') ||
          id.contains('washing')) {
        recommendedCover = 'noise_cover.webp';
        break;
      }
      if (id.contains('rain')) {
        recommendedCover = 'rain_cover.webp';
        break;
      }
      if (id.contains('forest') || id.contains('bird') || id.contains('creek')) {
        recommendedCover = 'forest_cover.webp';
        break;
      }
      if (id.contains('bonfire') || id.contains('fire')) {
        recommendedCover = 'bonfire_cover.webp';
        break;
      }
      if (id.contains('meditation') || id.contains('binaural')) {
        recommendedCover = 'meditation_cover.webp';
        break;
      }
      if (id.contains('piano')) {
        recommendedCover = 'piano_cover.webp';
        break;
      }
      if (id.contains('zen') || id.contains('flute')) {
        recommendedCover = 'zen_cover.webp';
        break;
      }
      if (id.contains('train')) {
        recommendedCover = 'train_cover.webp';
        break;
      }
      if (id.contains('sleep') || id.contains('wind')) {
        recommendedCover = 'sleep_cover.webp';
        break;
      }
    }

    String localSelectedCover = recommendedCover;

    final List<String> allCovers = [
      'sleep_cover.webp',
      'forest_cover.webp',
      'bonfire_cover.webp',
      'meditation_cover.webp',
      'piano_cover.webp',
      'rain_cover.webp',
      'zen_cover.webp',
      'train_cover.webp',
      'ocean_cover.webp',
      'waterfall_cover.webp',
      'storm_cover.webp',
      'fireplace_cover.webp',
      'meadow_cover.webp',
      'noise_cover.webp',
    ];

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1242),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Text(
                localizations.activeSoundsTitle,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      localizations.aiMixNameChoice,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "np. Mój Relaks",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF00F2FE)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      localizations.aiMixCoverChoice,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: allCovers.map((cover) {
                          final isSelected = localSelectedCover == cover;
                          final isAiRecommended = cover == recommendedCover;

                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                localSelectedCover = cover;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected 
                                      ? const Color(0xFF00F2FE) 
                                      : Colors.white.withOpacity(0.08),
                                  width: isSelected ? 2.0 : 1.0,
                                ),
                                boxShadow: isSelected 
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF00F2FE).withOpacity(0.3),
                                          blurRadius: 6,
                                        )
                                      ]
                                    : [],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.asset(
                                        'assets/images/$cover',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (isSelected)
                                      Positioned.fill(
                                        child: Container(
                                          color: const Color(0xFF00F2FE).withOpacity(0.12),
                                        ),
                                      ),
                                    if (isAiRecommended)
                                      Positioned(
                                        top: 2,
                                        right: 2,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: Colors.amberAccent.withOpacity(0.85),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'AI',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 7,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(localizations.cancel, style: const TextStyle(color: Colors.white54)),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim().isNotEmpty
                        ? nameController.text.trim()
                        : "Mój Miks";
                    
                    // Double check limit before writing
                    List currentFavs = storage.read<List>('favorites') ?? [];
                    if (currentFavs.length >= 6) {
                      Navigator.of(dialogContext).pop();
                      return;
                    }

                    final newMix = {
                      'name': name,
                      'image': localSelectedCover,
                      'sounds': activeSounds.map((s) => {
                        'id': s.clip.id,
                        'volume': s.volume,
                      }).toList(),
                    };

                    currentFavs.add(newMix);
                    storage.write('favorites', currentFavs);

                    Navigator.of(dialogContext).pop(); // Close dialog
                    Navigator.of(context).pop(); // Close bottom sheet modal

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          localizations.aiMixSavedSuccess(name),
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFF0F0B29),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          side: BorderSide(color: Colors.amberAccent.withOpacity(0.5), width: 1.5),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent, foregroundColor: Colors.black),
                  child: Text(localizations.yes),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
