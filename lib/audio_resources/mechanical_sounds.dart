import 'package:good_dream/models/audio_clip.dart';
import 'package:just_audio/just_audio.dart';

List<AudioClip> get mechanicalSounds => _mechanicalSounds;
final _mechanicalSounds = [
  AudioClip(
      id: 'Plane',
      disableIcon: 'assets/images/plane_w.png',
      enableIcon: 'assets/images/plane_on.png',
      iconTitleText: 'Plane',
      audioFile: "assets/audio/plane.ogg",
      isControlActive: false,
      player: AudioPlayer()),
  AudioClip(
      id: 'Train',
      disableIcon: 'assets/images/train_w.png',
      enableIcon: 'assets/images/train_on.png',
      iconTitleText: 'Train',
      audioFile: "assets/audio/train.ogg",
      isControlActive: false,
      player: AudioPlayer()
      ),
  AudioClip(
      id: 'Car Driving',
      disableIcon: 'assets/images/car_w.png',
      enableIcon: 'assets/images/car_on.png',
      iconTitleText: 'Car Driving',
      audioFile: "assets/audio/car_driving.ogg",
      isControlActive: false,
      player: AudioPlayer()),
  AudioClip(
      id: 'Bus',
      disableIcon: 'assets/images/bus_w.png',
      enableIcon: 'assets/images/bus_on.png',
      iconTitleText: 'Bus',
      audioFile: "assets/audio/fast_bus.ogg",
      isControlActive: false,
      player: AudioPlayer()),
  AudioClip(
      id: 'Washing machine',
      disableIcon: 'assets/images/washing_machine_w.png',
      enableIcon: 'assets/images/washing_machine_on.png',
      iconTitleText: 'Washing machine',
      audioFile: "assets/audio/washing_machine.ogg",
      isControlActive: false,
      player: AudioPlayer()),
  AudioClip(
      id: 'Air Conditioner',
      disableIcon: 'assets/images/air_conditioner_w.png',
      enableIcon: 'assets/images/air_conditioner_on.png',
      iconTitleText: 'Air Conditioner',
      audioFile: "assets/audio/air_conditioner2.ogg",
      isControlActive: false,
      player: AudioPlayer()),
  AudioClip(
      id: 'Vacuum cleaner',
      disableIcon: 'assets/images/vacuum_cleaner_w.png',
      enableIcon: 'assets/images/vacuum_cleaner_on.png',
      iconTitleText: 'Vacuum cleaner',
      audioFile: "assets/audio/vacuum_cleaner2.ogg",
      isControlActive: false,
      player: AudioPlayer()),
  AudioClip(
      id: 'Hair dryer',
      disableIcon: 'assets/images/hair_dryer_w.png',
      enableIcon: 'assets/images/hair_dryer_on.png',
      iconTitleText: 'Hair dryer',
      audioFile: "assets/audio/hair_dryer2.ogg",
      isControlActive: false,
      player: AudioPlayer()),
  AudioClip(
      id: 'Keyboard',
      disableIcon: 'assets/images/keyboard_w.png',
      enableIcon: 'assets/images/keyboard_on.png',
      iconTitleText: 'Keyboard',
      audioFile: "assets/audio/keyboard.ogg",
      isControlActive: false,
      player: AudioPlayer()),
];
