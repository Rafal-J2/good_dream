part of 'media_control_cubit.dart'; 

@immutable
abstract class MediaControlCubitState {
  List<ActiveSound> get activeSounds;
}

class MediaControlCubitInitial extends MediaControlCubitState {
  @override
  List<ActiveSound> get activeSounds => const [];
}

class MediaControlCubitLoaded extends MediaControlCubitState {
  @override
  final List<ActiveSound> activeSounds;

  MediaControlCubitLoaded({this.activeSounds = const []});
}

