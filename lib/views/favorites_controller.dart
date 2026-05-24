import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:good_dream/models/sounds_catalog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:good_dream/views/main_menu_navigator.dart';
import 'package:good_dream/views/main_tab_bar_controller.dart';
import 'package:good_dream/services/tutorial_service.dart';
class FavoritesController extends StatefulWidget {
  const FavoritesController({super.key});

  @override
  State<FavoritesController> createState() => _FavoritesControllerState();
}

class _FavoritesControllerState extends State<FavoritesController>
    with AutomaticKeepAliveClientMixin {
  final _storage = GetStorage();
  List<dynamic> _favorites = [];

  // 8 pre-generated curated random mixes
  final List<Map<String, dynamic>> _randomMixes = [
    {
      'name': 'Niebiański Zen',
      'image': 'zen_cover.webp',
      'sounds': [
        {'id': 'Zen', 'volume': 0.6},
        {'id': 'Flute', 'volume': 0.5},
        {'id': 'River', 'volume': 0.2},
      ]
    },
    {
      'name': 'Głęboka Medytacja',
      'image': 'meditation_cover.webp',
      'sounds': [
        {'id': 'Meditation', 'volume': 0.9},
        {'id': 'Sea', 'volume': 0.3},
      ]
    },
    {
      'name': 'Spokojne Piano',
      'image': 'piano_cover.webp',
      'sounds': [
        {'id': 'Piano', 'volume': 0.6},
        {'id': 'cricket', 'volume': 0.3},
      ]
    },
    {
      'name': 'Głęboki Sen',
      'image': 'sleep_cover.webp',
      'sounds': [
        {'id': 'Rain', 'volume': 0.4},
        {'id': 'wind', 'volume': 0.5},
        {'id': 'cricket', 'volume': 0.5},
      ]
    },
    {
      'name': 'Leśna Cisza',
      'image': 'forest_cover.webp',
      'sounds': [
        {'id': 'forest', 'volume': 0.4},
        {'id': 'Small creek', 'volume': 0.5},
        {'id': 'Background Guitar', 'volume': 0.5},
      ]
    },
    {
      'name': 'Wieczorne Ognisko',
      'image': 'bonfire_cover.webp',
      'sounds': [
        {'id': 'bonfire', 'volume': 0.5},
        {'id': 'cricket', 'volume': 0.5},
        {'id': 'wind', 'volume': 0.4},
        {'id': 'Background Guitar', 'volume': 0.5},
      ]
    },
    {
      'name': 'Biały Szum Deszczu',
      'image': 'rain_cover.webp',
      'sounds': [
        {'id': 'Rain on car roof', 'volume': 0.7},
        {'id': 'thunder', 'volume': 0.3},
      ]
    },
    {
      'name': 'Podróż Pociągiem',
      'image': 'train_cover.webp',
      'sounds': [
        {'id': 'Train', 'volume': 0.6},
        {'id': 'Rain on windows', 'volume': 0.4},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        TutorialService.startStep1(context);
      }
    });
  }

  void _loadFavorites() {
    setState(() {
      _favorites = _storage.read<List>('favorites') ?? [];
    });
  }

  void _deleteFavorite(int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1242),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Usuwanie miksu', style: TextStyle(color: Colors.white)),
          content: const Text('Czy na pewno chcesz usunąć ten miks z ulubionych?', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Anuluj', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                setState(() {
                  _favorites.removeAt(index);
                  _storage.write('favorites', _favorites);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Usuń', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  AudioClip? _findClipById(String id) {
    for (final categoryList in soundsByCategory.values) {
      for (final clip in categoryList) {
        if (clip.id.toLowerCase() == id.trim().toLowerCase()) {
          return clip;
        }
      }
    }
    return null;
  }

  String _getCoverForMix(Map<String, dynamic> mix) {
    if (mix.containsKey('image') && mix['image'] != null) {
      return mix['image'] as String;
    }
    
    // Fallback/Dynamic detection for user favorites
    final sounds = mix['sounds'] as List<dynamic>? ?? [];
    final soundIds = sounds.map((s) {
      final id = (s as Map)['id'] as String? ?? '';
      return id.toLowerCase();
    }).toList();

    for (final id in soundIds) {
      if (id.contains('sea') || id.contains('ocean')) {
        return 'ocean_cover.webp';
      }
      if (id.contains('waterfall')) {
        return 'waterfall_cover.webp';
      }
      if (id.contains('thunder') || id.contains('storm')) {
        return 'storm_cover.webp';
      }
      if (id.contains('fireplace')) {
        return 'fireplace_cover.webp';
      }
      if (id.contains('cricket')) {
        return 'meadow_cover.webp';
      }
      if (id.contains('noise') ||
          id.contains('vacuum') ||
          id.contains('hair') ||
          id.contains('conditioner') ||
          id.contains('washing')) {
        return 'noise_cover.webp';
      }
      if (id.contains('rain')) {
        return 'rain_cover.webp';
      }
      if (id.contains('forest') || id.contains('bird') || id.contains('creek')) {
        return 'forest_cover.webp';
      }
      if (id.contains('bonfire') || id.contains('fire')) {
        return 'bonfire_cover.webp';
      }
      if (id.contains('meditation') || id.contains('binaural')) {
        return 'meditation_cover.webp';
      }
      if (id.contains('piano')) {
        return 'piano_cover.webp';
      }
      if (id.contains('zen') || id.contains('flute')) {
        return 'zen_cover.webp';
      }
      if (id.contains('train')) {
        return 'train_cover.webp';
      }
      if (id.contains('sleep') || id.contains('wind')) {
        return 'sleep_cover.webp';
      }
    }

    return 'default_cover.webp';
  }

  Future<void> _playFavorite(Map<String, dynamic> mix) async {
    final cubit = context.read<MediaControlCubit>();
    
    // Toggle active mix off if clicked again
    final activeIds = cubit.state.activeSounds.map((e) => e.clip.id.toLowerCase()).toSet();
    final mixSounds = mix['sounds'] as List<dynamic>? ?? [];
    final mixIds = mixSounds.map((e) {
      final id = (e as Map)['id'] as String? ?? '';
      return id.toLowerCase();
    }).where((id) => id.isNotEmpty).toSet();

    final isCurrentlyActive = activeIds.isNotEmpty && 
                              mixIds.isNotEmpty && 
                              activeIds.length == mixIds.length && 
                              activeIds.containsAll(mixIds);

    if (isCurrentlyActive) {
      await cubit.disableAllSoundsAndIcons();
      return;
    }

    await cubit.disableAllSoundsAndIcons();

    final List<MapEntry<AudioClip, double>> clipsToPlay = [];
    final sounds = mix['sounds'] as List<dynamic>? ?? [];

    for (final s in sounds) {
      final item = s as Map<String, dynamic>;
      final id = item['id'] as String? ?? '';
      final volume = (item['volume'] as num? ?? 0.5).toDouble();
      final clip = _findClipById(id);
      if (clip != null) {
        clipsToPlay.add(MapEntry(clip, volume));
      }
    }

    if (clipsToPlay.isNotEmpty) {
      await cubit.playSoundMixWithVolumes(clipsToPlay);
    }
  }

  bool _isMixActive(Map<String, dynamic> mix) {
    final cubit = context.watch<MediaControlCubit>();
    final activeIds = cubit.state.activeSounds.map((e) => e.clip.id.toLowerCase()).toSet();
    
    final mixSounds = mix['sounds'] as List<dynamic>? ?? [];
    final mixIds = mixSounds.map((e) {
      final id = (e as Map)['id'] as String? ?? '';
      return id.toLowerCase();
    }).where((id) => id.isNotEmpty).toSet();

    if (activeIds.isEmpty || mixIds.isEmpty) return false;
    return activeIds.length == mixIds.length && activeIds.containsAll(mixIds);
  }

  String _getLocalizedMixName(BuildContext context, String originalName) {
    final localizations = AppLocalizations.of(context)!;
    switch (originalName.toLowerCase()) {
      case 'głęboki sen':
      case 'deep sleep':
        return localizations.mix_deep_sleep;
      case 'leśna cisza':
      case 'forest silence':
        return localizations.mix_forest_silence;
      case 'wieczorne ognisko':
      case 'evening bonfire':
        return localizations.mix_evening_bonfire;
      case 'głęboka medytacja':
      case 'deep meditation':
        return localizations.mix_deep_meditation;
      case 'spokojne piano':
      case 'calm piano':
        return localizations.mix_calm_piano;
      case 'biały szum deszczu':
      case 'white noise rain':
      case 'white rain noise':
        return localizations.mix_white_rain_noise;
      case 'niebiański zen':
      case 'heavenly zen':
        return localizations.mix_heavenly_zen;
      case 'podróż pociągiem':
      case 'train journey':
        return localizations.mix_train_journey;
      default:
        return originalName;
    }
  }

  Widget _buildMixCard(Map<String, dynamic> mix, {required bool isFavorite, required int index}) {
    final name = _getLocalizedMixName(context, mix['name'] as String? ?? 'Miks');


    final isActive = _isMixActive(mix);
    final coverImage = _getCoverForMix(mix);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _playFavorite(mix),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background Cover Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/$coverImage',
                  fit: BoxFit.cover,
                ),
              ),
              
              // Dark Gradient Overlay for premium feel and text readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              
              // Card Content (Icons and Text)
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive ? Colors.amberAccent.withOpacity(0.8) : Colors.white.withOpacity(0.08),
                      width: isActive ? 2.0 : 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Upper row with status (only if active) and delete button (if favorite)
                      Row(
                        children: [
                          if (isActive)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amberAccent.withOpacity(0.25),
                              ),
                              child: const Icon(
                                Icons.volume_up_rounded,
                                color: Colors.amberAccent,
                                size: 18,
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          
                          const Spacer(),
                          
                          if (isFavorite)
                            GestureDetector(
                              onTap: () {
                                _deleteFavorite(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent.withOpacity(0.25),
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            )
                          else if (!isActive)
                            const SizedBox(height: 24) // Keep spacing consistent for non-deletable mixes
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                      
                      // Text information
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isActive ? Colors.amberAccent : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              color: Colors.black87,
                              offset: Offset(0, 1.5),
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAiPromoCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6B4EFF).withOpacity(0.15),
            const Color(0xFF00F2FE).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF6B4EFF).withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4EFF).withOpacity(0.12),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            context.findAncestorStateOfType<MainMenuNavigatorState>()?.selectPage(1);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6B4EFF).withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF00F2FE),
                    size: 20,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.aiAssistantTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppLocalizations.of(context)!.createWithAi,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 10,
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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    _storage.listenKey('favorites', (value) {
      if (mounted) {
        setState(() {
          _favorites = value ?? [];
        });
      }
    });

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
                  AppLocalizations.of(context)!.soundsTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                actions: [
                  IconButton(
                    key: TutorialService.tuneButtonKey,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MainTabBarController(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Ulubione Utwory Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 12.0),
              child: Text(
                AppLocalizations.of(context)!.favoriteMixes,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Ulubione Utwory Grid
          if (_favorites.isEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.favorite_border_rounded, size: 40, color: Colors.white.withOpacity(0.2)),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.noFavoriteMixes,
                      style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppLocalizations.of(context)!.useAiToCreateMix,
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6B4EFF),
                                Color(0xFF00F2FE),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6B4EFF).withOpacity(0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                context.findAncestorStateOfType<MainMenuNavigatorState>()?.selectPage(1);
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.auto_awesome,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!.createWithAi,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                              width: 1.2,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const MainTabBarController(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.tune_rounded,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!.mixSounds,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 1.25,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final bool isLimitReached = _favorites.length >= 6;
                    if (isLimitReached) {
                      final mix = _favorites[index] as Map<String, dynamic>;
                      return _buildMixCard(mix, isFavorite: true, index: index);
                    } else {
                      if (index == 0) {
                        return _buildAiPromoCard();
                      }
                      final mix = _favorites[index - 1] as Map<String, dynamic>;
                      return _buildMixCard(mix, isFavorite: true, index: index - 1);
                    }
                  },
                  childCount: _favorites.length >= 6 ? _favorites.length : _favorites.length + 1,
                ),
              ),
            ),

          // Gotowe Mixy Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0, bottom: 12.0),
              child: Text(
                AppLocalizations.of(context)!.readyMixes,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Gotowe Mixy Grid
          SliverPadding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 1.25,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final mix = _randomMixes[index];
                  return _buildMixCard(mix, isFavorite: false, index: index);
                },
                childCount: _randomMixes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
