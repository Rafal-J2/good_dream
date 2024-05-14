import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  
  AudioPlayerHandler() {
    _player.playerStateStream.listen((playerState) {
      _updatePlaybackState(playerState.playing);
    });
  }

void _updatePlaybackState(bool playing) {
  final List<MediaControl> controls = playing ? [MediaControl.stop] : [];
  final processingState = playing ? AudioProcessingState.ready : AudioProcessingState.idle;

  playbackState.add(playbackState.value.copyWith(
    controls: controls,
    systemActions: <MediaAction>{},
    processingState: processingState,
    playing: playing,
  ));
}

  @override
  Future<void> play() async {
    await _player.play();
    _updatePlaybackState(true);
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    _updatePlaybackState(false);
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    _updatePlaybackState(false); 
  }
}
