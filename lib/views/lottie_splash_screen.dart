import 'package:flutter/material.dart';
import '../services/audio/audio_player_handler.dart';
import 'main_menu_navigator.dart';

class LottieSplashScreen extends StatefulWidget {
  const LottieSplashScreen({super.key});

  @override
  State<LottieSplashScreen> createState() => _LottieSplashScreenState();
}

class _LottieSplashScreenState extends State<LottieSplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
    _navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() async {
    final warmUpFuture = warmUpAudioEngine();

    // Fast startup: Wait for audio engine warm up and a short duration (800ms total) for smooth visual presence
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 850)),
      warmUpFuture,
    ]);

    if (mounted) {
      // Breathtaking custom cross-fade transition to the main screen
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainMenuNavigator(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Premium Deep Space Background Gradient matching the app's dark style
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF070514),
                  Color(0xFF0F0B29),
                  Color(0xFF19103C),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Decorative faint top glowing sphere for added celestial vibe
          Positioned(
            top: -80,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6B4EFF).withOpacity(0.07),
              ),
            ),
          ),

          // 2. Animated Center Branding Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Premium glowing golden moon & stars emblem
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.015),
                        border: Border.all(
                          color: Colors.amberAccent.withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amberAccent.withOpacity(0.07),
                            blurRadius: 35,
                            spreadRadius: 3,
                          )
                        ]
                      ),
                      child: const Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.nightlight_round,
                            color: Colors.amberAccent,
                            size: 68,
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Elegant App Title
                    const Text(
                      "Good Dream",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // High-end Subtitle matching modern aesthetic
                    Text(
                      "SLEEP & RELAX",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
