import 'package:admob_flutter/admob_flutter.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/screens/mainScreen.dart';
import 'package:good_dream/screens/screenTwo.dart';
import 'package:good_dream/services/admob_service.dart';
import 'menu.dart';

class Navigators extends StatefulWidget {
  @override
  _NavigatorsState createState() => _NavigatorsState();
}

class _NavigatorsState extends State<Navigators> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: FlexColorScheme.light(
        scheme: FlexScheme.red,
        background: Color(0xFF20124d),
    //  surface: Colors.black,
      //  onPrimary: Colors.black,
       //   onSecondary: Colors.black
      ).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.mandyRed).toTheme,
      themeMode: ThemeMode.system,
      home: MyHomePage(title: 'Save States in BottomNavigationBar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fakeBottomButtons = List<Widget>();
    fakeBottomButtons.add(Container(
      child: AdmobBanner(
        adUnitId: ams.getBannerAdId(),
        adSize: AdmobBannerSize.ADAPTIVE_BANNER(
            width: MediaQuery.of(context).size.width.toInt()),
      ),
    ));
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        selectedIconTheme: IconThemeData(
          color: Colors.red
        ),
        //   backgroundColor: Color(0xFF16222A),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Mix Sounds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.surround_sound),
            label: 'Active Sounds',
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
      backgroundColor: Color(0xFF20124d),
    );
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
