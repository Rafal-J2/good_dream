part of 'media_control_cubit.dart'; 

@immutable
abstract class MediaControlCubitState extends Equatable {
  const MediaControlCubitState();

  List<ActiveSound> get activeSounds;

  @override
  List<Object?> get props => [activeSounds];
}

class MediaControlCubitInitial extends MediaControlCubitState {
  const MediaControlCubitInitial();

  @override
  List<ActiveSound> get activeSounds => const [];
}

class MediaControlCubitLoaded extends MediaControlCubitState {
  @override
  final List<ActiveSound> activeSounds;

  const MediaControlCubitLoaded({this.activeSounds = const []});

  @override
  List<Object?> get props => [activeSounds];
}
