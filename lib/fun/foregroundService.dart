import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';

final assetsAudioPlayer = AssetsAudioPlayer();

// Audio
foregroundService(){
      assetsAudioPlayer.open(
      Audio("assets/audio/silence.mp3",
        metas: Metas(
          title:  "Currently playing",
      //    artist: "Press stop to close the application",
          image: MetasImage.asset("assets/images/binaural_on.png"), //can be MetasImage.network
        ),
      ),
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

