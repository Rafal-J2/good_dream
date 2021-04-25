
import 'package:assets_audio_player/assets_audio_player.dart';
import 'arrays.dart';

bool isFav = false;

mix1() {
  arrays[0].player.open(
      Audio(
          arrays[0].sounds
      )
  );


}

mix2() {
  arrays[1].player.open(
      Audio(
          arrays[1].sounds
      )
  );
}

mix3() {
  arrays[2].player.open(
      Audio(
          arrays[2].sounds
      )
  );
}