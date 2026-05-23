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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    // We listen to the storage events so we can update automatically if a new favorite is added elsewhere
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
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Ulubione Miksy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      '${_favorites.length} / 6 zapisanych',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 64, color: Colors.white.withOpacity(0.2)),
                  const SizedBox(height: 16),
                  Text(
                    'Brak ulubionych miksów',
                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Użyj Asystenta AI, aby stworzyć i zapisać idealny miks.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final mix = _favorites[index] as Map<String, dynamic>;
                final name = mix['name'] as String? ?? 'Miks';
                final sounds = mix['sounds'] as List<dynamic>? ?? [];
                
                final soundNames = sounds.map((s) {
                  final id = (s as Map)['id'] as String? ?? '';
                  final clip = _findClipById(id);
                  return clip?.getLocalizedName(context) ?? id;
                }).join(' • ');

                final isActive = _isMixActive(mix);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => _playFavorite(mix),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: isActive ? Colors.amberAccent.withOpacity(0.12) : Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isActive ? Colors.amberAccent.withOpacity(0.5) : Colors.amberAccent.withOpacity(0.15),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amberAccent.withOpacity(0.02),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive ? Colors.amberAccent.withOpacity(0.2) : Colors.amberAccent.withOpacity(0.1),
                                  ),
                                  child: Icon(
                                    isActive ? Icons.graphic_eq_rounded : Icons.spatial_audio_rounded,
                                    color: Colors.amberAccent,
                                    size: 28,
                                  ),
                                ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    soundNames,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.delete_outline_rounded, color: Colors.redAccent.withOpacity(0.7), size: 26),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => _deleteFavorite(index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
