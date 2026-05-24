import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/models/active_sound.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import '../../main.dart';
import '../../utils/toast_notifications.dart';
part 'media_control_cubit_state.dart';

class MediaControlCubit extends Cubit<MediaControlCubitState> {
  final AudioHandler audioHandler;
  final Map<String, List<AudioClip>> soundsByCategory;
  static const int maxActiveSounds = 6;
  StreamSubscription<PlaybackState>? _playbackStateSubscription;

  static const Map<String, double> defaultSoundVolumes = {
    // Nature
    'woodpecker': 0.9,
    'frog': 0.55,
    'strok': 0.9,
    'city_park': 0.35,
    'fireplace': 0.9,
    'bonfire': 0.75,
    'bird': 0.9,
    'thunder': 0.9,
    'cricket': 0.80,
    'forest': 0.36,
    'wind': 0.9,
    'jungle': 0.9,

    // Water
    'river': 0.35,
    'small creek': 0.9,
    'rain': 0.40,
    'rain on car roof': 0.75,
    'rain on car windows': 0.9,
    'fountain in park': 0.55,
    'rain under raincoat': 0.9,
    'rain on windows': 0.70,
    'sea': 0.40,
    'cave': 0.9,
    'waterfall': 0.30,
    'jacuzzi': 0.80,

    // Mechanical
    'plane': 0.9,
    'train': 0.9,
    'car driving': 0.9,
    'bus': 0.55,
    'washing machine': 0.9,
    'air conditioner': 0.9,
    'vacuum cleaner': 0.45,
    'hair dryer': 0.45,
    'keyboard': 0.9,
  };

  MediaControlCubit(this.soundsByCategory, this.audioHandler)
      : super(MediaControlCubitInitial()) {
    // Listen to playbackState transitions to detect system "stop" commands
    _playbackStateSubscription = audioHandler.playbackState.listen((playbackState) {
      if (!playbackState.playing && state.activeSounds.isNotEmpty) {
        disableAllSoundsAndIcons();
      }
    });
  }

  int get selectedCount => state.activeSounds.length;

  /// Check if a sound with the given [soundId] is currently active.
  bool isSoundActive(String soundId) {
    return state.activeSounds.any((s) => s.clip.id == soundId);
  }

  /// Toggle a sound on or off.
  Future<void> toggleSound(String category, AudioClip clip, {String? maxSoundsMessage}) async {
    if (isSoundActive(clip.id)) {
      await _deactivateSound(clip.id);
    } else {
      // If the user selects a music sound, disable any already playing music sound (max 1 music track).
      if (category == 'musicSounds') {
        final musicClips = soundsByCategory['musicSounds'] ?? [];
        for (final active in state.activeSounds.toList()) {
          if (musicClips.any((c) => c.id == active.clip.id)) {
            await _deactivateSound(active.clip.id);
          }
        }
      }
      await _activateSound(clip, maxSoundsMessage: maxSoundsMessage);
    }
  }

  Future<void> _activateSound(AudioClip clip, {String? maxSoundsMessage}) async {
    if (selectedCount >= maxActiveSounds) {
      notifyMaxSoundsReached(maxSoundsMessage);
      return;
    }

    final player = AudioPlayer();
    try {
      await player.setAsset(clip.audioFile);
      
      final defaultVolume = defaultSoundVolumes[clip.id.toLowerCase().trim()] ?? 0.9;
      
      await player.setVolume(defaultVolume);
      await player.setLoopMode(LoopMode.one);
      player.play();

      final newActive = ActiveSound(clip: clip, player: player, volume: defaultVolume);
      final updated = List<ActiveSound>.from(state.activeSounds)..add(newActive);

      if (updated.length == 1) {
        audioHandler.play();
      }
      emit(MediaControlCubitLoaded(activeSounds: updated));
    } catch (error) {
      logger.e('Error playing sound: ${clip.id}, Error: $error');
      await player.dispose();
    }
  }

