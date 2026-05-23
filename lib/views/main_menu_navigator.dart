import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/views/favorites_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:good_dream/views/widgets/active_sounds_bottom_bar.dart';

import 'main_tab_bar_controller.dart';
import 'settings_controller.dart';
import 'ai_assistant_controller.dart';

class MainMenuNavigator extends StatefulWidget {
  const MainMenuNavigator({super.key, this.title, });
  final String? title;


  @override
  MainMenuNavigatorState createState() => MainMenuNavigatorState();
}

class MainMenuNavigatorState extends State<MainMenuNavigator> {
  int _selectedPageIndex = 0;
  late List<Widget> _pages;
  late final PageController _pageController =
      PageController(initialPage: _selectedPageIndex);
  final dataStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    _pages = [
      // const MainTabBarController(), // Tymczasowo ukryte
      const FavoritesController(), 
      const AIAssistantController(),
      const SettingsController(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              return;
            }
            final bool shouldPop = await onBackPressed();
            if (shouldPop) {
              if (mounted) {
                await context.read<MediaControlCubit>().disableAllSoundsAndIcons();
              }
              SystemNavigator.pop();
            }
          },
          child: Stack(
            children: [
              // 1. Global Deep Space Gradient Background
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF070514),
                      Color(0xFF0F0B29),
                      Color(0xFF1E1242),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // Decorative glowing sphere at top-right
              Positioned(
                top: -100,
                right: -50,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6B4EFF).withOpacity(0.12),
                    ),
                  ),
                ),
              ),

              // Decorative glowing sphere at bottom-left
              Positioned(
                bottom: -120,
                left: -100,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF00F2FE).withOpacity(0.08),
                    ),
                  ),
                ),
              ),

              // 2. Scaffold on top of the background
              Scaffold(
                backgroundColor: Colors.transparent,
                body: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _pages,
                ),
                bottomNavigationBar: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ActiveSoundsBottomBar(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.06),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: BottomNavigationBar(
                            elevation: 0,
                            type: BottomNavigationBarType.fixed,
                            backgroundColor: Colors.white.withOpacity(0.02),
                            unselectedItemColor: Colors.white.withOpacity(0.5),
                            selectedItemColor: Colors.amberAccent,
                            selectedIconTheme: const IconThemeData(color: Colors.amberAccent),
                            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                            unselectedLabelStyle: const TextStyle(fontSize: 10),
                            items: [
                              BottomNavigationBarItem(
                                icon: const Icon(Icons.favorite_rounded),
                                label: 'Dźwięki',
                              ),
                              BottomNavigationBarItem(
                                icon: const Icon(Icons.auto_awesome),
                                label: AppLocalizations.of(context)!.aiAssistant,
                              ),
                              BottomNavigationBarItem(
                                icon: const Icon(Icons.menu),
                                label: AppLocalizations.of(context)!.settings,
                              ),
                            ],
                            showSelectedLabels: true,
                            currentIndex: _selectedPageIndex,
                            onTap: (selectedPageIndex) {
                              setState(() {
                                _selectedPageIndex = selectedPageIndex;
                                _pageController.jumpToPage(selectedPageIndex);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        final localizations = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(localizations.exitConfirmTitle),
          content: Text(localizations.exitConfirmContent),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.no),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(localizations.yes),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
