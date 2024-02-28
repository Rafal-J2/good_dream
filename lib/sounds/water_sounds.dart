import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/models/audio_clip.dart';

List<AudioClip> get waterSounds => _waterSounds;
final _waterSounds = [
  AudioClip(
      disableIcon: 'assets/images/river_w.png',
      enableIcon: 'assets/images/river_on.png',
      iconTitleText: 'River',
      audioFile: "assets/audio/river.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/creek_w.png',
      enableIcon: 'assets/images/creek_on.png',
      iconTitleText: 'Small creek',
      audioFile: "assets/audio/small_creek.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/rain_w.png',
      enableIcon: 'assets/images/rain_on.png',
      iconTitleText: 'Rain',
      audioFile: "assets/audio/rain.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/rain_on_car_roof_w.png',
      enableIcon: 'assets/images/rain_on_car_roof_on.png',
      iconTitleText: 'Rain on car roof',
      audioFile: "assets/audio/rain_on_car_roof.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/windshield_w.png',
      enableIcon: 'assets/images/windshield_on.png',
      iconTitleText: 'Rain on car windows',
      audioFile: "assets/audio/windshield_wipers.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/fountain_park_w.png',
      enableIcon: 'assets/images/fountain_park_on.png',
      iconTitleText: 'Fountain in park',
      audioFile: "assets/audio/fountain_park.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/raincoat_w.png',
      enableIcon: 'assets/images/raincoat_on.png',
      iconTitleText: 'Rain under raincoat',
      audioFile: "assets/audio/rain_under_raincoat.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/rain_windows_w.png',
      enableIcon: 'assets/images/rain_windows_on.png',
      iconTitleText: 'Rain on windows',
      audioFile: 'assets/audio/rain_on_windows.ogg',
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/sea_w.png',
      enableIcon: 'assets/images/sea_on.png',
      iconTitleText: 'Sea',
      audioFile: 'assets/audio/sea.ogg',
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/cave_w.png',
      enableIcon: 'assets/images/cave_on.png',
      iconTitleText: 'Cave',
      audioFile: 'assets/audio/amb_cave.ogg',
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/waterfall_w.png',
      enableIcon: 'assets/images/waterfall_on.png',
      iconTitleText: 'Waterfall',
      audioFile: "assets/audio/waterfall.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/jacuzzi_w.png',
      enableIcon: 'assets/images/jacuzzi_on.png',
      iconTitleText: 'Jacuzzi',
      audioFile: "assets/audio/jacuzzi.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
];
