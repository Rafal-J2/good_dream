
import 'package:flutter/material.dart';
import '../../models/audio_clip.dart';
import '../audio_controler_center.dart';

class AudioControlList extends StatelessWidget {
  final String category;
    final Map<String, List<AudioClip>> soundsByCategory;

  const AudioControlList({
    super.key,
    required this.category,
    required this.soundsByCategory,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return ListView(
      key: PageStorageKey<String>(category),
      children: <Widget>[
        SizedBox(
          height: screenSize.height / 1.6,
          child: AudioControlCenter(
            category: category,
            soundsByCategory: soundsByCategory,
          ),
        ),
      ],
    );
  }
}
