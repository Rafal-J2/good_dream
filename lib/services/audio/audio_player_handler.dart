import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();
  final int _activeSoundsCount = 0;

  AudioPlayerHandler() {
    _player.playerStateStream.listen((playerState) {
      _updatePlaybackState(playerState);
    });
  }

  void _updatePlaybackState(PlayerState playerState) {
    final playing = playerState.playing;
    final processingState = _mapToAudioServiceProcessingState(playerState.processingState);
    playbackState.add(playbackState.value.copyWith(
      controls: playing ? [MediaControl.pause, MediaControl.stop] : [MediaControl.play],
      systemActions: {MediaAction.seek},
      processingState: processingState,
      playing: playing,
    ));
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> stop() async {
    if (_activeSoundsCount <= 0) {
      await _player.stop();
      await _player.seek(Duration.zero);
      playbackState.add(playbackState.value.copyWith(
        controls: [MediaControl.play],
        processingState: AudioProcessingState.ready,
        playing: false,
      ));

      await super.stop();
    }
  }

AudioProcessingState _mapToAudioServiceProcessingState(ProcessingState state) {
  switch (state) {
    case ProcessingState.idle:
      return AudioProcessingState.idle;
    case ProcessingState.loading:
      return AudioProcessingState.loading;
    case ProcessingState.buffering:
      return AudioProcessingState.buffering;
    case ProcessingState.ready:
      return AudioProcessingState.ready;
    case ProcessingState.completed:
      return AudioProcessingState.completed;
    default:
      throw Exception('Nieznany stan przetwarzania');
  }
}}