import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/fun/arrays_3_4.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:good_dream/screens/main_screen.dart';
import 'package:good_dream/screens/mixes.dart';
import 'package:good_dream/screens/screen_two.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'settings.dart';

class Navigators extends StatelessWidget {
  const Navigators({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Save States in BottomNavigationBar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  ThemeMode themeMode = ThemeMode.light;
  int _selectedPageIndex = 0;
  late List<Widget> _pages;
  PageController? _pageController;

  final dataStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    _switchThemeMode();
    _selectedPageIndex = 0;
    _pages = [
      const GoodDream(),
      const CheckoutPage(),
      const Menu(),
      const Mix(),
    ];

    /// Save state all screens
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  void _switchThemeMode() {
    switch (dataStorage.read('intCheck')) {
      case 0:
        themeMode = ThemeMode.light;
        logger.i('switchThemeMode - ThemeMode.light*');
        break;
      case 1:
        themeMode = ThemeMode.dark;
        logger.i('ThemeMode.dark*');
        break;
      case 2:
        themeMode = ThemeMode.system;
        logger.i('ThemeMode.system*');
    }
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return MaterialApp(
        theme: FlexColorScheme.light(
                scheme: FlexScheme.red,
                //   onSecondary: Colors.white,
                scaffoldBackground: const Color(0xFF20124d),

                /// Colors Navigation Bar
                background: const Color(0xFF20124d))
            .toTheme,
        darkTheme: FlexColorScheme.dark(
          scheme: FlexScheme.red,
          onPrimary: Colors.white,
          //  scaffoldBackground: Colors.black87,
        ).toTheme,
        themeMode:
            cart.basketItems3.isEmpty ? themeMode : arrays4[0].checkThemeMode,
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
            //   backgroundColor: Color(0xFF20124d),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Mix Sounds ',
              ),
              BottomNavigationBarItem(
                icon: cart.count <= 0
                    ? const Icon(Icons.surround_sound)
                    : Lottie.asset('assets/lottieFiles/sounds_waves.json'),
                label: 'Active Sounds - ${cart.count.toString()}',
  
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
      );
    });
  }
}
