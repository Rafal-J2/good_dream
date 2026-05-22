import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/audio/audio_player_handler.dart';
import 'main_menu_navigator.dart';

class LottieSplashScreen extends StatefulWidget {
  const LottieSplashScreen({super.key});

  @override
  State<LottieSplashScreen> createState() => _LottieSplashScreenState();
}

class _LottieSplashScreenState extends State<LottieSplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    final warmUpFuture = warmUpAudioEngine();

    await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      warmUpFuture,
    ]);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainMenuNavigator()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Center(
        child: Lottie.asset(
          'assets/lottieFiles/night_splash.json',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
