import 'dart:async';
import 'package:flutter/material.dart';
import 'package:good_dream/screens/main_menu_navigator.dart';
import 'package:lottie/lottie.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen(
      {Key? key,
      required String name,
      required MainMenuNavigator Function(dynamic context) next,
      required Future Function() until,
      required String startAnimation,
      required Color backgroundColor})
      : super(key: key);

  @override
  MySplashScreenState createState() => MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MainMenuNavigator()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Lottie.asset(
        'assets/lottieFiles/sounds_waves.json',
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
