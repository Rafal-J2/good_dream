import 'package:audio_service/audio_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/models/active_sound.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class MockAudioHandler extends Mock implements AudioHandler {}
class MockAudioPlayer extends Mock implements AudioPlayer {}

MockAudioPlayer _createMockPlayer() {
  final player = MockAudioPlayer();
  registerFallbackValue(player);
  when(() => player.stop()).thenAnswer((_) async {});
  when(() => player.dispose()).thenAnswer((_) async {});
  return player;
}

void main() {
  group('MediaControlCubit Tests', () {
    late MediaControlCubit mediaControlCubit;
    late MockAudioHandler mockAudioHandler;
    late BehaviorSubject<PlaybackState> playbackStateSubject;

    setUp(() {
      mockAudioHandler = MockAudioHandler();
      playbackStateSubject = BehaviorSubject<PlaybackState>.seeded(
        PlaybackState(
          playing: false,
          controls: const [],
          systemActions: const {},
        ),
      );
      when(() => mockAudioHandler.playbackState).thenAnswer((_) => playbackStateSubject);
      mediaControlCubit = MediaControlCubit({}, mockAudioHandler);
    });

    tearDown(() {
      mediaControlCubit.close();
      playbackStateSubject.close();
    });

    const testClip = AudioClip(
      id: 'testId',
      audioFile: 'testFile.mp3',
      iconTitleText: 'Test Sound',
      enableIcon: 'assets/images/default_disabled_icon._on.png',
      disableIcon: 'assets/images/default_disabled_icon_w.png',
    );

    blocTest<MediaControlCubit, MediaControlCubitState>(
      'removeSound should remove a sound from the activeSounds list',
      build: () => mediaControlCubit,
      seed: () => MediaControlCubitLoaded(activeSounds: [
        ActiveSound(clip: testClip, player: _createMockPlayer()),
      ]),
      act: (cubit) {
        // Mock the player stop and dispose
        final activeSound = cubit.state.activeSounds.first;
        when(() => activeSound.player.stop()).thenAnswer((_) async {});
        when(() => activeSound.player.dispose()).thenAnswer((_) async {});
        when(() => mockAudioHandler.stop()).thenAnswer((_) async {});
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
        verify(() => mockAudioHandler.stop()).called(1);
      },
    );

    test('isSoundActive returns true for active sounds', () {
      final mockPlayer = _createMockPlayer();
      mediaControlCubit.emit(MediaControlCubitLoaded(activeSounds: [
        ActiveSound(clip: testClip, player: mockPlayer),
      ]));
      expect(mediaControlCubit.isSoundActive('testId'), isTrue);
      expect(mediaControlCubit.isSoundActive('nonExistent'), isFalse);
    });

    test('selectedCount returns correct count', () {
      expect(mediaControlCubit.selectedCount, equals(0));
      final mockPlayer = _createMockPlayer();
      mediaControlCubit.emit(MediaControlCubitLoaded(activeSounds: [
        ActiveSound(clip: testClip, player: mockPlayer),
      ]));
      expect(mediaControlCubit.selectedCount, equals(1));
    });

    test('should disable all active sounds and icons when playbackState emits playing=false', () async {
      final mockPlayer = _createMockPlayer();
      mediaControlCubit.emit(MediaControlCubitLoaded(activeSounds: [
        ActiveSound(clip: testClip, player: mockPlayer),
      ]));

      expect(mediaControlCubit.selectedCount, equals(1));
      when(() => mockAudioHandler.stop()).thenAnswer((_) async {});

      // Emit playing = false via subject
      playbackStateSubject.add(PlaybackState(
        playing: false,
        controls: const [],
        systemActions: const {},
      ));

      // Allow microtasks to execute so stream listener runs
      await Future.delayed(Duration.zero);

      expect(mediaControlCubit.selectedCount, equals(0));
      verify(() => mockPlayer.stop()).called(1);
      verify(() => mockPlayer.dispose()).called(1);
      verify(() => mockAudioHandler.stop()).called(1);
    });
  });
}
