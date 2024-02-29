import 'package:bloc/bloc.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:meta/meta.dart';
part 'media_control_cubit_state.dart';

class MediaControlCubit extends Cubit<MediaControlCubitState> {
  MediaControlCubit() : super(MediaControlCubitInitial());

  int get selectedCount => state.selectedSounds.length;

  void addSound(AudioClip sound) {
    final newSounds = List<AudioClip>.from(state.selectedSounds)..add(sound);
    emit(MediaControlCubitLoaded(selectedSounds: newSounds));
  }

  void removeSound(AudioClip sound) {
    final newSounds =
        state.selectedSounds.where((s) => s.id != sound.id).toList();
    emit(MediaControlCubitLoaded(selectedSounds: newSounds));
  }
}
