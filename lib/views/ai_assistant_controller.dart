import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:good_dream/models/sounds_catalog.dart';
import 'package:good_dream/services/ai_assistant_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/services/analytics_service.dart';

class AIAssistantController extends StatefulWidget {
  const AIAssistantController({super.key});

  @override
  State<AIAssistantController> createState() => _AIAssistantControllerState();
}

class _AIAssistantControllerState extends State<AIAssistantController>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final AIAssistantService _aiService = AIAssistantService();

  bool _isLoading = false;
  List<Map<String, dynamic>> _recommendedSounds = [];
  List<String> _proposedNames = [];
  String? _errorMessage;

  // Feedback state
  int _retryCount = 0;
  String? _currentMoodQuery;
  List<String> _rejectedMixes = [];
  bool _accepted = false;
  bool _wantsToSave = false;
  bool _hasSaved = false;
  bool _hasPlayedMix = false;

  String _selectedCover = 'default_cover.webp';

  final List<String> _allCovers = [
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

  String _getCoverForMix(List<Map<String, dynamic>> sounds) {
    final soundIds = sounds.map((s) {
      final id = s['id'] as String? ?? '';
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

  late final AnimationController _pulseController;

  List<Map<String, dynamic>> _getCategories(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return [
      {
        'title': localizations.categoryStress,
        'icon': Icons.spa_rounded,
        'color': Colors.tealAccent,
        'items': [
          {'label': localizations.itemStressDay, 'emoji': '💼'},
          {'label': localizations.itemRacingThoughts, 'emoji': '🤯'},
          {'label': localizations.itemAnxiety, 'emoji': '😔'},
        ],
      },
      {
        'title': localizations.categorySleep,
        'icon': Icons.bedtime_rounded,
        'color': Colors.amberAccent,
        'items': [
          {'label': localizations.itemTroubleSleeping, 'emoji': '🛌'},
          {'label': localizations.itemNightAwakening, 'emoji': '🕰️'},
          {'label': localizations.itemPowerNap, 'emoji': '🔋'},
        ],
      },
      {
        'title': localizations.categoryNature,
        'icon': Icons.terrain_rounded,
        'color': Colors.lightGreenAccent,
        'items': [
          {'label': localizations.itemDeepMeditation, 'emoji': '✨'},
          {'label': localizations.itemFocusCalm, 'emoji': '📚'},
          {'label': localizations.itemQuietForest, 'emoji': '🌲'},
        ],
      },
      {
        'title': localizations.categoryKids,
        'icon': Icons.child_care_rounded,
        'color': Colors.pinkAccent,
        'items': [
          {'label': localizations.itemBabySleep, 'emoji': '🍼'},
          {'label': localizations.itemCalmKids, 'emoji': '🧸'},
        ],
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  /// Helper to lookup AudioClip from sounds catalog by matching its ID (case-insensitive)
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

  Future<void> _generateSession(String query, {bool isRetry = false}) async {
    setState(() {
      if (!isRetry) {
        _retryCount = 0;
        _currentMoodQuery = query;
        _rejectedMixes = [];
        AnalyticsService.logEvent(
          name: 'ai_composer_started',
          parameters: {'selected_goal': query},
        );
      }
      _accepted = false;
      _wantsToSave = false;
      _hasSaved = false;
      _hasPlayedMix = false;
      _isLoading = true;
      _errorMessage = null;
      _recommendedSounds = [];
    });

    _pulseController.repeat(reverse: true);

    final result = await _aiService.generateSleepSession(query, rejectedSounds: _rejectedMixes);

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (result['success'] == true) {
          final rawSounds = result['recommendedSounds'] as List<dynamic>? ?? [];
          final rawNames = result['proposedNames'] as List<dynamic>? ?? [];
          _proposedNames = rawNames.map((e) => e.toString()).toList();
          if (_proposedNames.isEmpty) {
            _proposedNames = ['Spokojny Sen', 'Nocny Relaks', 'Głęboki Oddech'];
          }
          
          _recommendedSounds = rawSounds.map((item) {
            if (item is Map) {
              return Map<String, dynamic>.from(item);
            } else if (item is String) {
              return {'id': item, 'volume': 0.9};
            }
            return <String, dynamic>{};
          }).where((m) => m.isNotEmpty).toList();

          AnalyticsService.logEvent(
            name: 'ai_composer_success',
            parameters: {
              'selected_goal': query,
              'sounds_suggested': _recommendedSounds.map((s) => s['id'] as String).toList().join(','),
            },
          );

          final storage = GetStorage();
          final List favs = storage.read<List>('favorites') ?? [];
          final usedCovers = favs.map((f) => f['image'] as String?).where((img) => img != null).toSet();

          String recommendedCover = _getCoverForMix(_recommendedSounds);
          final List<String> availableCovers = _allCovers.where((cover) => !usedCovers.contains(cover)).toList();
          if (availableCovers.isEmpty) {
            availableCovers.addAll(_allCovers);
          }

          if (usedCovers.contains(recommendedCover) || !availableCovers.contains(recommendedCover)) {
            _selectedCover = availableCovers.first;
          } else {
            _selectedCover = recommendedCover;
          }

          // Play immediately on successful generation
          final List<MapEntry<AudioClip, double>> clipsToPlay = [];
          for (final s in _recommendedSounds) {
            final id = s['id'] as String? ?? '';
            final volume = MediaControlCubit.defaultSoundVolumes[id.toLowerCase().trim()] ?? 0.9;
            final clip = _findClipById(id);
            if (clip != null) {
              clipsToPlay.add(MapEntry(clip, volume));
            }
          }

          if (clipsToPlay.isNotEmpty) {
            _hasPlayedMix = true;
            Future.microtask(() {
              if (mounted) {
                context.read<MediaControlCubit>().playSoundMixWithVolumes(clipsToPlay);
              }
            });
          }
        } else {
          _errorMessage = result['error'] ?? 'Wystąpił nieoczekiwany błąd.';
          _pulseController.stop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Premium Glassmorphic Header
            _buildAppBar(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!_isLoading && _recommendedSounds.isEmpty && _errorMessage == null)
                        _buildIntroView(),
                      if (_isLoading)
                        _buildLoadingView(),
                      if (_errorMessage != null)
                        _buildErrorView(),
                      if (_recommendedSounds.isNotEmpty && !_isLoading)
                        _buildSuccessView(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.06),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Colors.amberAccent,
            size: 26,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.aiAssistantTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.aiAssistantSub,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildIntroView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        // Beautiful illustration or icon
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.03),
              border: Border.all(
                color: Colors.amberAccent.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.spa_rounded,
              size: 56,
              color: Colors.tealAccent,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          AppLocalizations.of(context)!.chooseGoal,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.aiAssistantIntro,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.65),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 28),

        // Beautiful keyboard-less category sections
        ..._getCategories(context).map((cat) {
          final String title = cat['title'] as String;
          final IconData icon = cat['icon'] as IconData;
          final Color accentColor = cat['color'] as Color;
          final List<Map<String, String>> items = List<Map<String, String>>.from(cat['items']);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 12.0, top: 16.0),
                child: Row(
                  children: [
                    Icon(icon, color: accentColor.withOpacity(0.9), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: items.map((item) {
                  final label = item['label']!;
                  final emoji = item['emoji']!;
                  return InkWell(
                    onTap: () => _generateSession(label),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.07),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 10),
                          Text(
                            label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLoadingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        
        // Premium Interactive Breathing Circle
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final double value = _pulseController.value;
            final bool isInhale = _pulseController.status == AnimationStatus.forward;
            final String breatheText = isInhale 
                ? (AppLocalizations.of(context)!.inhale) 
                : (AppLocalizations.of(context)!.exhale);

            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Faint Glowing Aura
                    Container(
                      width: 170 + (value * 45),
                      height: 170 + (value * 45),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6B4EFF).withOpacity(0.04 * (1.0 - value + 0.2)),
                        border: Border.all(
                          color: const Color(0xFF00F2FE).withOpacity(0.12 * value),
                          width: 1.5,
                        ),
                      ),
                    ),
                    
                    // Middle Pulsing Ring
                    Container(
                      width: 140 + (value * 30),
                      height: 140 + (value * 30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6B4EFF).withOpacity(0.08 * (1.0 - value * 0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6B4EFF).withOpacity(0.2 * value),
                            blurRadius: 20 + (value * 10),
                            spreadRadius: value * 2,
                          ),
                        ],
                      ),
                    ),
                    
                    // Core Interactive Gradient Circle
                    Container(
                      width: 110 + (value * 15),
                      height: 110 + (value * 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6B4EFF),
                            Color(0xFF00F2FE),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00F2FE).withOpacity(0.3 * value),
                            blurRadius: 15,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          breatheText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black38,
                                offset: Offset(0, 1.5),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 50),
                
                // Pulsing title
                Opacity(
                  opacity: 0.6 + (value * 0.4),
                  child: Text(
                    AppLocalizations.of(context)!.loadingTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            AppLocalizations.of(context)!.loadingDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildErrorView() {
    return Column(
      children: [
        const SizedBox(height: 30),
        _buildGlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.redAccent,
                size: 60,
              ),
              const SizedBox(height: 18),
              Text(
                AppLocalizations.of(context)!.connectionFailed,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage ?? 'Wystąpił nieznany błąd podczas łączenia z serwerem.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.tryAgain),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    final cubit = context.watch<MediaControlCubit>();

    final storage = GetStorage();
    final List favs = storage.read<List>('favorites') ?? [];
    final usedCovers = favs.map((f) => f['image'] as String?).where((img) => img != null).toSet();

    final List<String> availableCovers = _allCovers.where((cover) => !usedCovers.contains(cover)).toList();
    if (availableCovers.isEmpty) {
      availableCovers.addAll(_allCovers);
    }

    // Parse recommended sounds with their customized volumes
    final List<MapEntry<AudioClip, double>> recommendedClipsWithVolumes = [];
    for (final item in _recommendedSounds) {
      final id = item['id'] as String? ?? '';
      final volume = MediaControlCubit.defaultSoundVolumes[id.toLowerCase().trim()] ?? 0.9;
      final clip = _findClipById(id);
      if (clip != null) {
        recommendedClipsWithVolumes.add(MapEntry(clip, volume));
      }
    }

    // Check if the recommended mix is fully active
    final bool isMixActive = recommendedClipsWithVolumes.isNotEmpty &&
        recommendedClipsWithVolumes.every((entry) => cubit.isSoundActive(entry.key.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _recommendedSounds = [];
                });
                _pulseController.stop();
              },
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white70, size: 20),
              label: Text(
                AppLocalizations.of(context)!.backToGoals,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            const Icon(
              Icons.auto_awesome,
              color: Colors.amberAccent,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 10),



        // Ambient sound mix recommendation card
        _buildGlassCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(Icons.spatial_audio_rounded, color: Colors.amberAccent, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.aiMixTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.aiMixSub,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 18),

              // Visual pills of recommended sounds with their precise volume levels
              if (recommendedClipsWithVolumes.isEmpty)
                Text(
                  AppLocalizations.of(context)!.noSoundMatch,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
                )
              else
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: recommendedClipsWithVolumes.map((entry) {
                    final clip = entry.key;
                    final isActive = cubit.isSoundActive(clip.id);
                    
                    int volumePercentage = (entry.value * 100).toInt();
                    if (isActive) {
                      final activeSound = cubit.state.activeSounds.firstWhere((s) => s.clip.id == clip.id);
                      volumePercentage = (activeSound.volume * 100).toInt();
                    }
                    
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.orangeAccent.withOpacity(0.18)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive
                              ? Colors.orangeAccent
                              : Colors.white.withOpacity(0.1),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(clip.enableIcon, height: 22, width: 22),
                          const SizedBox(width: 8),
                          Text(
                            '${clip.getLocalizedName(context)} ($volumePercentage%)',
                            style: TextStyle(
                              color: isActive ? Colors.orangeAccent.shade100 : Colors.white,
                              fontSize: 13,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 24),

              // Action Mix play button
              if (recommendedClipsWithVolumes.isNotEmpty)
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isMixActive
                            ? [
                                BoxShadow(
                                  color: Colors.orangeAccent.withOpacity(0.25),
                                  blurRadius: 12 + (_pulseController.value * 8),
                                  spreadRadius: 2,
                                )
                              ]
                            : [
                                BoxShadow(
                                  color: const Color(0xFF6B4EFF).withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                )
                              ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isMixActive) {
                            await cubit.disableAllSoundsAndIcons();
                          } else {
                            setState(() {
                              _hasPlayedMix = true;
                            });
                            await cubit.playSoundMixWithVolumes(recommendedClipsWithVolumes);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isMixActive
                              ? Colors.orangeAccent.shade700
                              : const Color(0xFF6B4EFF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isMixActive ? Icons.stop_rounded : Icons.play_arrow_rounded,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isMixActive
                                  ? AppLocalizations.of(context)!.stopAiMix
                                  : AppLocalizations.of(context)!.playAiMix,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
              // Feedback Loop Section
              AnimatedSize(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
                child: (recommendedClipsWithVolumes.isNotEmpty && _hasPlayedMix)
                    ? Column(
                        children: [
                          const SizedBox(height: 24),
                          const Divider(color: Colors.white12),
                          const SizedBox(height: 16),
                          
                          if (!_accepted)
                            ...[
                              Text(
                                AppLocalizations.of(context)!.aiMixFeedbackQuestion,
                                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        AnalyticsService.logEvent(
                                          name: 'ai_composer_feedback',
                                          parameters: {
                                            'selected_goal': _currentMoodQuery ?? '',
                                            'user_liked': 0,
                                            'retry_count': _retryCount,
                                          },
                                        );
                                        if (_retryCount >= 3) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                AppLocalizations.of(context)!.tryAgain,
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
                                        final cubit = context.read<MediaControlCubit>();
                                        await cubit.disableAllSoundsAndIcons();
                                        
                                        final rejectedIds = recommendedClipsWithVolumes.map((e) => e.key.id).toList();
                                        _rejectedMixes.addAll(rejectedIds);
                                        _retryCount++;
                                        
                                        if (_currentMoodQuery != null) {
                                          await _generateSession(_currentMoodQuery!, isRetry: true);
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white70,
                                        side: const BorderSide(color: Colors.white24),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: Text(
                                        '❌ ${AppLocalizations.of(context)!.aiMixFeedbackNo}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        AnalyticsService.logEvent(
                                          name: 'ai_composer_feedback',
                                          parameters: {
                                            'selected_goal': _currentMoodQuery ?? '',
                                            'user_liked': 1,
                                          },
                                        );
                                        setState(() {
                                          _accepted = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.tealAccent.withOpacity(0.2),
                                        foregroundColor: Colors.tealAccent,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: Text(
                                        '✅ ${AppLocalizations.of(context)!.aiMixFeedbackYes}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          else if (!_wantsToSave && !_hasSaved)
                            ...[
                              Text(
                                AppLocalizations.of(context)!.aiMixSaveQuestion,
                                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          _hasSaved = true; // Skip saving
                                        });
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white70,
                                        side: const BorderSide(color: Colors.white24),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.aiMixSaveNo,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final storage = GetStorage();
                                        List favs = storage.read<List>('favorites') ?? [];
                                        if (favs.length >= 6) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                AppLocalizations.of(context)!.aiMixSaveLimit,
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                              backgroundColor: const Color(0xFF1E1242),
                                              behavior: SnackBarBehavior.floating,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                              ),
                                            ),
                                          );
                                          setState(() => _hasSaved = true);
                                          return;
                                        }
                                        setState(() {
                                          _wantsToSave = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amberAccent.withOpacity(0.2),
                                        foregroundColor: Colors.amberAccent,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.aiMixSaveYes,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          else if (_wantsToSave && !_hasSaved)
                            ...[
                              // Visual Cover Selection Section
                              Text(
                                AppLocalizations.of(context)!.aiMixCoverChoice,
                                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 12),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: (() {
                                      final storage = GetStorage();
                                      final List favs = storage.read<List>('favorites') ?? [];
                                      final usedCovers = favs.map((f) => f['image']).toSet();
                                      final availableCovers = _allCovers.where((c) => !usedCovers.contains(c)).toList();
                                      if (availableCovers.isEmpty) return _allCovers.map((cover) => cover).toList();
                                      return availableCovers;
                                    })().map((cover) {
                                      final isSelected = _selectedCover == cover;
                                      final aiRecommendedCover = _getCoverForMix(_recommendedSounds);
                                      final isAiRecommended = cover == aiRecommendedCover;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedCover = cover;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 250),
                                          margin: const EdgeInsets.symmetric(horizontal: 6),
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: isSelected 
                                                  ? const Color(0xFF00F2FE) 
                                                  : Colors.white.withOpacity(0.08),
                                              width: isSelected ? 2.5 : 1.2,
                                            ),
                                            boxShadow: isSelected 
                                                ? [
                                                    BoxShadow(
                                                      color: const Color(0xFF00F2FE).withOpacity(0.35),
                                                      blurRadius: 8,
                                                      spreadRadius: 1,
                                                    )
                                                  ]
                                                : [],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(14),
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
                                                    top: 4,
                                                    right: 4,
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: Colors.amberAccent.withOpacity(0.85),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      child: const Text(
                                                        'AI',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 9,
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
                              ),
                              const SizedBox(height: 20),

                              // Name Selection Section
                              Text(
                                AppLocalizations.of(context)!.aiMixNameChoice,
                                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                alignment: WrapAlignment.center,
                                children: _proposedNames.map((name) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      final storage = GetStorage();
                                      List favs = storage.read<List>('favorites') ?? [];
                                      final mixData = {
                                        'name': name,
                                        'image': _selectedCover,
                                        'sounds': recommendedClipsWithVolumes.map((e) {
                                          final isActive = cubit.isSoundActive(e.key.id);
                                          double currentVolume = e.value;
                                          if (isActive) {
                                            final activeSound = cubit.state.activeSounds.firstWhere((s) => s.clip.id == e.key.id);
                                            currentVolume = activeSound.volume;
                                          }
                                          return {
                                            'id': e.key.id,
                                            'volume': currentVolume
                                          };
                                        }).toList(),
                                      };
                                      favs.add(mixData);
                                      storage.write('favorites', favs);
                                      AnalyticsService.logEvent(
                                        name: 'ai_composer_mix_saved',
                                        parameters: {
                                          'selected_goal': _currentMoodQuery ?? '',
                                          'mix_name': name,
                                        },
                                      );
                                      
                                      setState(() {
                                        _hasSaved = true;
                                      });
                                      
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            AppLocalizations.of(context)!.aiMixSavedSuccess(name),
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white.withOpacity(0.08),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    child: Text(name),
                                  );
                                }).toList(),
                              ),
                            ]
                          else if (_hasSaved)
                            ...[
                              const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 36),
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!.approve,
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                            ]
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
