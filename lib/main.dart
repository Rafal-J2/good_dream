

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'views/lottie_splash_screen.dart';
import 'core/injection_container.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: defaultTargetPlatform == TargetPlatform.android
        ? const FirebaseOptions(
            apiKey: 'AIzaSyCDH-HTG-t43BgvuGu99fmP1VkLsFj3Bfo',
            appId: '1:238258904158:android:d5cebadfdf4bcd67c868cf',
            messagingSenderId: '238258904158',
            projectId: 'good-dream-3e9ec',
            storageBucket: 'good-dream-3e9ec.appspot.com',
          )
        : null,
  );

  // Crashlytics: przechwytuj wszystkie błędy Flutter
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Crashlytics: przechwytuj błędy asynchroniczne
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setupGetIt();
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
              themeMode: ThemeMode.dark,
              home: const LottieSplashScreen(),
            );
          },
        ));
  }
}
