import 'dart:developer';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/sounds/mechanical_sounds.dart';
import 'package:good_dream/fun/mode_switch.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:good_dream/views/show_dialogs.dart';
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
    _switchThemeMode();
  }

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

  _checkStorage() {
    if (themeMode == ThemeMode.light) {
      intCheck = 0;
    } else if (themeMode == ThemeMode.dark) {
      intCheck = 1;
    } else {
      intCheck = 2;
    }
    dataStorage.write('intCheck', intCheck);
    log("dataStorage.write ${dataStorage.write('intCheck', intCheck)}");
  }

  int intCheck = 2;
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
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
                    setState(() {
                      themeMode = mode;
                      _checkStorage();
                      mechanicalSounds[0].checkThemeMode = mode;
                      cart.add3(mechanicalSounds[0]);
                    });
                  },
                  flexSchemeData: FlexColor.schemes[FlexScheme.red],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
