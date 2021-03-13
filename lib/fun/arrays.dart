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
      sounds: "assets/audio/tropical_ambience.mp3",
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
      sounds: "assets/audio/thunder_ambience.mp3",
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
      events: 'click_river',
      picOff: 'assets/images/river_w.png',
      picOn: 'assets/images/river_on.png',
      title: 'River',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/river.ogg",
      player: AssetsAudioPlayer()),

  /*ViewModels(
      events: null,
      picOff: 'assets/images/coming-soon.png',
      picOn: 'assets/images/coming-soon.png',
      title: 'coming-soon',
      isFav: false,
      sounds: null,
      opacityOff: 0.0,
      opacityOn: 0.0,
      player: AssetsAudioPlayer()),*/


/*  ViewModels(
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
      events: 'click_cricket',
      picOff: 'assets/images/cricket_w.png',
      picOn: 'assets/images/cricket_on.png',
      title: 'Cricket',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/cricket.mp3",
      player: AssetsAudioPlayer()),*/
/*  ViewModels(
      events: 'click_forest',
      picOff: 'assets/images/forest_w.png',
      picOn: 'assets/images/forest_on.png',
      title: 'Forest',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/forest_ambience.mp3",
      player: AssetsAudioPlayer()),*/
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
      sounds: "assets/audio/air_conditioner.ogg",
      opacityOff: 0.0,
      opacityOn: 1.0,
      player: AssetsAudioPlayer()),
/* ViewModels(
      events: null,
      picOff: 'assets/images/coming-soon.png',
      picOn: 'assets/images/coming-soon.png',
      title: 'coming-soon',
      isFav: false,
      sounds: null,
      opacityOff: 0.0,
      opacityOn: 0.0,
      player: AssetsAudioPlayer()),*/
];

List<ViewModels> get models3 => arrays3;
final arrays3 = [

  ViewModels(
      events: 'click_piano1',
      picOff: 'assets/images/piano6_w.png',
      picOn: 'assets/images/piano6_on.png',
      title: 'Atmosphere Piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      //   log: "---arrays3[events_1]---",
      sounds: "assets/audio/atmosphere_piano.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_piano2',
      picOff: 'assets/images/piano_w.png',
      picOn: 'assets/images/piano_on.png',
      title: 'Piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/piano_talk.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_piano3',
      picOff: 'assets/images/piano2_w.png',
      picOn: 'assets/images/piano2_on.png',
      title: 'Piano epic voice',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/piano_epic_voice2.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_piano4',
      picOff: 'assets/images/piano3_w.png',
      picOn: 'assets/images/piano3_on.png',
      title: 'Emotional Piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/emotional_piano.ogg",
      player: AssetsAudioPlayer()),
  ViewModels(
      events: 'click_piano5',
      picOff: 'assets/images/piano4_w.png',
      picOn: 'assets/images/piano4_on.png',
      title: 'Emotional Pianos',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      sounds: "assets/audio/emotional_pianos.ogg",
      player: AssetsAudioPlayer()),

  ViewModels(
      events: 'click_piano6',
      picOff: 'assets/images/piano5_w.png',
      picOn: 'assets/images/piano5_on.png',
      title: 'Epic Piano',
      isFav: false,
      opacityOff: 0.0,
      opacityOn: 1.0,
      // log: "---arrays3[events_2]---",
      sounds: "assets/audio/epic_piano.ogg",
      player: AssetsAudioPlayer()),



  /*ViewModels(
      events: null,
      picOff: 'assets/images/coming-soon.png',
      picOn: 'assets/images/coming-soon.png',
      title: 'coming-soon',
      isFav: false,
      sounds: null,
      opacityOff: 0.0,
      opacityOn: 0.0,
      player: AssetsAudioPlayer()),*/




];
