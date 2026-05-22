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
      await player.setVolume(0.5);
      await player.setLoopMode(LoopMode.one);
      player.play();

      final newActive = ActiveSound(clip: clip, player: player);
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
    await removed.player.stop();
    await removed.player.dispose();

    if (updated.isEmpty) {
      await audioHandler.stop();
    }
    emit(MediaControlCubitLoaded(activeSounds: updated));
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

  /// Stop and dispose all active sounds.
  Future<void> disableAllSoundsAndIcons() async {
    final soundsToStop = List<ActiveSound>.from(state.activeSounds);
    if (soundsToStop.isEmpty) return;

    // Emit empty state immediately to update the UI and prevent recursive calls from the playbackState listener
    emit(MediaControlCubitLoaded(activeSounds: const []));

    final stopFutures = <Future<void>>[];
    for (final active in soundsToStop) {
      stopFutures.add(active.player.stop());
    }
    await Future.wait(stopFutures);

    final disposeFutures = <Future<void>>[];
    for (final active in soundsToStop) {
      disposeFutures.add(active.player.dispose());
    }
    await Future.wait(disposeFutures);

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
