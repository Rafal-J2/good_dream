import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/services/tutorial_service.dart';
import 'package:good_dream/services/analytics_service.dart';

class PlayingSoundsController extends StatefulWidget {
  const PlayingSoundsController({super.key});
  @override
  PlayingSoundsControllerState createState() => PlayingSoundsControllerState();
}

class PlayingSoundsControllerState extends State<PlayingSoundsController>
    with AutomaticKeepAliveClientMixin {
  bool _isSaveDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    TutorialService.onStep5TargetTapped = () {
      if (mounted) {
        _saveCurrentMix(context, context.read<MediaControlCubit>().state.activeSounds);
      }
    };

    if (TutorialService.getStep() == 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          TutorialService.startStep4(context);
        }
      });
    }
    if (TutorialService.getStep() == 4) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          TutorialService.startStep5(context);
        }
      });
    }

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
                          key: TutorialService.saveMixButtonKey,
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
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 4,
                              activeTrackColor: Colors.amberAccent,
                              inactiveTrackColor: Colors.white.withOpacity(0.1),
                              thumbColor: Colors.amberAccent,
                              overlayColor: Colors.amberAccent.withOpacity(0.2),
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            ),
                            child: Slider(
                              key: (TutorialService.getStep() == 3 && state.activeSounds.indexOf(activeSound) == state.activeSounds.length - 1)
                                  ? TutorialService.firstSoundSliderKey
                                  : null,
                              value: activeSound.volume,
                              min: 0,
                              max: 1,
                              divisions: 50,
                              onChanged: (volume) {
                                cubit.setVolume(activeSound.clip.id, volume);
                              },
                            ),
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

  List<String> _generateNameSuggestions(List<dynamic> activeSounds, String lang) {
    final ids = activeSounds.map((s) => s.clip.id.toString().toLowerCase().trim()).toList();
    if (ids.isEmpty) {
      if (lang == 'en') return ["My Quiet Corner", "Relaxation Moment", "Sleepy Mix"];
      if (lang == 'hi') return ["मेरा शांत कोना", "विश्राम का क्षण", "नींद भरा मिक्स"];
      return ["Mój Cichy Zakątek", "Chwila Relaksu", "Senny Miks"];
    }

    final bool hasRain = ids.any((id) => id.contains('rain'));
    final bool hasSea = ids.any((id) => id.contains('sea') || id.contains('ocean'));
    final bool hasForest = ids.any((id) => id.contains('forest') || id.contains('wood') || id.contains('bird') || id.contains('cricket'));
    final bool hasFire = ids.any((id) => id.contains('fire') || id.contains('bonfire') || id.contains('fireplace'));
    final bool hasMusic = ids.any((id) => id.contains('meditation') || id.contains('piano') || id.contains('guitar') || id.contains('flute') || id.contains('zen') || id.contains('yoga') || id.contains('binaural') || id.contains('om'));
    final bool hasWind = ids.any((id) => id.contains('wind'));
    final bool hasWater = ids.any((id) => id.contains('river') || id.contains('creek') || id.contains('waterfall') || id.contains('fountain') || id.contains('jacuzzi') || id.contains('cave'));
    final bool hasMechanical = ids.any((id) => id.contains('plane') || id.contains('train') || id.contains('car') || id.contains('bus') || id.contains('washing') || id.contains('hair') || id.contains('vacuum') || id.contains('keyboard'));

    final List<String> suggestions = [];

    if (hasRain && hasMusic) {
      if (lang == 'en') {
        suggestions.addAll(["Melody in Rain", "Rainy Concert", "Calm Note in Drops"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["बारिश में राग", "बारिश का संगीत", "बूंदों में शांत स्वर"]);
      } else {
        suggestions.addAll(["Melodia w Deszczu", "Deszczowy Koncert", "Spokojna Nuta w Kroplach"]);
      }
    } else if (hasSea && hasMusic) {
      if (lang == 'en') {
        suggestions.addAll(["Sea Symphony", "Waves and Piano", "Oceanic Relaxation"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["समुद्री सिम्फनी", "लहरें और पियानो", "महासागरीय विश्राम"]);
      } else {
        suggestions.addAll(["Morska Symfonia", "Fale i Fortepian", "Oceaniczny Relaks"]);
      }
    } else if (hasForest && hasMusic) {
      if (lang == 'en') {
        suggestions.addAll(["Forest Meditation", "Birds and Flute", "Green Harmony"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["वन ध्यान", "पक्षियों का गान और बांसुरी", "हरित सद्भाव"]);
      } else {
        suggestions.addAll(["Leśna Medytacja", "Śpiew Ptaków i Flet", "Zielona Harmonia"]);
      }
    } else if (hasFire && hasMusic) {
      if (lang == 'en') {
        suggestions.addAll(["Evening by Fireplace", "Guitar by Bonfire", "Warm Flame of Music"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["अलाव के पास शाम", "कैंपफायर पर गिटार", "संगीत की गर्म लौ"]);
      } else {
        suggestions.addAll(["Wieczór przy Kominku", "Gitara przy Ognisku", "Ciepły Płomień Muzyki"]);
      }
    } else if (hasRain && hasForest) {
      if (lang == 'en') {
        suggestions.addAll(["Forest Rain", "Rustle of Trees and Drops", "Night Storm in Forest"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["वन की वर्षा", "पेड़ों की सरसराहट og बूंदें", "जंगल में रात का तूफान"]);
      } else {
        suggestions.addAll(["Leśny Deszcz", "Szum Drzew i Krople", "Nocna Burza w Lesie"]);
      }
    } else if (hasSea && hasWind) {
      if (lang == 'en') {
        suggestions.addAll(["Sea Wind", "Ocean Whisper", "Salty Breeze"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["समुद्री हवा", "समुद्र की फुसफुसाहट", "नमकीन हवा"]);
      } else {
        suggestions.addAll(["Morski Wiatr", "Szept Oceanu", "Słona Bryza"]);
      }
    } else if (hasFire && hasForest) {
      if (lang == 'en') {
        suggestions.addAll(["Bonfire in Wilderness", "Warmth of Forest Night", "Crackling Wood"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["जंगल में अलाव", "वन रात्रि की गर्मी", "चटकती लकड़ी"]);
      } else {
        suggestions.addAll(["Ognisko w Głuszy", "Ciepło Leśnej Nocy", "Trzaskające Drewno"]);
      }
    } else if (hasWater && hasRain) {
      if (lang == 'en') {
        suggestions.addAll(["Rain over Creek", "Mountain Waterfall in Drops", "Flow of Rainy River"]);
      } else if (lang == 'hi') {
        suggestions.addAll(["झरने पर बारिश", "पहाड़ी झरना बूंदों में", "बरसाती नदी का बहाव"]);
      } else {
        suggestions.addAll(["Deszcz nad Potokiem", "Górski Wodospad w Kroplach", "Bieg Deszczowej Rzeki"]);
      }
    } else {
      final primaryId = ids.first;
      if (primaryId.contains('rain')) {
        if (lang == 'en') {
          suggestions.addAll(["Calm Rain", "Drops on Window", "Night Downpour"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["शांत बारिश", "खिड़की पर बूंदें", "रात की मूसलाधार बारिश"]);
        } else {
          suggestions.addAll(["Spokojny Deszcz", "Krople na Szybie", "Nocna Ulewa"]);
        }
      } else if (primaryId.contains('sea') || primaryId.contains('ocean')) {
        if (lang == 'en') {
          suggestions.addAll(["Ocean Sound", "Peaceful Beach", "Depth of Calm"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["समुद्र का शोर", "शांत समुद्र तट", "शांति की गहराई"]);
        } else {
          suggestions.addAll(["Szum Oceanu", "Spokojna Plaża", "Głębia Spokoju"]);
        }
      } else if (primaryId.contains('forest') || primaryId.contains('bird') || primaryId.contains('cricket') || primaryId.contains('woodpecker') || primaryId.contains('frog')) {
        if (lang == 'en') {
          suggestions.addAll(["Forest Corner", "Birdsong", "Night Crickets"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["वन का कोना", "पक्षियों की चहचहाहट", "रात के झिंगुर"]);
        } else {
          suggestions.addAll(["Leśny Zakątek", "Śpiew Ptaków", "Nocne Świerszcze"]);
        }
      } else if (primaryId.contains('fire')) {
        if (lang == 'en') {
          suggestions.addAll(["Warm Fireplace", "Flame of Calm", "Golden Glow"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["गर्म चिमनी", "शांति की लौ", "सुनहरी चमक"]);
        } else {
          suggestions.addAll(["Ciepły Kominek", "Płomień Spokoju", "Złoty Blask"]);
        }
      } else if (primaryId.contains('piano')) {
        if (lang == 'en') {
          suggestions.addAll(["Piano Melody", "Soothing Key", "Evening Piano"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["पियानो राग", "सुखदायक सुर", "शाम का पियानो"]);
        } else {
          suggestions.addAll(["Melodia Fortepianu", "Kojący Klawisz", "Wieczorne Piano"]);
        }
      } else if (primaryId.contains('guitar')) {
        if (lang == 'en') {
          suggestions.addAll(["Calm Guitar", "Relaxing Chords", "Warm Strings"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["शांत gिटार", "विश्राम के स्वर", "गर्म तार"]);
        } else {
          suggestions.addAll(["Spokojna Gitara", "Akordy Relaksu", "Ciepłe Struny"]);
        }
      } else if (primaryId.contains('meditation') || primaryId.contains('healing') || primaryId.contains('yoga') || primaryId.contains('zen')) {
        if (lang == 'en') {
          suggestions.addAll(["Deep Meditation", "Zen State", "Mind Soothing"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["गहन ध्यान", "ज़ेन की स्थिति", "मन की शांति"]);
        } else {
          suggestions.addAll(["Głęboka Medytacja", "Stan Zen", "Ukojenie Umysłu"]);
        }
      } else if (primaryId.contains('flute')) {
        if (lang == 'en') {
          suggestions.addAll(["Soothing Flute", "Ethereal Breeze", "Wind Melody"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["सुखदायक बांसुरी", "अलौकिक हवा", "हवा का राग"]);
        } else {
          suggestions.addAll(["Kojący Flet", "Eteryczny Powiew", "Melodia Wiatru"]);
        }
      } else if (primaryId.contains('binaural')) {
        if (lang == 'en') {
          suggestions.addAll(["Binaural Beats", "Deep Sleep", "Mind Harmony"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["बाइनॉरल बीट्स", "गहरी नींद", "मन का सामंजस्य"]);
        } else {
          suggestions.addAll(["Fale Binauralne", "Głęboki Sen", "Harmonia Umysłu"]);
        }
      } else if (primaryId.contains('wind')) {
        if (lang == 'en') {
          suggestions.addAll(["Soothing Wind", "Night Breeze", "Wind Whisper"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["सुखदायक हवा", "रात की हवा", "हवा की सरसराहट"]);
        } else {
          suggestions.addAll(["Kojący Wiatr", "Powiew Nocy", "Szum Halnego"]);
        }
      } else if (primaryId.contains('waterfall') || primaryId.contains('river') || primaryId.contains('creek') || primaryId.contains('fountain') || primaryId.contains('jacuzzi') || primaryId.contains('cave')) {
        if (lang == 'en') {
          suggestions.addAll(["Mountain Creek", "Waterfall Sound", "River Flow"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["पहाड़ी जलधारा", "झरने की आवाज", "नदी का बहाव"]);
        } else {
          suggestions.addAll(["Górski Potok", "Szum Wodospadu", "Bieg Rzeki"]);
        }
      } else if (hasMechanical) {
        if (lang == 'en') {
          suggestions.addAll(["White Noise", "Train Journey", "Steady Rhythm"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["सफेद शोर", "ट्रेन की यात्रा", "स्थिर लय"]);
        } else {
          suggestions.addAll(["Biały Szum", "Podróż Pociągiem", "Jednostajny Rytm"]);
        }
      } else {
        if (lang == 'en') {
          suggestions.addAll(["My Relaxation", "Soothing Moment", "Evening Calm"]);
        } else if (lang == 'hi') {
          suggestions.addAll(["मेरा विश्राम", "सुखदायक क्षण", "शाम की शांति"]);
        } else {
          suggestions.addAll(["Mój Relaks", "Kojąca Chwila", "Wieczorny Spokój"]);
        }
      }
    }

    final unique = <String>{};
    for (var name in suggestions) {
      if (unique.length < 3) unique.add(name);
    }
    while (unique.length < 3) {
      if (lang == 'en') {
        unique.add("My Mix ${unique.length + 1}");
      } else if (lang == 'hi') {
        unique.add("मेरा मिक्स ${unique.length + 1}");
      } else {
        unique.add("Mój Miks ${unique.length + 1}");
      }
    }
    return unique.toList();
  }

  Future<void> _saveCurrentMix(BuildContext context, List<dynamic> activeSounds) async {
    if (_isSaveDialogOpen) return;
    _isSaveDialogOpen = true;
    try {
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

    final lang = Localizations.localeOf(context).languageCode;
    final suggestedNames = _generateNameSuggestions(activeSounds, lang);
    final nameController = TextEditingController(text: suggestedNames.isNotEmpty ? suggestedNames.first : "");
    
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

    final usedCovers = favs.map((f) => f['image'] as String?).where((img) => img != null).toSet();

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

    // Filter out already used covers to prevent duplication
    final List<String> availableCovers = allCovers.where((cover) => !usedCovers.contains(cover)).toList();
    if (availableCovers.isEmpty) {
      availableCovers.addAll(allCovers);
    }

    // Ensure the default selected cover is not already used
    if (usedCovers.contains(recommendedCover) || !availableCovers.contains(recommendedCover)) {
      recommendedCover = availableCovers.first;
    }

    String localSelectedCover = recommendedCover;

    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1242),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Text(
                localizations.saveMixDialogTitle,
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
                    const SizedBox(height: 12),
                    Text(
                      localizations.aiNameSuggestions,
                      style: TextStyle(color: Colors.amberAccent.withOpacity(0.9), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: suggestedNames.map((suggestedName) {
                        final isSelectedName = nameController.text == suggestedName;
                        return GestureDetector(
                          onTap: () {
                            setDialogState(() {
                              nameController.text = suggestedName;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(isSelectedName ? 0.12 : 0.04),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelectedName
                                    ? Colors.amberAccent
                                    : Colors.white.withOpacity(0.08),
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              suggestedName,
                              style: TextStyle(
                                color: isSelectedName
                                    ? Colors.amberAccent
                                    : Colors.white70,
                                fontSize: 11.5,
                                fontWeight: isSelectedName ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
                        children: availableCovers.map((cover) {
                          final isSelected = localSelectedCover == cover;

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
                    AnalyticsService.logMixSaved(name, activeSounds.length, localSelectedCover);

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
    } finally {
      _isSaveDialogOpen = false;
    }
  }

  @override
  void dispose() {
    TutorialService.onStep5TargetTapped = null;
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
