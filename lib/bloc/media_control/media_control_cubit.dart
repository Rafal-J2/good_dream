import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:meta/meta.dart';
import '../../services/foreground_service.dart';
import '../../utils/toast_notifications.dart';
part 'media_control_cubit_state.dart';

class MediaControlCubit extends Cubit<MediaControlCubitState> {
  MediaControlCubit() : super(MediaControlCubitInitial());

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

  void toggleSound(AudioClip sound) {
    if (selectedCount < 6) {
      sound.isControlActive = !sound.isControlActive;

      final List<AudioClip> updatedSounds =
          List<AudioClip>.from(state.selectedSounds);
      if (sound.isControlActive) {
        updatedSounds.add(sound);
      } else {
        updatedSounds.removeWhere((s) => s.id == sound.id);
      }
      _updateAndEmitSoundList(updatedSounds);

      sound.isControlActive
          ? sound.player.open(Audio(sound.audioFile!),
              volume: 0.5, loopMode: LoopMode.single)
          : sound.player.pause();

      if (updatedSounds.isEmpty) {
        stopForegroundService();
      } else if (updatedSounds.length == 1) {
        startForegroundService();
      }
    } else if (selectedCount >= 6 && !sound.isControlActive) {
      notifyMaxSoundsReached();
    }
  }
}
