import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import '../../main.dart';
import '../../utils/toast_notifications.dart';
part 'media_control_cubit_state.dart';

class MediaControlCubit extends Cubit<MediaControlCubitState> {
  final AudioHandler audioHandler;
  final Map<String, List<AudioClip>> soundsByCategory;
  MediaControlCubit(this.soundsByCategory, this.audioHandler) : super(MediaControlCubitInitial());

  int get selectedCount => state.selectedSounds.length;

  void _updateAndEmitSoundList(List<AudioClip> updatedSounds) {
    emit(MediaControlCubitLoaded(selectedSounds: updatedSounds));
  }


  void addSound(AudioClip sound) {
    final newSounds = List<AudioClip>.from(state.selectedSounds)..add(sound);
    _updateAndEmitSoundList(newSounds);
  }

  void removeSound(AudioClip sound) {
    final newSounds =
        state.selectedSounds.where((index) => index.id != sound.id).toList();
    _updateAndEmitSoundList(newSounds);
  }

  void setVolume(String soundId, double volume) {
    var soundIndex =
        state.selectedSounds.indexWhere((index) => index.id == soundId);

    if (soundIndex != -1) {
      var updatedNatureSounds = List<AudioClip>.from(state.selectedSounds);
      var sound = updatedNatureSounds[soundIndex];
      sound.player.setVolume(volume);
      _updateAndEmitSoundList(updatedNatureSounds);
    }
  }

 
  void toggleSound(String category, AudioClip sound) {
    sound.isControlActive = !sound.isControlActive;
    final List<AudioClip> updatedSounds = List<AudioClip>.from(state.selectedSounds);
    if (sound.isControlActive) {
      if (selectedCount < 6) {
        updatedSounds.add(sound);
        bool isFirstSound = selectedCount == 0;
        sound.player.setAsset(sound.audioFile!).then((_) {
          sound.player.play(); 
          sound.player.setVolume(0.5);
          sound.player.setLoopMode(LoopMode.one);
          if (isFirstSound) {
            audioHandler.play(); 
          }
          _updateAndEmitSoundList(updatedSounds);
        }).catchError((error) {
          logger.i('Error setting asset or playing sound: $error');
        });
      } else {
        sound.isControlActive = !sound.isControlActive;
        notifyMaxSoundsReached();
        return;
      }
    } else {
      updatedSounds.removeWhere((s) => s.id == sound.id);
      _updateAndEmitSoundList(updatedSounds);
      if (updatedSounds.isEmpty) {
        audioHandler.stop();
      }
      sound.player.pause(); 
    }
  }
  MediaItem mediaItemFromSound(AudioClip sound) {
    return MediaItem(
      id: sound.id!,
      album: "Sample Album",
      title: sound.iconTitleText!,
      artist: "Sample Artist",
      artUri: Uri.parse("https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
    );
  }
}
