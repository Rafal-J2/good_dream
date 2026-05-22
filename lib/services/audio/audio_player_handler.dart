import 'package:audio_service/audio_service.dart';

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
