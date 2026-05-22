import 'package:just_audio/just_audio.dart';
import 'audio_clip.dart';

/// Represents a sound currently being played by the user.
/// Lives only inside MediaControlCubit state — not a data model.
class ActiveSound {
  final AudioClip clip;
  final AudioPlayer player;
  final double volume;

  const ActiveSound({
    required this.clip,
    required this.player,
    this.volume = 0.5,
  });

  ActiveSound copyWith({double? volume}) {
    return ActiveSound(
      clip: clip,
      player: player,
      volume: volume ?? this.volume,
    );
  }
}
