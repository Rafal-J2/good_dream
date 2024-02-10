import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/screens/navigators.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';


void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var materialApp =  MaterialApp(
      debugShowCheckedModeBanner: false,
   //   home: Navigators(),
   //  home: SplashScreen(),
     home: SplashScreen.navigate(
        name:'assets/intro2.flr',
       next: (_) => const Navigators(
        ),
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
