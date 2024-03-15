import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/services/foreground_service.dart';
import 'package:good_dream/utils/toast_notifications.dart';
import 'package:good_dream/models/audio_clip.dart';

import '../audio_resources/water_sounds.dart';

class DataProvider extends ChangeNotifier {
  final Map<int, int> _cart = {};

  Map<int, int> get cart => _cart;

  final List<AudioClip> _items = [];
  void add(AudioClip item) {
    _items.add(item);

    notifyListeners();
  }

  void addAll(index) async {
    if (count <= 5) {
      //Bool checking
      waterSounds[index].isControlActive = !waterSounds[index].isControlActive;
      // Play or Stop sounds
      waterSounds[index].isControlActive
          ? waterSounds[index].player.open(
              Audio(
                waterSounds[index].audioFile!,
              ),
              volume: 0.5,
              //  showNotification: true,
              loopMode: LoopMode.single)
          : waterSounds[index].player.pause();

      //   cart.addTest2(index);
      waterSounds[index].isControlActive
          ? add(waterSounds[index])
          : remove(waterSounds[index]);

      //Add image to page two. If is isFav = true, add entire arrays.
      // Table number is depends on from the selected item
      // for example:  arrays[0].isFav = true.
      // If is true add to cart provider entire items  "picOff, isFav, sounds, vol, player"
      // basketItems is the receiver i find screenTwo.dart
    } else if (count == 6) {
      cart.remove(waterSounds[index]);
      waterSounds[index].isControlActive = false;
      waterSounds[index].player.pause();

      //Toast Text
      if (count == 6) {
        notifyMaxSoundsReached();
      }
    }
    // foregroundService START or STOP
    if (count == 1) {
      startForegroundService();
    } else if (count == 0 && count2 == 0) {
      stopForegroundService();
    }
  }

  void remove(AudioClip item) {
    _items.remove(item);
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  // counter to piano
  int get count2 {
    return _items2.length;
  }

  final List<AudioClip> _items2 = [];

  void add2(AudioClip item) {
    _items2.add(item);
    notifyListeners();
  }

  void remove2(AudioClip item) {
    _items2.remove(item);
    notifyListeners();
  }

  List<AudioClip> get basketItems2 {
    return _items2;
  }

  List<AudioClip> get basketItems {
    return _items;
  }

  final List<AudioClip> _items3 = [];

  add3(AudioClip item) {
    _items3.add(item);
    notifyListeners();
  }

  List<AudioClip> get basketItems3 {
    return _items3;
  }
}
