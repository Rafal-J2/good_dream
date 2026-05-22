import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

Future<void> warmUpAudioEngine() async {
  try {
    final player = AudioPlayer();
    await player.setVolume(0.0);
    await player.dispose();
  } catch (e) {
    // Silently ignore warm-up exceptions
  }
}

class AudioPlayerHandler extends BaseAudioHandler {
  AudioPlayerHandler() {
    _updatePlaybackState(false);
  }

  void _updatePlaybackState(bool playing) {
    final List<MediaControl> controls = playing ? [MediaControl.stop] : [];
    final processingState =
        playing ? AudioProcessingState.ready : AudioProcessingState.idle;

    playbackState.add(playbackState.value.copyWith(
      controls: controls,
      systemActions: <MediaAction>{},
      processingState: processingState,
      playing: playing,
    ));
  }

  @override
  Future<void> play() async {
    _updatePlaybackState(true);
  }

  @override
  Future<void> pause() async {
    _updatePlaybackState(false);
  }

  @override
  Future<void> stop() async {
    _updatePlaybackState(false);
  }
}
