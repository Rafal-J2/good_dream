import 'package:equatable/equatable.dart';

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
