import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';


//  TODO: Change to Equatable
class AudioClip {
  double volumeControlSlider;
  bool isControlActive;
  final AudioPlayer player;
  final String? disableIcon;
  final String? enableIcon;
  final String? iconTitleText;
  final String? audioFile;
  final String? mainAppIcons;
  ThemeMode? checkThemeMode;
  final String? id;

  AudioClip( 
      {required this.player,
      required this.isControlActive,
      this.id,
      this.volumeControlSlider = 0.5,
      this.disableIcon,
      this.enableIcon,
      this.iconTitleText,
      this.audioFile,
      this.mainAppIcons,
      this.checkThemeMode});
}
