import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/bloc/media_control/sounds_cubit.dart';
import 'package:good_dream/bloc/timer/timer_cubit.dart';
import 'package:good_dream/configuration/env_config.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/services/timer_service.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

import 'views/main_menu_navigator.dart';

var logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await GetStorage.init();
  const environment = 'development';
  final config = EnvConfig.fromEnvironment(environment);
  if (!config.enableLogging) {
    Logger.level = Level.off;
  }
  runApp(const MyApp());
}

void setupGetIt() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<TimerService>(TimerService(0));
  getIt
      .registerFactory<TimerCubit>(() => TimerCubit(getIt.get<TimerService>()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        BlocProvider<TimerCubit>(create: (context) => GetIt.I<TimerCubit>()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
        BlocProvider(create: (context) => MediaControlCubit(soundsByCategory)),

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
