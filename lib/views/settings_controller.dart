import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/views/widgets/mode_switch.dart';
import 'package:good_dream/views/show_dialogs.dart';
import '../bloc/theme_mode/theme_mode_cubit.dart';


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