  Future<void> _deactivateSound(String soundId) async {
    final updated = List<ActiveSound>.from(state.activeSounds);
    final index = updated.indexWhere((s) => s.clip.id == soundId);
    if (index == -1) return;

    final removed = updated.removeAt(index);
    
    // Emit the new state immediately so the UI updates and feels ultra-responsive
    emit(MediaControlCubitLoaded(activeSounds: updated));

    if (updated.isEmpty) {
      await audioHandler.stop();
    }

    // Gentle fade out in the background
    _fadeOutAndDispose(removed.player, removed.volume);
  }

  /// Fades out the player's volume from [startVolume] to 0 over 1 second, then stops and disposes it.
  Future<void> _fadeOutAndDispose(AudioPlayer player, double startVolume) async {
    try {
      const duration = Duration(milliseconds: 1000); // 1 second fade-out is perfect (gentle yet responsive)
      const steps = 10;
      final stepDuration = duration ~/ steps;

      for (int i = 0; i < steps; i++) {
        // Calculate the next volume level
        final currentVolume = startVolume * (1 - (i + 1) / steps);
        await player.setVolume(currentVolume.clamp(0.0, 1.0));
        await Future.delayed(stepDuration);
      }
    } catch (error) {
      logger.e('Error during fade out: $error');
    } finally {
      try {
        await player.stop();
        await player.dispose();
      } catch (error) {
        logger.e('Error disposing player after fade out: $error');
      }
    }
  }

  /// Remove a sound by its clip reference.
  Future<void> removeSound(AudioClip clip) async {
    await _deactivateSound(clip.id);
  }

  /// Set the volume for a specific active sound.
  void setVolume(String soundId, double volume) {
    final updated = List<ActiveSound>.from(state.activeSounds);
    final index = updated.indexWhere((s) => s.clip.id == soundId);
    if (index == -1) {
      logger.e('Sound not found for $soundId');
      return;
    }

    updated[index].player.setVolume(volume);
    updated[index] = updated[index].copyWith(volume: volume);
    emit(MediaControlCubitLoaded(activeSounds: updated));
  }

  /// Stop and dispose all active sounds with a gentle fade-out in the background.
  Future<void> disableAllSoundsAndIcons() async {
    final soundsToStop = List<ActiveSound>.from(state.activeSounds);
    if (soundsToStop.isEmpty) return;

    // Emit empty state immediately to update the UI and prevent recursive calls from the playbackState listener
    emit(MediaControlCubitLoaded(activeSounds: const []));

    // Gentle fade out and dispose for all players concurrently in the background
    for (final active in soundsToStop) {
      _fadeOutAndDispose(active.player, active.volume);
    }

    await audioHandler.stop();
  }

  /// Stop existing sounds and play the recommended set of sounds.
  Future<void> playSoundMix(List<AudioClip> clips) async {
    await disableAllSoundsAndIcons();
    for (final clip in clips.take(maxActiveSounds)) {
      await _activateSound(clip);
    }
  }

  /// Stop existing sounds and play the recommended set of sounds at precise custom volume levels.
  Future<void> playSoundMixWithVolumes(List<MapEntry<AudioClip, double>> clipsWithVolumes) async {
    await disableAllSoundsAndIcons();
    for (final entry in clipsWithVolumes.take(maxActiveSounds)) {
      final clip = entry.key;
      final volume = entry.value;

      final player = AudioPlayer();
      try {
        await player.setAsset(clip.audioFile);
        await player.setVolume(volume);
        await player.setLoopMode(LoopMode.one);
        player.play();

        final newActive = ActiveSound(clip: clip, player: player, volume: volume);
        final updated = List<ActiveSound>.from(state.activeSounds)..add(newActive);

        if (updated.length == 1) {
          audioHandler.play();
        }
        emit(MediaControlCubitLoaded(activeSounds: updated));
      } catch (error) {
        logger.e('Error playing sound: ${clip.id}, Error: $error');
        await player.dispose();
      }
    }
  }

  @override
  Future<void> close() async {
    await _playbackStateSubscription?.cancel();
    for (final active in state.activeSounds) {
      await active.player.stop();
      await active.player.dispose();
    }
    return super.close();
  }
}
