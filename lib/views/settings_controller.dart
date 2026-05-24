import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:good_dream/bloc/locale/locale_cubit.dart';
import 'package:good_dream/views/show_dialogs.dart';
import 'package:good_dream/services/tutorial_service.dart';
import 'package:good_dream/views/main_menu_navigator.dart';

class SettingsController extends StatefulWidget {
  const SettingsController({super.key});

  @override
  SettingsControllerState createState() => SettingsControllerState();
}

class SettingsControllerState extends State<SettingsController>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
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
                centerTitle: true,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
                title: Text(
                  AppLocalizations.of(context)!.settingsTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: <Widget>[
          // Language Switcher Card
          _buildSettingsCard(
            title: AppLocalizations.of(context)!.changeLanguage,
            subtitle: AppLocalizations.of(context)!.changeLanguageSub,
            icon: Icons.translate_rounded,
            color: Colors.lightBlueAccent,
            onTap: () {
              _showLanguageSelectionDialog(context);
            },
          ),
          const SizedBox(height: 16.0),

          // Restart Tutorial Card
          _buildSettingsCard(
            title: AppLocalizations.of(context)!.settingsTutorialTitle,
            subtitle: AppLocalizations.of(context)!.settingsTutorialSub,
            icon: Icons.auto_awesome_rounded,
            color: Colors.pinkAccent,
            onTap: () {
              TutorialService.resetTutorial();
              final navigator = context.findAncestorStateOfType<MainMenuNavigatorState>();
              if (navigator != null) {
                navigator.selectPage(0);
              } else {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
              TutorialService.startStep1(context);
            },
          ),
          const SizedBox(height: 16.0),

          // Privacy Policy Card
          _buildSettingsCard(
            title: AppLocalizations.of(context)!.privacyPolicy,
            subtitle: AppLocalizations.of(context)!.privacyPolicySub,
            icon: Icons.privacy_tip_rounded,
            color: Colors.tealAccent,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.privacyPolicy),
                    content: privacyPolicyDialog(context),
                    actions: <Widget>[
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.approve),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16.0),
          
          // Acknowledgments Card
          _buildSettingsCard(
            title: AppLocalizations.of(context)!.acknowledgments,
            subtitle: AppLocalizations.of(context)!.acknowledgmentsSub,
            icon: Icons.info_outline_rounded,
            color: Colors.amberAccent,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.acknowledgments),
                    content: acknowledgmentsDialog(context),
                    actions: <Widget>[
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.approve),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24.0),

          // Info info-card about global dark space mode
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.05),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.nightlight_round,
                      color: Colors.amberAccent,
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.spaceModeTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppLocalizations.of(context)!.spaceModeDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Dialog(
              backgroundColor: const Color(0xFF0F0B29).withOpacity(0.75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.08),
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.changeLanguage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLanguageOption(context, 'pl', 'Polski', '🇵🇱'),
                    const SizedBox(height: 12),
                    _buildLanguageOption(context, 'en', 'English', '🇬🇧'),
                    const SizedBox(height: 12),
                    _buildLanguageOption(context, 'hi', 'हिन्दी', '🇮🇳'),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(BuildContext context, String localeCode, String languageName, String flag) {
    final currentLocale = context.read<LocaleCubit>().state;
    final isSelected = currentLocale.languageCode == localeCode;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: isSelected ? Colors.amberAccent.withOpacity(0.12) : Colors.white.withOpacity(0.03),
        child: InkWell(
          onTap: () {
            context.read<LocaleCubit>().changeLocale(localeCode);
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? Colors.amberAccent.withOpacity(0.4) : Colors.white.withOpacity(0.06),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Text(flag, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 16),
                Text(
                  languageName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.amberAccent,
                    size: 22,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.1),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withOpacity(0.3),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
