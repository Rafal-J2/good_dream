import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/fun/config.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/screens/navigators.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen.navigate(
        name: 'assets/intro2.flr',
        next: (_) => const MainMenuNavigator(),
        until: () => Future.delayed(const Duration(seconds: 3)),
        startAnimation: 'intro',
        backgroundColor: const Color(0xff000000),
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: materialApp,
    );
  }
}
