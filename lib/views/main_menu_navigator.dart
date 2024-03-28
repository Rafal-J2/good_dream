import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:good_dream/screens/playing_sounds_controller.dart';
import 'package:lottie/lottie.dart';
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
  late final PageController _pageController =
      PageController(initialPage: _selectedPageIndex);
  final dataStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    _pages = [
      const MainTabBarController(),
      const PlayingSoundsController(),
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
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            final bool shouldPop = await onBackPressed();
            if (shouldPop) {
              SystemNavigator.pop();
            }
          },
          child: Scaffold(
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
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
                      : Lottie.asset(
                          'assets/lottieFiles/sounds_waves.json'),
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
                  _pageController.jumpToPage(selectedPageIndex);
                });
              },
            ),
          ),
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
