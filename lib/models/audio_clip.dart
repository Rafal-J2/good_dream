import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pure data model representing a sound clip in the catalog.
/// Does not hold any native resources (AudioPlayer).
class AudioClip extends Equatable {
  final String id;
  final String disableIcon;
  final String enableIcon;
  final String iconTitleText;
  final String audioFile;

  const AudioClip({
    required this.id,
    required this.disableIcon,
    required this.enableIcon,
    required this.iconTitleText,
    required this.audioFile,
  });

  @override
  List<Object?> get props => [id, disableIcon, enableIcon, iconTitleText, audioFile];
}

extension LocalizedAudioClip on AudioClip {
  String getLocalizedName(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return iconTitleText;
    switch (id.toLowerCase().trim()) {
      case 'woodpecker':
        return localizations.sound_woodpecker;
      case 'frog':
        return localizations.sound_frog;
      case 'strok':
        return localizations.sound_strok;
      case 'city_park':
        return localizations.sound_city_park;
      case 'fireplace':
        return localizations.sound_fireplace;
      case 'bonfire':
        return localizations.sound_bonfire;
      case 'bird':
        return localizations.sound_bird;
      case 'thunder':
        return localizations.sound_thunder;
      case 'cricket':
        return localizations.sound_cricket;
      case 'forest':
        return localizations.sound_forest;
      case 'wind':
        return localizations.sound_wind;
      case 'jungle':
        return localizations.sound_jungle;
      case 'river':
        return localizations.sound_river;
      case 'small creek':
        return localizations.sound_small_creek;
      case 'rain':
        return localizations.sound_rain;
      case 'rain on car roof':
        return localizations.sound_rain_on_car_roof;
      case 'rain on car windows':
        return localizations.sound_rain_on_car_windows;
      case 'fountain in park':
        return localizations.sound_fountain_in_park;
      case 'rain under raincoat':
        return localizations.sound_rain_under_raincoat;
      case 'rain on windows':
        return localizations.sound_rain_on_windows;
      case 'sea':
        return localizations.sound_sea;
      case 'cave':
        return localizations.sound_cave;
      case 'waterfall':
        return localizations.sound_waterfall;
      case 'jacuzzi':
        return localizations.sound_jacuzzi;
      case 'meditation':
        return localizations.sound_meditation;
      case 'healing meditation':
        return localizations.sound_healing_meditation;
      case 'yoga':
        return localizations.sound_yoga;
      case 'asian piano':
        return localizations.sound_asian_piano;
      case 'piano':
        return localizations.sound_piano;
      case 'background piano':
        return localizations.sound_background_piano;
      case 'binaural':
        return localizations.sound_binaural;
      case 'guitar song':
        return localizations.sound_guitar_song;
      case 'background guitar':
        return localizations.sound_background_guitar;
      case 'om surrounding':
        return localizations.sound_om_surrounding;
      case 'zen':
        return localizations.sound_zen;
      case 'flute':
        return localizations.sound_flute;
      case 'plane':
        return localizations.sound_plane;
      case 'train':
        return localizations.sound_train;
      case 'car driving':
        return localizations.sound_car_driving;
      case 'bus':
        return localizations.sound_bus;
      case 'washing machine':
        return localizations.sound_washing_machine;
      case 'air conditioner':
        return localizations.sound_air_conditioner;
      case 'vacuum cleaner':
        return localizations.sound_vacuum_cleaner;
      case 'hair dryer':
        return localizations.sound_hair_dryer;
      case 'keyboard':
        return localizations.sound_keyboard;
      default:
        return iconTitleText;
    }
  }
}
