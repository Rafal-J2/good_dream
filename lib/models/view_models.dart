import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class ViewModels {
  bool? isFav;
  String? events;
  String? picOff;
  String? picOn;
  String? title;
  String? sounds;
  String? sounds2;
  String? log;
  String? text;
  String? image;
  GestureDetector? gestureDetector;
  TextStyle? textStyle;
  AssetsAudioPlayer? player;
  bool? isDarkMode;
  ThemeMode? checkThemeMode;
  double? opacityOff;
  double? opacityOn;
  double? vol = 0.5;

  ViewModels(
      {this.events,
      this.picOff,
      this.title,
      this.isFav,
      this.picOn,
      this.player,
      this.sounds,
      this.sounds2,
      this.log,
      this.opacityOff,
      this.opacityOn,
      this.vol,
      this.text,
      this.image,
      this.gestureDetector,
      this.textStyle,
      this.isDarkMode,
      this.checkThemeMode});
}
