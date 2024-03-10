part of 'media_control_cubit.dart'; 

@immutable
abstract class MediaControlCubitState {
  List<AudioClip> get selectedSounds;
}

class MediaControlCubitInitial extends MediaControlCubitState {
  @override
  List<AudioClip> get selectedSounds => const [];
}

class MediaControlCubitLoaded extends MediaControlCubitState {
  @override
  final List<AudioClip> selectedSounds;

  MediaControlCubitLoaded({this.selectedSounds = const []});
}
