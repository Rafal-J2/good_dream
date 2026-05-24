import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import '../models/sounds_catalog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/audio_control_list.dart';
import 'widgets/active_sounds_bottom_bar.dart';

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
  State createState() => _MainTabBarControllerState();
}

class _MainTabBarControllerState extends State<MainTabBarController>
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
    setState(() {}); // Always rebuild to trigger AnimatedContainer
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

  Widget _buildTab(BuildContext context, {required int index, required String title, required String emoji}) {
    final isSelected = _tabController.index == index;
    return Tab(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.06),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji, 
              style: const TextStyle(fontSize: 16)
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(115.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.01),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.06),
                    width: 1.5,
                  ),
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.mixSounds,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50.0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          physics: const BouncingScrollPhysics(),
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                          dividerColor: Colors.transparent,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.white.withOpacity(0.85),
                          tabs: [
                            _buildTab(context, index: 0, title: AppLocalizations.of(context)!.nature, emoji: '🌲'),
                            _buildTab(context, index: 1, title: AppLocalizations.of(context)!.water, emoji: '🌧️'),
                            _buildTab(context, index: 2, title: AppLocalizations.of(context)!.music, emoji: '🎵'),
                            _buildTab(context, index: 3, title: AppLocalizations.of(context)!.mechanical, emoji: '⚙️'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                ),
              ),
              const ActiveSoundsBottomBar(useTutorialKey: true),
            ],
          ),
        ),
      ],
    );
  }
}
