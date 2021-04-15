import 'package:admob_flutter/admob_flutter.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:good_dream/screens/mainScreen.dart';
import 'package:good_dream/screens/screenTwo.dart';
import 'package:good_dream/services/admob_service.dart';
import 'package:provider/provider.dart';
import 'menu.dart';

class Navigators extends StatefulWidget {
  @override
  _NavigatorsState createState() => _NavigatorsState();
}

class _NavigatorsState extends State<Navigators> {
  // ThemeMode themeMode = ThemeMode.light;
  bool isDarkMode;

  void initState() {
    isDarkMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Save States in BottomNavigationBar'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeMode themeMode = ThemeMode.light;
  var _selectedPageIndex;
  List<Widget> _pages;
  PageController _pageController;

  final ams = AdMobService();

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = 0;
    _pages = [
      GoodDream(),
      CheckoutPage(),
      Menu(),
    ];

    /// Save state all screens
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fakeBottomButtons = <Widget>[];
    fakeBottomButtons.add(Container(
      child: AdmobBanner(
        adUnitId: ams.getBannerAdId(),
        adSize: AdmobBannerSize.ADAPTIVE_BANNER(
            width: MediaQuery.of(context).size.width.toInt()),
      ),
    ));
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return MaterialApp(
        theme: FlexColorScheme.light(
                scheme: FlexScheme.red,
                //   onSecondary: Colors.white,
                scaffoldBackground: Color(0xFF20124d),
                /// Colors Navigation Bar
                background: Color(0xFF20124d))
            .toTheme,
        darkTheme: FlexColorScheme.dark(
          scheme: FlexScheme.red,
          onPrimary: Colors.white,
          //  scaffoldBackground: Colors.black87,
        ).toTheme,
        // themeMode: ThemeMode.system,
        //   themeMode: cart.basketItems3.isEmpty  ? ThemeMode.dark : cart.basketItems3[0].themeMode,
        themeMode: cart.basketItems3.isEmpty
            ? ThemeMode.system
            : cart.basketItems3[0].themeMode,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.red,
            selectedIconTheme: IconThemeData(color: Colors.red),
            //   backgroundColor: Color(0xFF20124d),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Mix Sounds ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.surround_sound,
                    color: cart.count <= 0
                        ? null
                        : Colors.white),
                label: 'Active Sounds - ${cart.count.toString()}',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Settings',
              ),
            ],
            //   selectedItemColor: Colors.white,
            //   unselectedItemColor: Colors.blue,
            showSelectedLabels: true,
            currentIndex: _selectedPageIndex,
            onTap: (selectedPageIndex) {
              setState(() {
                _selectedPageIndex = selectedPageIndex;
                _pageController.jumpToPage(selectedPageIndex);
              });
            },
          ),
          persistentFooterButtons: fakeBottomButtons,
          /// Colors ADS
          //  backgroundColor: Color(0xFF20124d),
        ),
      );
    });
  }
}

/*
Container(
child: AdmobBanner(
adUnitId: ams.getBannerAdId(),
adSize: AdmobBannerSize.ADAPTIVE_BANNER(
width: MediaQuery.of(context).size.width.toInt()),
),
),*/
