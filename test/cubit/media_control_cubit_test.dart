import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockAssetsAudioPlayer extends Mock implements AssetsAudioPlayer {}

@GenerateMocks([AssetsAudioPlayer])
void main() {
  group('MediaControlCubit Tests', () {
    late MediaControlCubit mediaControlCubit;
    late MockAssetsAudioPlayer mockPlayer;

    setUp(() {
      mockPlayer = MockAssetsAudioPlayer();
      mediaControlCubit = MediaControlCubit({});
    });

blocTest<MediaControlCubit, MediaControlCubitState>(
  'removeSound should remove a sound from the selectedSounds list',
  build: () => mediaControlCubit,
  act: (cubit) async {
    final testClip = AudioClip(id: 'testId', audioFile: 'testFile.mp3', player: mockPlayer, isControlActive: true);
    cubit.addSound(testClip);
    await Future.delayed(Duration.zero); 
    cubit.removeSound(testClip);
  },
  expect: () => [
    isA<MediaControlCubitLoaded>().having(
      (state) => state.selectedSounds,
      'selectedSounds contains the added sound',
      contains(predicate((AudioClip clip) =>
        clip.id == 'testId' &&
        clip.audioFile == 'testFile.mp3' &&
        clip.isControlActive == true)),
    ),
   
    isA<MediaControlCubitLoaded>().having(
      (state) => state.selectedSounds,
      'selectedSounds does not contain the removed sound',
      isNot(contains(predicate((AudioClip clip) =>
        clip.id == 'testId' &&
        clip.audioFile == 'testFile.mp3' &&
        clip.isControlActive == true))),
    ),
  ],
);
  });
}
