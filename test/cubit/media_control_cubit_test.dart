import 'package:audio_service/audio_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
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

    final testSound = AudioClip(
      id: 'testId',
      audioFile: 'testFile.mp3',
      player: MockAudioPlayer(),
      isControlActive: true,
      iconTitleText: 'Test Sound',
    );

    blocTest<MediaControlCubit, MediaControlCubitState>(
      'removeSound should remove a sound from the selectedSounds list',
      build: () => mediaControlCubit,
      seed: () => MediaControlCubitLoaded(selectedSounds: [testSound]),
      act: (cubit) => cubit.removeSound(testSound),
      expect: () => [
        isA<MediaControlCubitLoaded>().having(
          (state) => state.selectedSounds,
          'selectedSounds is empty',
          isEmpty,
        ),
      ],
    );
  });
}
