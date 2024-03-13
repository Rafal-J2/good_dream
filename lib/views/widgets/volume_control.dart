
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/media_control/media_control_cubit.dart';

class VolumeControl extends StatelessWidget {
   final AssetsAudioPlayer player;
  final String audioFileId;

  const VolumeControl({
    super.key,
    required this.player,
    required this.audioFileId,
  });

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.volume(
      player: player,
      builder: (context, volume) {
        return Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey,
          child: Slider(
              value: volume,
              min: 0,
              max: 1,
              divisions: 50,
              onChanged: (v) => player.setVolume(v),
              onChangeEnd: (v) {
                context.read<MediaControlCubit>().setVolume(audioFileId, v);
              }),
        );
      },
    );
  }
}
