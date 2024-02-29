import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/audio_clip.dart';
part 'nature_sounds_state.dart';

class NatureSoundsCubit extends Cubit<NatureSoundsState> {
  final List<AudioClip> _natureSounds;
  NatureSoundsCubit(this._natureSounds) : super(NatureSoundsInitial());

  void toggleSound(AudioClip clip) {
    var index = _natureSounds.indexWhere((c) => c.id == clip.id);
    if (index != -1) {
      _natureSounds[index].isControlActive =
          !_natureSounds[index].isControlActive;
      _natureSounds[index].isControlActive
          ? _natureSounds[index].player.open(
              Audio(_natureSounds[index].audioFile!),
              volume: 0.5,
               loopMode: LoopMode.single)
          : _natureSounds[index].player.pause();
    }
    emit(NatureSoundsLoaded(List.from(_natureSounds)));
  }
}
