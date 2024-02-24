import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/fun/models/audio_clip.dart';

List<AudioClip> get natureSounds => _natureSounds;
final _natureSounds = [
  AudioClip(
      disableIcon: 'assets/images/woodpecker_w.png',
      enableIcon: 'assets/images/woodpecker_on.png',
      iconTitleText: 'Woodpecker',
      audioFile: "assets/audio/woodpecker.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/frog_w.png',
      enableIcon: 'assets/images/frog_on.png',
      iconTitleText: 'Frogs ambience',
      audioFile: "assets/audio/frogs_ambience.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/stork_w.png',
      enableIcon: 'assets/images/stork_on.png',
      iconTitleText: 'Stork',
      audioFile: "assets/audio/storks.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/city_park_w.png',
      enableIcon: 'assets/images/city_park_on.png',
      iconTitleText: 'City park',
      audioFile: "assets/audio/city_park.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/fireplace_w.png',
      enableIcon: 'assets/images/fireplace_on.png',
      iconTitleText: 'Fireplace',
      audioFile: "assets/audio/fireplace.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/bonfire2_w.png',
      enableIcon: 'assets/images/bonfire2_on.png',
      iconTitleText: 'Bonfire',
      audioFile: "assets/audio/bonfire.ogg",
      isControlActive: false,
      volumeControlSlider: 0.5,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/bird2_w.png',
      enableIcon: 'assets/images/bird2_on.png',
      iconTitleText: 'Bird',
      audioFile: "assets/audio/bird.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/thunder_w.png',
      enableIcon: 'assets/images/thunder_on.png',
      iconTitleText: 'Thunder',
      audioFile: "assets/audio/thunder_ambience.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/cricket_w.png',
      enableIcon: 'assets/images/cricket_on.png',
      iconTitleText: 'Cricket',
      audioFile: "assets/audio/cricket.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/forest_w.png',
      enableIcon: 'assets/images/forest_on.png',
      iconTitleText: 'Forest',
      audioFile: "assets/audio/forest_ambience.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/wind_w.png',
      enableIcon: 'assets/images/wind_on.png',
      iconTitleText: 'Wind',
      audioFile: "assets/audio/wind.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
  AudioClip(
      disableIcon: 'assets/images/jungle_w.png',
      enableIcon: 'assets/images/jungle_on.png',
      iconTitleText: 'Tropical',
      audioFile: "assets/audio/tropical_ambience.ogg",
      isControlActive: false,
      player: AssetsAudioPlayer()),
];