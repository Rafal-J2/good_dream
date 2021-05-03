import 'package:assets_audio_player/assets_audio_player.dart';

class ViewModels {
  bool isFav;
  String events;
  String picOff;
  String picOn;
  String image;
  String title;
  String sounds;
  String sounds2;
  String log;
  final player;

  bool? isDarkMode;
  var themeMode;

  var opacityOff;
  var opacityOn;
  double? vol = 0.5;

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
      this.opacityOn,
      this.vol,
      this.padding,
      this.text,
      this.textStyle,
      this.gestureDetector,
      this.isDarkMode,
      this.themeMode});

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
