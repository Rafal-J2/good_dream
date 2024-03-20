import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/audio_resources/mechanical_sounds.dart';
import 'package:good_dream/services/clock_timer.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/views/audio_controler_center.dart';
import 'package:provider/provider.dart';
import '../bloc/media_control/sounds_cubit.dart';
import '../main.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class MainTabBarController extends StatefulWidget {
  const MainTabBarController({
    super.key,
    this.confirmWidget,
    this.cancelWidget,
    this.title,
    this.themeMode,
    this.onThemeModeChanged,
  });

  final ThemeMode? themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  // Dialogs global
  final Widget? confirmWidget;
  final Widget? cancelWidget;
  final String? title;

  @override
  State createState() => _State();
}

class _State extends State<MainTabBarController>
  with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageStorageKey _pageStorageKey = const PageStorageKey('tabBarDemoKey');
  static const TextStyle _textStyle = TextStyle(fontSize: 15);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    PageStorageBucket? bucket = PageStorage.of(context);
    int? savedIndex = bucket.readState(context, identifier: _pageStorageKey);
    if (savedIndex != null) {
      _tabController.index = savedIndex;
    }
    _switchThemeMode();
  }

  final dataStorage = GetStorage();
  late int intCheck;

  void _switchThemeMode() {
    switch (dataStorage.read('intCheck')) {
      case 0:
        themeMode = ThemeMode.light;
        break;
      case 1:
        themeMode = ThemeMode.dark;
        break;
      case 2:
        themeMode = ThemeMode.system;
    }
  }

  ThemeMode themeMode = ThemeMode.light;

  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      var methodChannel = const MethodChannel("com.retroportalstudio.messages");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      PageStorage.of(context).writeState(context, _tabController.index,
          identifier: _pageStorageKey);
    });

    /// This is for verification
    final Size screenSize = MediaQuery.of(context).size;
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
        themeMode: cart.basketItems3.isEmpty
            ? themeMode
            : mechanicalSounds[0].checkThemeMode,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            key: _pageStorageKey,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                systemOverlayStyle:
                    const SystemUiOverlayStyle(statusBarColor: Colors.black),
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  physics: const ClampingScrollPhysics(),
                  tabs: const [
                    Tab(child: Text("NATURE", style: _textStyle)),
                    Tab(child: Text("WATER", style: _textStyle)),
                    Tab(child: Text("MUSIC", style: _textStyle)),
                    Tab(child: Text("MECHANICAL", style: _textStyle)),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          SizedBox(
                            height: screenSize.height / 1.6,
                            child: AudioControlCenter(
                                category: 'natureSounds',
                                soundsByCategory: soundsByCategory),
                          ),
                        ],
                      ),
                      ListView(
                        children: <Widget>[
                          SizedBox(
                            height: screenSize.height / 1.6,
                            child: AudioControlCenter(
                                category: 'waterSounds',
                                soundsByCategory: soundsByCategory),
                          ),
                        ],
                      ),
                      ListView(
                        children: <Widget>[
                          SizedBox(
                            height: screenSize.height / 1.6,
                            child: AudioControlCenter(
                                category: 'musicSounds',
                                soundsByCategory: soundsByCategory),
                          ),
                        ],
                      ),
                      ListView(
                        children: <Widget>[
                          SizedBox(
                            height: screenSize.height / 1.6,
                            child: AudioControlCenter(
                                category: 'mechanicalSounds',
                                soundsByCategory: soundsByCategory),
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
      );
    });
  }
}
