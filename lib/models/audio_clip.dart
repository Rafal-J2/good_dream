/// Pure data model representing a sound clip in the catalog.
/// Does not hold any native resources (AudioPlayer).
class AudioClip {
  final String id;
  final String? disableIcon;
  final String? enableIcon;
  final String? iconTitleText;
  final String? audioFile;
  final String? mainAppIcons;

  const AudioClip({
    required this.id,
    this.disableIcon,
    this.enableIcon,
    this.iconTitleText,
    this.audioFile,
    this.mainAppIcons,
  });
}
