import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:meta/meta.dart';
import '../../services/foreground_service.dart';
import '../../utils/toast_notifications.dart';
part 'media_control_cubit_state.dart';

class MediaControlCubit extends Cubit<MediaControlCubitState> {
  final Map<String, List<AudioClip>> soundsByCategory;
  MediaControlCubit(this.soundsByCategory) : super(MediaControlCubitInitial());

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
    } else {
      sound.isControlActive = !sound.isControlActive;
      notifyMaxSoundsReached();
      return;
    }
  } else {
    updatedSounds.removeWhere((s) => s.id == sound.id);
  }

  _updateAndEmitSoundList(updatedSounds);

  if (sound.isControlActive) {
    sound.player.open(Audio(sound.audioFile!), volume: 0.5, loopMode: LoopMode.single);
  } else {
    sound.player.pause();
  }

  if (updatedSounds.isEmpty) {
    stopForegroundService();
  } else if (updatedSounds.length == 1) {
    startForegroundService();
  }
}
}
