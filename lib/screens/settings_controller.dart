import 'dart:developer';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/views/widgets/mode_switch.dart';
import 'package:good_dream/views/show_dialogs.dart';
import '../bloc/theme_mode/theme_mode_cubit.dart';
import '../main.dart';

class SettingsController extends StatefulWidget {
  const SettingsController({super.key});

  @override
  SettingsControllerState createState() => SettingsControllerState();
}

class SettingsControllerState extends State<SettingsController>
    with AutomaticKeepAliveClientMixin {
  final dataStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    dataStorage.read('intCheck');
    log("what is inCheck in initState: $intCheck");
    log("dataStorage.read: ${dataStorage.read('intCheck')}");
  }

  int intCheck = 2;
  ThemeMode themeMode = ThemeMode.system;

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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Privacy Policy'),
                            content: privacyPolicyDialog(context),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
                ListTile(
                  title: const Text(
                    'Acknowledgments',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Acknowledgments'),
                            content: acknowledgmentsDialog(context),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
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
                      logger.i('Requesting themeMode change to: $mode');
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
