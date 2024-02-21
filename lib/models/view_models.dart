import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class ViewModels {
  bool? isFav;
  double volumeControlSlider;
  String? disableIcon;
  String? enableIcon;
  String? iconTitleText;
  String? audioFile;
  String? privacyPolicySections;
  String? mainAppIcons;
  GestureDetector? gestureDetector;
  TextStyle? policyHeaderTextStyle;
  AssetsAudioPlayer? player;
  bool? isDarkMode;
  ThemeMode? checkThemeMode;
  double? opacityOff;
  double? opacityOn;
  Text? text;

  ViewModels(
      {this.isFav,
      this.volumeControlSlider = 0.5,
      this.disableIcon,
      this.enableIcon,
      this.iconTitleText,
      this.player,
      this.audioFile,
      this.opacityOff,
      this.opacityOn,
      this.text,
      this.privacyPolicySections,
      this.mainAppIcons,
      this.gestureDetector,
      this.policyHeaderTextStyle,
      this.isDarkMode,
      this.checkThemeMode});
}
