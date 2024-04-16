import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/audio_resources/mechanical_sounds.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Mechanical sounds test', () {
    test('mechanicalSounds list contains correct number of elements', (){
      expect(mechanicalSounds, isNotNull);
      expect(mechanicalSounds.length, greaterThan(0));
    });

    for (final sound in mechanicalSounds) {
        test('AudioClip ${sound.id} has non-null properties and correct file paths', () {
        expect(sound.id, isNotEmpty);
        expect(sound.disableIcon, isNotEmpty);
        expect(sound.enableIcon, isNotEmpty);
        expect(sound.iconTitleText, isNotEmpty);
        expect(sound.audioFile, isNotEmpty);
        expect(sound.isControlActive, isNotNull);
        expect(sound.player, isA<AssetsAudioPlayer>());
        expect(sound.audioFile, endsWith('.ogg'));
        expect(sound.disableIcon, endsWith('.png'));
        expect(sound.enableIcon, endsWith('.png'));
      });
    }
   });
}
