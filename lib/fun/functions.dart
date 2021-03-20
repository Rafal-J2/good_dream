import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';

//show text
void toast() {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg:"6 sounds can be played simultaneously.",
     // msg: "Jednocześnie można odtwarzać 6 dźwięków",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black, //Colors.black45
      textColor: Colors.white,
      fontSize: 16.0);
}

void toast2() {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: "Piano sounds cannot be mix together",
    //  msg: "Dźwięków pianina nie można ze sobą łączyć.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black, // Colors.black45
      textColor: Colors.white,
      fontSize: 16.0);
}

void toast3() {
  Fluttertoast.showToast(
      msg: "The time has started",
    //  msg: "Czas wystartował",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white, //Colors.white70
      textColor: Colors.black,
      fontSize: 16.0);
}

final assetsAudioPlayer = AssetsAudioPlayer();

// Audio
foregroundService(){
      assetsAudioPlayer.open(
      Audio("assets/audio/silence.mp3"),
      loopMode: LoopMode.single,
      showNotification: true,
      notificationSettings: NotificationSettings(
          nextEnabled: false,
          prevEnabled: false,
          seekBarEnabled: false,
          playPauseEnabled: false,
          customStopAction: (player) {
            SystemChannels.platform
                .invokeMethod('SystemNavigator.pop');}
      )
  );
}

foregroundServiceStop(){
  assetsAudioPlayer.stop();
}

