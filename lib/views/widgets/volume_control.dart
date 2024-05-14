import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../main.dart';

class VolumeControl extends StatefulWidget {
  final AudioPlayer player;
  final String audioFileId;
  final Function(double) onChangeEnd;

  const VolumeControl({
    super.key,
    required this.player,
    required this.audioFileId,
    required this.onChangeEnd,
  });

  @override
  VolumeControlState createState() => VolumeControlState();
}

class VolumeControlState extends State<VolumeControl> {
  double _currentVolume = 0.5;

  @override
  void initState() {
    super.initState();
    widget.player.setVolume(_currentVolume).catchError((error) {
      _handleVolumeError(error);
    });
  }

  void _handleVolumeError(error) {
    logger.i('Error setting volume: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Volume setting error: $error'),
        duration: const Duration(seconds: 3),
      ),
    );
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
        onChanged: (v) {
          widget.player.setVolume(v).then((_) {
            setState(() {
              _currentVolume = v;
            });
            widget.onChangeEnd(v);
          }).catchError((error) {
            _handleVolumeError(error);
          });
        },
      ),
    );
  }
}
