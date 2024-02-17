import 'package:assets_audio_player/assets_audio_player.dart';
import 'arrays_1_2.dart';

bool isFav = false;

mix1() {
  arrays2[0].player!.open(Audio(arrays2[0].sounds!));
}

mix2() {
  arrays2[1].player!.open(Audio(arrays2[1].sounds!));
}

mix3() {
  arrays2[2].player!.open(Audio(arrays2[2].sounds!));
}
