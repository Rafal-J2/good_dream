import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/media_control/media_control_cubit.dart';

class VolumeControl extends StatefulWidget {
  final AudioPlayer player;
  final String audioFileId;

  const VolumeControl({
    super.key,
    required this.player,
    required this.audioFileId,
  });

  @override
  VolumeControlState createState() => VolumeControlState();
}

class VolumeControlState extends State<VolumeControl> {
  double _currentVolume = 0.5;

  @override
  void initState() {
    super.initState();
    widget.player.setVolume(_currentVolume);
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: Slider(
        value: _currentVolume,
        min: 0,
        max: 1,
        divisions: 50,
        onChanged: (v) async {
          await widget.player.setVolume(v);
          setState(() {
            _currentVolume = v;
          });
        },
        onChangeEnd: (v) async {
          context.read<MediaControlCubit>().setVolume(widget.audioFileId, v);
        },
      ),
    );
  }
}
