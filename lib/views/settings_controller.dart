import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/utils/theme_mode_manager.dart';
import 'package:good_dream/views/widgets/mode_switch.dart';
import 'package:good_dream/views/show_dialogs.dart';
import '../bloc/theme_mode/theme_mode_cubit.dart';
import '../main.dart';
import 'widgets/show_custom_dialog.dart';

class SettingsController extends StatefulWidget {
  const SettingsController({super.key});

  @override
  SettingsControllerState createState() => SettingsControllerState();
}

class SettingsControllerState extends State<SettingsController>
    with AutomaticKeepAliveClientMixin {
  final dataStorage = GetStorage();
  final themeModeManager = ThemeModeManager(dataStorage: GetStorage());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int savedThemeModeIndex = await themeModeManager.getSavedThemeMode();
      logger.i("Saved theme mode index: $savedThemeModeIndex");
      ThemeMode initialThemeMode = _switchThemeMode(savedThemeModeIndex);
      if (!mounted) return;
      context.read<ThemeModeCubit>().changeThemeMode(initialThemeMode);
    });
  }

  ThemeMode _switchThemeMode(int check) {
    switch (check) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ListView(
          children: <Widget>[
            Column(
              children: [
                ListTile(
                  title: const Text('Privacy Policy',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    showCustomDialog(
                      context,
                      'Privacy Policy',
                      privacyPolicyDialog(context),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Acknowledgments',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    showCustomDialog(
                      context,
                      'Acknowledgments',
                      acknowledgmentsDialog(context),
                    );
                  },
                ),
                const ListTile(
                  title: Text(
                    'Choose a theme color',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  child: ModeSwitch(
                    themeMode: themeMode,
                    onThemeModeChanged: (ThemeMode mode) {
                      context.read<ThemeModeCubit>().changeThemeMode(mode);
                    },
                    flexSchemeData: FlexColor.schemes[FlexScheme.red],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
