import 'dart:developer';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/sounds/mechanical_sounds.dart';
import 'package:good_dream/fun/mode_switch.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:good_dream/fun/show_dialogs.dart';
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
    // const FlexScheme usedFlexScheme = FlexScheme.mandyRed;
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
                          content: privacyPolicyDialog(),
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
                          content: acknowledgmentsDialog(),
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
                  'Exit the application',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: HomePage(
                      themeMode: themeMode,
                      // On the home page we can toggle theme mode between light and dark.
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
          ),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
