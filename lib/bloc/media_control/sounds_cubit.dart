import 'package:good_dream/sounds/mechanical_sounds.dart';

import '../../models/audio_clip.dart';
import '../../sounds/music_sounds.dart';
import '../../sounds/nature_sounds.dart';
import '../../sounds/water_sounds.dart';

Map<String, List<AudioClip>> soundsByCategory = {
  'natureSounds': natureSounds,
  'musicSounds': musicSounds,
  'waterSounds': waterSounds,
  'mechanicalSounds': mechanicalSounds,
};
