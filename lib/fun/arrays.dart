import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:good_dream/models/ViewModels.dart';

bool isFav0 = true;
bool isFav1 = true;
bool isFav2 = true;
bool isFav4 = true;
bool isFav5 = true;
bool isFav6 = true;

List<ViewModels> get models => arrays;

final arrays = [

  ViewModels(
      events: 'click_woodpecker',
      picOff: 'assets/images/woodpecker_w.png',
      picOn: 'assets/images/woodpecker_on.png',
      title: 'Woodpecker',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/woodpecker.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_frogs_ambience',
      picOff: 'assets/images/frog_w.png',
      picOn: 'assets/images/frog_on.png',
      title: 'Frogs ambience',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/frogs_ambience.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_storks',
      picOff: 'assets/images/stork_w.png',
      picOn: 'assets/images/stork_on.png',
      title: 'Stork',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/storks.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_bonfire',
      picOff: 'assets/images/bonfire2_w.png',
      picOn: 'assets/images/bonfire2_on.png',
      title: 'Bonfire',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/bonfire.ogg",
      vol: 0.5,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_jungle',
      picOff: 'assets/images/jungle_w.png',
      picOn: 'assets/images/jungle_on.png',
      title: 'Tropical',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/tropical_ambience.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_bird',
      picOff: 'assets/images/bird2_w.png',
      picOn: 'assets/images/bird2_on.png',
      title: 'Bird',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/blackbird_in_forest.mp3",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_rain',
      picOff: 'assets/images/rain_w.png',
      picOn: 'assets/images/rain_on.png',
      title: 'Rain',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/rain.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_thunder',
      picOff: 'assets/images/thunder_w.png',
      picOn: 'assets/images/thunder_on.png',
      title: 'Thunder',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/thunder_ambience.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_cricket',
      picOff: 'assets/images/cricket_w.png',
      picOn: 'assets/images/cricket_on.png',
      title: 'Cricket',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/cricket.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_river',
      picOff: 'assets/images/river_w.png',
      picOn: 'assets/images/river_on.png',
      title: 'River',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/river.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_wind',
      picOff: 'assets/images/wind_w.png',
      picOn: 'assets/images/wind_on.png',
      title: 'Wind',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/wind.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_forest',
      picOff: 'assets/images/forest_w.png',
      picOn: 'assets/images/forest_on.png',
      title: 'Forest',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/forest_ambience.ogg",
      player: AssetsAudioPlayer()),

];

List<ViewModels> get models2 => arrays2;
final arrays2 = [
  ViewModels(
      events: 'click_plane',
      picOff: 'assets/images/plane_w.png',
      picOn: 'assets/images/plane_on.png',
      title: 'Plane',
      isFav: false,
      sounds: "assets/audio/plane.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_train',
      picOff: 'assets/images/train_w.png',
      picOn: 'assets/images/train_on.png',
      title: 'Train',
      isFav: false,
      sounds: "assets/audio/train.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_washing_machine',
      picOff: 'assets/images/washing_machine_w.png',
      picOn: 'assets/images/washing_machine_on.png',
      title: 'Washing machine',
      isFav: false,
      sounds: "assets/audio/washing_machine.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_jacuzzi',
      picOff: 'assets/images/jacuzzi_w.png',
      picOn: 'assets/images/jacuzzi_on.png',
      title: 'Jacuzzi',
      isFav: false,
      sounds: "assets/audio/jacuzzi.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_bus',
      picOff: 'assets/images/bus_w.png',
      picOn: 'assets/images/bus_on.png',
      title: 'Bus',
      isFav: false,
      sounds: "assets/audio/fast_bus.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_conditioner',
      picOff: 'assets/images/air_conditioner_w.png',
      picOn: 'assets/images/air_conditioner_on.png',
      title: 'Air Conditioner',
      isFav: false,
      sounds: "assets/audio/air_conditioner2.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_vacuum_cleaner',
      picOff: 'assets/images/vacuum_cleaner_w.png',
      picOn: 'assets/images/vacuum_cleaner_on.png',
      title: 'Vacuum cleaner',
      isFav: false,
      sounds: "assets/audio/vacuum_cleaner2.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_hair_dryer',
      picOff: 'assets/images/hair_dryer_w.png',
      picOn: 'assets/images/hair_dryer_on.png',
      title: 'Hair dryer',
      isFav: false,
      sounds: "assets/audio/hair_dryer2.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_keyboard',
      picOff: 'assets/images/keyboard_w.png',
      picOn: 'assets/images/keyboard_on.png',
      title: 'Keyboard',
      isFav: false,
      sounds: "assets/audio/keyboard.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
];

List<ViewModels> get models3 => arrays3;
final arrays3 = [
  ViewModels(
      events: 'click_piano_and_water',
      picOff: 'assets/images/water_drop_w.png',
      picOn: 'assets/images/water_drop_on.png',
      title: 'Piano and water',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/piano_and_water.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_binaural',
      picOff: 'assets/images/binaural_w.png',
      picOn: 'assets/images/binaural_on.png',
      title: 'Binaural',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/binaural.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_guitar',
      picOff: 'assets/images/guitar_w.png',
      picOn: 'assets/images/guitar_on.png',
      title: 'Guitar Song',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/guitar_song.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_flute',
      picOff: 'assets/images/flute_w.png',
      picOn: 'assets/images/flute_on.png',
      title: 'Flute',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/flute.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_piano_atmosphere',
      picOff: 'assets/images/piano5_w.png',
      picOn: 'assets/images/piano5_on.png',
      title: 'Atmosphere piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/atmosphere_piano.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_relaxation_piano',
      picOff: 'assets/images/piano6_w.png',
      picOn: 'assets/images/piano6_on.png',
      title: 'Relaxation piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/asian_piano.ogg",
      player: AssetsAudioPlayer()),

/*  ViewModels(
    //  events: 'click_asian_piano',
      picOff: 'assets/images/piano3_w.png',
      picOn: 'assets/images/piano3_on.png',
      title: 'Asian piano piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/asian_piano.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
    //  events: 'click_yoga',
      picOff: 'assets/images/lotus_w.png',
      picOn: 'assets/images/lotus_on.png',
      title: 'Relaxation piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/asian_piano.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
    //  events: 'click_yoga_relaxation',
      picOff: 'assets/images/piano6_w.png',
      picOn: 'assets/images/piano6_on.png',
      title: 'Relaxation piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/asian_piano.ogg",
      player: AssetsAudioPlayer()),*/
];



List<ViewModels> get models4 => arrays4;
final arrays4 = [
  ViewModels(
      isDarkMode: false,

        ),

];

