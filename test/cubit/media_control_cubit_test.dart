import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:good_dream/audio_resources/mechanical_sounds.dart';
import 'package:good_dream/audio_resources/music_sounds.dart';
import 'package:good_dream/audio_resources/nature_sounds.dart';
import 'package:good_dream/audio_resources/water_sounds.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:audio_service/audio_service.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:just_audio/just_audio.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}
class MockAudioHandler extends Mock implements AudioHandler {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();  

  group('MediaControlCubit Tests', () {
    late MockAudioHandler mockAudioHandler;
    late MediaControlCubit mediaControlCubit;
    late Map<String, List<AudioClip>> initialSounds;

  setUp(() {
      mockAudioHandler = MockAudioHandler();
      initialSounds = {
        'mechanical': mechanicalSounds,
        'music': musicSounds,
        'nature': natureSounds,
        'water': waterSounds,
      };
      mediaControlCubit = MediaControlCubit(initialSounds, mockAudioHandler);
    });

    blocTest<MediaControlCubit, MediaControlCubitState>(
      'should emit [MediaControlCubitLoaded] with one less sound when removeSound is called for mechanical sound',
      build: () => mediaControlCubit,
      seed: () => MediaControlCubitLoaded(selectedSounds: [
        AudioClip(
          id: 'Plane',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/plane.ogg',
          disableIcon: 'assets/images/plane_w.png',
          enableIcon: 'assets/images/plane_on.png',
          iconTitleText: 'Plane'
        ),
        AudioClip(
          id: 'Train',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/train.ogg',
          disableIcon: 'assets/images/train_w.png',
          enableIcon: 'assets/images/train_on.png',
          iconTitleText: 'Train'
        )
      ]),
      act: (cubit) {
        final soundToRemove = AudioClip(
          id: 'Plane',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/plane.ogg',
          disableIcon: 'assets/images/plane_w.png',
          enableIcon: 'assets/images/plane_on.png',
          iconTitleText: 'Plane'
        );
        cubit.removeSound(soundToRemove);
      },
      expect: () => [
        isA<MediaControlCubitLoaded>().having(
          (state) => state.selectedSounds,
          'selectedSounds',
          containsAll([
            isA<AudioClip>().having((clip) => clip.id, 'id', 'Train')
          ])
        )
      ],
      verify: (cubit) {
        final state = cubit.state;
        expect(state, isA<MediaControlCubitLoaded>());
        final loadedState = state as MediaControlCubitLoaded;
        expect(loadedState.selectedSounds.length, 1);
        expect(loadedState.selectedSounds.first.id, 'Train');
      },
    );

    blocTest<MediaControlCubit, MediaControlCubitState>(
      'should emit [MediaControlCubitLoaded] with one less sound when removeSound is called for music sound',
      build: () => mediaControlCubit,
      seed: () => MediaControlCubitLoaded(selectedSounds: [
        AudioClip(
          id: 'Meditation',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/flowing_river2.ogg',
          disableIcon: 'assets/images/lotus_w.png',
          enableIcon: 'assets/images/lotus_on.png',
          iconTitleText: 'Meditation'
        ),
        AudioClip(
          id: 'Healing meditation',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/healing_meditation.ogg',
          disableIcon: 'assets/images/healing_w.png',
          enableIcon: 'assets/images/healing_on.png',
          iconTitleText: 'Healing meditation'
        )
      ]),
      act: (cubit) {
        final soundToRemove = AudioClip(
          id: 'Meditation',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/flowing_river2.ogg',
          disableIcon: 'assets/images/lotus_w.png',
          enableIcon: 'assets/images/lotus_on.png',
          iconTitleText: 'Meditation'
        );
        cubit.removeSound(soundToRemove);
      },
      expect: () => [
        isA<MediaControlCubitLoaded>().having(
          (state) => state.selectedSounds,
          'selectedSounds',
          containsAll([
            isA<AudioClip>().having((clip) => clip.id, 'id', 'Healing meditation')
          ])
        )
      ],
      verify: (cubit) {
        final state = cubit.state;
        expect(state, isA<MediaControlCubitLoaded>());
        final loadedState = state as MediaControlCubitLoaded;
        expect(loadedState.selectedSounds.length, 1);
        expect(loadedState.selectedSounds.first.id, 'Healing meditation');
      },
    );

    blocTest<MediaControlCubit, MediaControlCubitState>(
      'should emit [MediaControlCubitLoaded] with one less sound when removeSound is called for nature sound',
      build: () => mediaControlCubit,
      seed: () => MediaControlCubitLoaded(selectedSounds: [
        AudioClip(
          id: 'woodpecker',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/woodpecker.ogg',
          disableIcon: 'assets/images/woodpecker_w.png',
          enableIcon: 'assets/images/woodpecker_on.png',
          iconTitleText: 'Woodpecker'
        ),
        AudioClip(
          id: 'frog',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/frogs_ambience.ogg',
          disableIcon: 'assets/images/frog_w.png',
          enableIcon: 'assets/images/frog_on.png',
          iconTitleText: 'Frogs ambience'
        )
      ]),
      act: (cubit) {
        final soundToRemove = AudioClip(
          id: 'woodpecker',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/woodpecker.ogg',
          disableIcon: 'assets/images/woodpecker_w.png',
          enableIcon: 'assets/images/woodpecker_on.png',
          iconTitleText: 'Woodpecker'
        );
        cubit.removeSound(soundToRemove);
      },
      expect: () => [
        isA<MediaControlCubitLoaded>().having(
          (state) => state.selectedSounds,
          'selectedSounds',
          containsAll([
            isA<AudioClip>().having((clip) => clip.id, 'id', 'frog')
          ])
        )
      ],
      verify: (cubit) {
        final state = cubit.state;
        expect(state, isA<MediaControlCubitLoaded>());
        final loadedState = state as MediaControlCubitLoaded;
        expect(loadedState.selectedSounds.length, 1);
        expect(loadedState.selectedSounds.first.id, 'frog');
      },
    );

    blocTest<MediaControlCubit, MediaControlCubitState>(
      'should emit [MediaControlCubitLoaded] with one less sound when removeSound is called for water sound',
      build: () => mediaControlCubit,
      seed: () => MediaControlCubitLoaded(selectedSounds: [
        AudioClip(
          id: 'River',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/river.ogg',
          disableIcon: 'assets/images/river_w.png',
          enableIcon: 'assets/images/river_on.png',
          iconTitleText: 'River'
        ),
        AudioClip(
          id: 'Small creek',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/small_creek.ogg',
          disableIcon: 'assets/images/creek_w.png',
          enableIcon: 'assets/images/creek_on.png',
          iconTitleText: 'Small creek'
        )
      ]),
      act: (cubit) {
        final soundToRemove = AudioClip(
          id: 'River',
          player: MockAudioPlayer(),
          isControlActive: true,
          audioFile: 'assets/audio/river.ogg',
          disableIcon: 'assets/images/river_w.png',
          enableIcon: 'assets/images/river_on.png',
          iconTitleText: 'River'
        );
        cubit.removeSound(soundToRemove);
      },
      expect: () => [
        isA<MediaControlCubitLoaded>().having(
          (state) => state.selectedSounds,
          'selectedSounds',
          containsAll([
            isA<AudioClip>().having((clip) => clip.id, 'id', 'Small creek')
          ])
        )
      ],
      verify: (cubit) {
        final state = cubit.state;
        expect(state, isA<MediaControlCubitLoaded>());
        final loadedState = state as MediaControlCubitLoaded;
        expect(loadedState.selectedSounds.length, 1);
        expect(loadedState.selectedSounds.first.id, 'Small creek');
      },
    );

    tearDown(() {
      mediaControlCubit.close();
    });
  });
}

