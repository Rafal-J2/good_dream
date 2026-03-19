import 'package:good_dream/services/clock_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import '../models/sounds_catalog.dart';

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
  late final TabController _tabController;
  final PageStorageKey _pageStorageKey = const PageStorageKey('tabBarDemoKey');
  bool _didRestoreTabIndex = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_saveTabIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didRestoreTabIndex) {
      return;
    }

    final bucket = PageStorage.maybeOf(context);
    final savedIndex =
        bucket?.readState(context, identifier: _pageStorageKey) as int?;

    if (savedIndex != null && savedIndex >= 0 && savedIndex < _tabController.length) {
      _tabController.index = savedIndex;
    }

    _didRestoreTabIndex = true;
  }

  void _saveTabIndex() {
    if (_tabController.indexIsChanging) {
      return;
    }

    final bucket = PageStorage.maybeOf(context);
    bucket?.writeState(context, _tabController.index, identifier: _pageStorageKey);
  }

  @override
  void dispose() {
    _tabController.removeListener(_saveTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
