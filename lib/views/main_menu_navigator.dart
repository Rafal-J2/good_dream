import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/fun/mixes.dart';
import 'package:good_dream/screens/playing_sounds_controller.dart';
import 'package:lottie/lottie.dart';
import '../bloc/theme_mode/theme_mode_cubit.dart';
import 'settings_controller.dart';
import 'main_tab_bar_controller.dart';

class MainMenuNavigator extends StatefulWidget {
  const MainMenuNavigator({super.key, this.title});
  final String? title;

  @override
  MainMenuNavigatorState createState() => MainMenuNavigatorState();
}

class MainMenuNavigatorState extends State<MainMenuNavigator> {
  int _selectedPageIndex = 0;
  late List<Widget> _pages;
  PageController? _pageController;
  final dataStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = 0;
    _pages = [
      const MainTabBarController(),
      const PlayingSoundsController(),
      const SettingsController(),
      const Mix(),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }
  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
        builder: (context, state) {    
               return BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return PopScope(
               canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) {
                return;
              }
              final bool shouldPop = await onBackPressed();
              if (shouldPop) {
                SystemNavigator.pop();
              }
            },
            child: MaterialApp(
              theme: FlexColorScheme.light(
                      scheme: FlexScheme.red,
                      scaffoldBackground: const Color(0xFF20124d),
                      background: const Color(0xFF20124d))
                  .toTheme,
              darkTheme: FlexColorScheme.dark(
                scheme: FlexScheme.red,
                onPrimary: Colors.white,
              ).toTheme,
              themeMode: themeMode,   
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _pages,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.red,
                  selectedIconTheme: const IconThemeData(color: Colors.red),
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Mix Sounds ',
                    ),
                    BottomNavigationBarItem(
                      icon: state.selectedSounds.isEmpty
                          ? const Icon(Icons.surround_sound)
                          : Lottie.asset('assets/lottieFiles/sounds_waves.json'),
                      label:
                          'Active Sounds - ${state.selectedSounds.length.toString()}',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.menu),
                      label: 'Settings',
                    ),
                  ],
                  showSelectedLabels: true,
                  currentIndex: _selectedPageIndex,
                  onTap: (selectedPageIndex) {
                    setState(() {
                      _selectedPageIndex = selectedPageIndex;
                      _pageController!.jumpToPage(selectedPageIndex);
                    });
                  },
                ),
              ),
            ),
          );
           },
      );
        },
      );
  
  }

  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes'),
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
