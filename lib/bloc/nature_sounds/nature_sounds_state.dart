part of 'nature_sounds_cubit.dart';

@immutable
sealed class NatureSoundsState {}

final class NatureSoundsInitial extends NatureSoundsState {}

class NatureSoundsLoaded extends NatureSoundsState {
  final List<AudioClip> clips;

  NatureSoundsLoaded(this.clips);
}
