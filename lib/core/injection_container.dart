import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:good_dream/services/audio/audio_player_handler.dart';
import '../bloc/media_control/media_control_cubit.dart';
import '../bloc/timer/timer_cubit.dart';
import '../services/tab_service.dart';
import '../services/timer_service.dart';

void setupGetIt() async {
  final getIt = GetIt.instance;
  getIt.registerSingleton<TabService>(TabService());
  getIt.registerSingleton<TimerService>(TimerService(0));
  getIt.registerFactory<TimerCubit>(() => TimerCubit(getIt.get<TimerService>()));

     GetIt.I.registerSingleton<AudioHandler>(await AudioService.init(
       builder: () => AudioPlayerHandler(),
       config: const AudioServiceConfig(
         androidNotificationChannelId: 'com.myapp.channel.audio',
         androidNotificationChannelName: 'Audio playback',
         androidNotificationOngoing: true,
       ),
     ));
     getIt.registerFactory<MediaControlCubit>(() => MediaControlCubit(
    {},
    getIt.get<AudioHandler>()
  ));
}
