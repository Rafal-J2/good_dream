import 'package:bloc/bloc.dart';
import '../../models/audio_clip.dart';
part 'nature_sounds_state.dart';

class NatureSoundsCubit extends Cubit<NatureSoundsState> {
  final List<AudioClip> _natureSounds;
  NatureSoundsCubit(this._natureSounds) : super(NatureSoundsInitial());

  void toggleSound(AudioClip clip) {
    var index = _natureSounds.indexWhere((c) => c == clip);
    if (index != -1) {
      _natureSounds[index].isControlActive =
          !_natureSounds[index].isControlActive;
    }
    emit(NatureSoundsLoaded(List.from(_natureSounds)));
  }
}
