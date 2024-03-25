import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/theme_mode/theme_mode_cubit.dart';
import 'package:good_dream/services/clock_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/services/tab_service.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import '../bloc/media_control/sounds_cubit.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get_it/get_it.dart';

import 'widgets/audio_control_list.dart';

class MainTabBarController extends StatefulWidget {
  const MainTabBarController({
    super.key,
    this.confirmWidget,
    this.cancelWidget,
    this.title,
  });

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Inicjalizacja zakładki z zapisanego stanu
    PageStorageBucket? bucket = PageStorage.of(context);
    int? savedIndex = bucket.readState(context, identifier: _pageStorageKey);
    if (savedIndex != null) {
      _tabController.index = savedIndex;
    }

    _tabController.addListener(_saveTabIndex);
  }

  void _saveTabIndex() {
    if (!_tabController.indexIsChanging) {
      PageStorage.of(context).writeState(context, _tabController.index,
          identifier: _pageStorageKey);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    GetIt.I<TabService>().removeListener(_onServiceTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      GetIt.I<TabService>().changeTab(_tabController.index);
    }
  }

  void _onServiceTabChanged() {
    int newIndex = GetIt.I<TabService>().currentTabIndex;
    if (_tabController.index != newIndex) {
      setState(() {
        _tabController.index = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (context, themeMode) {
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
          themeMode: themeMode,
          home: Scaffold(
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
                    Tab(
                        child: Text("NATURE",
                            style: ThemeTextStyles.textStyleTabBar)),
                    Tab(
                        child: Text("WATER",
                            style: ThemeTextStyles.textStyleTabBar)),
                    Tab(
                        child: Text("MUSIC",
                            style: ThemeTextStyles.textStyleTabBar)),
                    Tab(
                        child: Text("MECHANICAL",
                            style: ThemeTextStyles.textStyleTabBar)),
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
                    AudioControlList(
                      category: 'natureSounds',
                      soundsByCategory: soundsByCategory,
                    ),
                    AudioControlList(
                      category: 'waterSounds',
                      soundsByCategory: soundsByCategory,
                    ),
                    AudioControlList(
                      category: 'musicSounds',
                      soundsByCategory: soundsByCategory,
                    ),
                    AudioControlList(
                      category: 'mechanicalSounds',
                      soundsByCategory: soundsByCategory,
                    ),
                  ],
                )),
                const ClockTimer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
