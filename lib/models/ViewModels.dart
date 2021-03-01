import 'package:assets_audio_player/assets_audio_player.dart';

class ViewModels {
  bool isFav;
  String events;
  String picOff;
  String picOn;
  String title;
  String sounds;
  String log;
  final player;

  var opacityOff;
  var opacityOn;

  ViewModels(
      {this.events,
      this.picOff,
      this.title,
      this.isFav,
      this.picOn,
      this.player,
      this.sounds,
      this.log,
      this.opacityOff,
      this.opacityOn});

  playAudio00() {
    player.open(
      Audio("assets/audio/fire2.mp3"),
      showNotification: true,
    );
  }

  pauseAudio00() {
    player.pause();
    print(' player.pause();');
  }
}
