import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/audio_resources/water_sounds.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Water sounds tests', () {
    test('waterSounds list contains correct number of elements', () {
      expect(waterSounds, isNotNull);
      expect(waterSounds.length, greaterThan(0)); 
    });

    for (var sound in waterSounds) {
      test('AudioClip ${sound.id} has non-null properties and correct file paths', () {
        expect(sound.id, isNotEmpty);
        expect(sound.disableIcon, isNotEmpty);
        expect(sound.enableIcon, isNotEmpty);
        expect(sound.iconTitleText, isNotEmpty);
        expect(sound.audioFile, isNotEmpty);
        expect(sound.isControlActive, isFalse);
        expect(sound.player, isA<AudioPlayer>());
        expect(sound.audioFile, endsWith('.ogg'));
        expect(sound.disableIcon, endsWith('.png'));
        expect(sound.enableIcon, endsWith('.png'));
      });
    }
  });
}
