import 'package:good_dream/audio_resources/mechanical_sounds.dart';

import '../../models/audio_clip.dart';
import '../../audio_resources/music_sounds.dart';
import '../../audio_resources/nature_sounds.dart';
import '../../audio_resources/water_sounds.dart';

Map<String, List<AudioClip>> soundsByCategory = {
  'natureSounds': natureSounds,
  'musicSounds': musicSounds,
  'waterSounds': waterSounds,
  'mechanicalSounds': mechanicalSounds,
};
