import 'package:audio_service/audio_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/models/active_sound.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';

class MockAudioHandler extends Mock implements AudioHandler {}
class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  group('MediaControlCubit Tests', () {
    late MediaControlCubit mediaControlCubit;
    late MockAudioHandler mockAudioHandler;

    setUp(() {
      mockAudioHandler = MockAudioHandler();
      mediaControlCubit = MediaControlCubit({}, mockAudioHandler);
    });

    tearDown(() {
      mediaControlCubit.close();
    });

    const testClip = AudioClip(
      id: 'testId',
      audioFile: 'testFile.mp3',
      iconTitleText: 'Test Sound',
      enableIcon: 'assets/images/default_disabled_icon._on.png',
    );

    blocTest<MediaControlCubit, MediaControlCubitState>(
      'removeSound should remove a sound from the activeSounds list',
      build: () => mediaControlCubit,
      seed: () => MediaControlCubitLoaded(activeSounds: [
        ActiveSound(clip: testClip, player: MockAudioPlayer()),
      ]),
      act: (cubit) {
        // Mock the player stop and dispose
        final activeSound = cubit.state.activeSounds.first;
        when(() => activeSound.player.stop()).thenAnswer((_) async {});
        when(() => activeSound.player.dispose()).thenAnswer((_) async {});
        return cubit.removeSound(testClip);
      },
      expect: () => [
        isA<MediaControlCubitLoaded>().having(
          (state) => state.activeSounds,
          'activeSounds is empty',
          isEmpty,
        ),
      ],
      verify: (_) {
        when(() => mockAudioHandler.stop()).thenAnswer((_) async {});
      },
    );

    test('isSoundActive returns true for active sounds', () {
      final mockPlayer = MockAudioPlayer();
      mediaControlCubit.emit(MediaControlCubitLoaded(activeSounds: [
        ActiveSound(clip: testClip, player: mockPlayer),
      ]));
      expect(mediaControlCubit.isSoundActive('testId'), isTrue);
      expect(mediaControlCubit.isSoundActive('nonExistent'), isFalse);
    });

    test('selectedCount returns correct count', () {
      expect(mediaControlCubit.selectedCount, equals(0));
      final mockPlayer = MockAudioPlayer();
      mediaControlCubit.emit(MediaControlCubitLoaded(activeSounds: [
        ActiveSound(clip: testClip, player: mockPlayer),
      ]));
      expect(mediaControlCubit.selectedCount, equals(1));
    });
  });
}
