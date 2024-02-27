import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioClip {
  double volumeControlSlider;
  bool isControlActive;
  final AssetsAudioPlayer player;
  final String? disableIcon;
  final String? enableIcon;
  final String? iconTitleText;
  final String? audioFile;
  final String? mainAppIcons;

  ThemeMode? checkThemeMode;

  AudioClip(
      {required this.player,
      required this.isControlActive,
      this.volumeControlSlider = 0.5,
      this.disableIcon,
      this.enableIcon,
      this.iconTitleText,
      this.audioFile,
      this.mainAppIcons,
      this.checkThemeMode});
}
