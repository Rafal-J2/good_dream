import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/mediaControlCubit/media_control_cubit_cubit.dart';
import 'package:good_dream/bloc/nature_sounds/nature_sounds_cubit.dart';
import 'package:good_dream/fun/config.dart';
import 'package:good_dream/models/audio_clip.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/screens/main_menu_navigator.dart';
import 'package:good_dream/sounds/nature_sounds.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

var logger = Logger();

void main() async {
  await GetStorage.init();
  const environment = 'development';
  final config = EnvConfig.fromEnvironment(environment);
  if (!config.enableLogging) {
    Logger.level = Level.off;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    final List<AudioClip> audioClips =
        natureSounds; 
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => NatureSoundsCubit(audioClips),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        ),
        BlocProvider(
        create: ((context) => MediaControlCubit()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen.navigate(
          name: 'assets/intro2.flr',
          next: (_) => const MainMenuNavigator(),
          until: () => Future.delayed(const Duration(seconds: 3)),
          startAnimation: 'intro',
          backgroundColor: const Color(0xff000000),
        ),
      ),
    );
  }
}
