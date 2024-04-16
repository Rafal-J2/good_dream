import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/audio_resources/nature_sounds.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Nature sounds tests', () {
    test('NatureSounds list contains correct number of elements', () {
      expect(natureSounds, isNotNull);
      expect(natureSounds.length, greaterThan(0));
    });

    for (var sound in natureSounds) {
      test(
          'AudioClip ${sound.id} has non-null properties and correct file paths',
          () {
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
