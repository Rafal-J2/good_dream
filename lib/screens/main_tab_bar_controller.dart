import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/fun/arrays_3_4.dart';
import 'package:good_dream/fun/clock_timer.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'TabView/tab_view_four.dart';
import 'TabView/tab_view_one.dart';
import 'TabView/tab_view_two.dart';
import 'TabView/tab_view_three.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class MainTabBarController extends StatefulWidget {
  //Functions to Show Dialog
  const MainTabBarController({
    Key? key,
    this.confirmWidget,
    this.cancelWidget,
    this.title,
    this.themeMode,
    this.onThemeModeChanged,
  }) : super(key: key);

  final ThemeMode? themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  // Dialogs global
  final Widget? confirmWidget;
  final Widget? cancelWidget;
  final String? title;

  @override
  State createState() => _State();
}

class _State extends State<MainTabBarController> {
 static const TextStyle _textStyle = TextStyle(fontSize: 15);

  @override
  void initState() {
    super.initState();
    _switchThemeMode();
  }

  final dataStorage = GetStorage();
  late int intCheck;

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

  ThemeMode themeMode = ThemeMode.light;


  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = const MethodChannel("com.retroportalstudio.messages");
      String? data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// This is for verification
    final Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FlexColorScheme.light(
                scheme: FlexScheme.red,
                onSecondary: Colors.white,
                scaffoldBackground: const Color(0xFF20124d))
            .toTheme,
        darkTheme: FlexColorScheme.dark(
          scheme: FlexScheme.red,
          onPrimary: Colors.white,
        ).toTheme,
        themeMode:
            cart.basketItems3.isEmpty ? themeMode : arrays4[0].checkThemeMode,
        home: DefaultTabController(
          length: 4,
          child: PopScope(
  canPop: false,
  onPopInvoked: (didPop) async {
    debugPrint("didPop1: $didPop");
    if (didPop) {
      return;
    }
    final bool shouldPop = await onBackPressed();
    if (shouldPop) {
      SystemNavigator.pop();
    }
  },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: AppBar(
                  systemOverlayStyle:
                      const SystemUiOverlayStyle(statusBarColor: Colors.black),
                  bottom:  const TabBar(
                    isScrollable: true,
                    physics: ClampingScrollPhysics(),
                    tabs: [
                       Tab(
                        child: Text(
                          "NATURE",
                          style: _textStyle,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "WATER",
                          style: _textStyle,
                        ),
                      ),
                       Tab(
                        child: Text(
                          "MUSIC",
                          style: _textStyle,
                        ),
                      ),
                       Tab(
                        child: Text(
                          "MECHANICAL",
                          style: _textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          ListView(
                            children: <Widget>[
                              SizedBox(
                                height: screenSize.height / 1.6,
                                child: const TabViewOne(),
                              ),
                            ],
                          ),
                          ListView(
                            children: <Widget>[
                              SizedBox(
                                height: screenSize.height / 1.6,
                                child: const TabViewTwo(),
                              ),
                            ],
                          ),
                          ListView(
                            children: <Widget>[
                              SizedBox(
                                height: screenSize.height / 1.6,
                                child: const TabViewThree(),
                              ),
                            ],
                          ),
                          ListView(
                            children: <Widget>[
                              SizedBox(
                                height: screenSize.height / 1.6,
                                child: const TabViewFour(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const ClockTimer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
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