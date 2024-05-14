
import 'package:audio_service/audio_service.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/models/sounds_catalog.dart';
import 'package:good_dream/bloc/theme_mode/theme_mode_cubit.dart';
import 'package:good_dream/bloc/timer/timer_cubit.dart';
import 'package:good_dream/configuration/env_config.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'core/injection_container.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
        providers: [
          BlocProvider<TimerCubit>(create: (context) => GetIt.I<TimerCubit>()),
          BlocProvider( create: (context) => MediaControlCubit(soundsByCategory, GetIt.I<AudioHandler>())),
          BlocProvider(create: (context) => ThemeModeCubit(GetStorage())),
        ],
        child: BlocBuilder<ThemeModeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: FlexColorScheme.light(
                      scheme: FlexScheme.red,
                      surface: const Color(0xFF20124d),
                      scaffoldBackground: const Color(0xFF20124d))
                  .toTheme,
              darkTheme: FlexColorScheme.dark(
                scheme: FlexScheme.red,
                onPrimary: Colors.white,
              ).toTheme,
              themeMode: themeMode,
              home: SplashScreen.navigate(
                name: 'assets/intro2.flr',
                next: (_) => const MainMenuNavigator(),
                until: () => Future.delayed(const Duration(seconds: 3)),
                startAnimation: 'intro',
                backgroundColor: const Color(0xff000000),
              ),
            );
          },
        ));
  }
}
