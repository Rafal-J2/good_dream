import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:good_dream/models/sounds_catalog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      'name': 'Głęboki Sen',
      'sounds': [
        {'id': 'Rain', 'volume': 0.6},
        {'id': 'wind', 'volume': 0.3},
        {'id': 'cricket', 'volume': 0.4},
      ]
    },
    {
      'name': 'Leśna Cisza',
      'sounds': [
        {'id': 'forest', 'volume': 0.5},
        {'id': 'bird', 'volume': 0.4},
        {'id': 'Small creek', 'volume': 0.3},
      ]
    },
    {
      'name': 'Wieczorne Ognisko',
      'sounds': [
        {'id': 'bonfire', 'volume': 0.7},
        {'id': 'cricket', 'volume': 0.4},
        {'id': 'wind', 'volume': 0.3},
      ]
    },
    {
      'name': 'Głęboka Medytacja',
      'sounds': [
        {'id': 'Meditation', 'volume': 0.6},
        {'id': 'Binaural', 'volume': 0.4},
        {'id': 'Sea', 'volume': 0.3},
      ]
    },
    {
      'name': 'Spokojne Piano',
      'sounds': [
        {'id': 'Piano', 'volume': 0.6},
        {'id': 'cricket', 'volume': 0.3},
        {'id': 'Rain on windows', 'volume': 0.4},
      ]
    },
    {
      'name': 'Biały Szum Deszczu',
      'sounds': [
        {'id': 'Rain on car roof', 'volume': 0.7},
        {'id': 'thunder', 'volume': 0.3},
      ]
    },
    {
      'name': 'Niebiański Zen',
      'sounds': [
        {'id': 'Zen', 'volume': 0.6},
        {'id': 'Flute', 'volume': 0.5},
        {'id': 'River', 'volume': 0.3},
      ]
    },
    {
      'name': 'Podróż Pociągiem',
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

  Widget _buildMixCard(Map<String, dynamic> mix, {required bool isFavorite, required int index}) {
    final name = mix['name'] as String? ?? 'Miks';
    final sounds = mix['sounds'] as List<dynamic>? ?? [];
    
    final soundNames = sounds.map((s) {
      final id = (s as Map)['id'] as String? ?? '';
      final clip = _findClipById(id);
      return clip?.getLocalizedName(context) ?? id;
    }).join(' • ');

    final isActive = _isMixActive(mix);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _playFavorite(mix),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: isActive ? Colors.amberAccent.withOpacity(0.08) : Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? Colors.amberAccent.withOpacity(0.5) : Colors.white.withOpacity(0.06),
                  width: 1.2,
                ),
                boxShadow: [
                  if (isActive)
                    BoxShadow(
                      color: Colors.amberAccent.withOpacity(0.03),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Upper row with status and delete button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? Colors.amberAccent.withOpacity(0.18) : Colors.white.withOpacity(0.05),
                        ),
                        child: Icon(
                          isActive ? Icons.volume_up_rounded : Icons.spatial_audio_rounded,
                          color: isActive ? Colors.amberAccent : Colors.white70,
                          size: 20,
                        ),
                      ),
                      
                      if (isFavorite)
                        GestureDetector(
                          onTap: () {
                            _deleteFavorite(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.redAccent.withOpacity(0.08),
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.redAccent.withOpacity(0.9),
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Text information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isActive ? Colors.amberAccent : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          soundNames,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(isActive ? 0.7 : 0.45),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                title: const Text(
                  'Dźwięki',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Header Banner (Wysoce zoptymalizowany WebP - tylko 7 KB!)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1.2,
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/sounds_banner.webp',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                              const Color(0xFF070514).withOpacity(0.9),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Odkryj Spokój',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 1.5),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Zanurz się w gotowych kompozycjach lub poproś Asystenta AI o coś wyjątkowego.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 12,
                                height: 1.4,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Ulubione Utwory Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
              child: Text(
                'Ulubione utwory',
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
                      'Brak ulubionych miksów',
                      style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Użyj Asystenta AI, aby stworzyć i zapisać idealny miks.',
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                      textAlign: TextAlign.center,
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
                    final mix = _favorites[index] as Map<String, dynamic>;
                    return _buildMixCard(mix, isFavorite: true, index: index);
                  },
                  childCount: _favorites.length,
                ),
              ),
            ),

          // Losowe Mixy Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0, bottom: 12.0),
              child: Text(
                'Losowe mixy',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Losowe Mixy Grid
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
