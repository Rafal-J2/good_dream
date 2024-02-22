import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioClip {
  bool? isControlActive;
  double volumeControlSlider;
  String? disableIcon;
  String? enableIcon;
  String? iconTitleText;
  String? audioFile;
  String? mainAppIcons;
  GestureDetector? gestureDetector;
  TextStyle? policyHeaderTextStyle;
  AssetsAudioPlayer? player;
  bool? isDarkMode;
  ThemeMode? checkThemeMode;

  AudioClip(
      {this.isControlActive,
      this.volumeControlSlider = 0.5,
      this.disableIcon,
      this.enableIcon,
      this.iconTitleText,
      this.player,
      this.audioFile,
      this.mainAppIcons,
      this.gestureDetector,
      this.policyHeaderTextStyle,
      this.isDarkMode,
      this.checkThemeMode});
}
