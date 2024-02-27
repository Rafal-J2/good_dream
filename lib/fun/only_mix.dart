import 'package:assets_audio_player/assets_audio_player.dart';
import '../sounds/water_sounds.dart';

bool isFav = false;

mix1() {
  waterSounds[0].player.open(Audio(waterSounds[0].audioFile!));
}

mix2() {
  waterSounds[1].player.open(Audio(waterSounds[1].audioFile!));
}

mix3() {
  waterSounds[2].player.open(Audio(waterSounds[2].audioFile!));
}
