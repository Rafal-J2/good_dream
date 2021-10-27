import 'dart:developer';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/fun/arrays_3-4.dart';
import 'package:good_dream/fun/modeSwitch.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:provider/provider.dart';
import 'package:good_dream/fun/showDialogs.dart';

/*class Controller extends GetxController {
  final dataStorage = GetStorage();
 //  get isThemeMode => dataStorage.read('key');
}*/

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
//    this.setDarkMode,
  }) : super(key: key);
//  final ValueChanged<bool>? setDarkMode;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with AutomaticKeepAliveClientMixin {

  final dataStorage = GetStorage();

  void initState() {
    super.initState();
    dataStorage.read('intCheck');
    log("what is inCheck in initState: $intCheck");
   // dataStorage.read('intCheck');
    log("dataStorage.read: ${dataStorage.read('intCheck')}");
    _switchThemeMode();
   // checkStorage();

  }

  void _switchThemeMode(){
    switch(dataStorage.read('intCheck')){
      case 0 :
      //  arrays4[0].checkThemeMode = ThemeMode.light;
        themeMode = ThemeMode.light;
        print('switchThemeMode - ThemeMode.light*');
        break;
      case 1 :
     //   arrays4[0].checkThemeMode = ThemeMode.dark;
      themeMode = ThemeMode.dark;
        print('ThemeMode.dark*');
        break;
      case 2 :
      //  arrays4[0].checkThemeMode = ThemeMode.system;
       themeMode = ThemeMode.system;
        print('ThemeMode.system*');
    }
  }

   _checkStorage() {
  if(themeMode == ThemeMode.light) {
    intCheck = 0;
  } else if (themeMode == ThemeMode.dark){
    intCheck = 1;
  } else {intCheck = 2;}
  dataStorage.write('intCheck', intCheck);
  log("dataStorage.write ${dataStorage.write('intCheck', intCheck)}");
}

    int intCheck = 2;
  late ThemeMode themeMode;
// ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
//    final controller = Get.put(Controller());
    super.build(context);
    // const FlexScheme usedFlexScheme = FlexScheme.mandyRed;
    return Consumer<DataProvider>(builder: (
        context,
        cart,
        child,
        ) {
      return ListView(
        children: <Widget>[
          /*      DrawerHeader(
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),*/
          Column(
            children: [
              ListTile(
                title: Text('Privacy Policy',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Privacy Policy'),
                          content: setupAlertDialogContainer(),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Approve'),
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
                title: Text(
                  'Acknowledgments',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Acknowledgments'),
                          content: showMyDialog3(),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Approve'),
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
                title: Text(
                  'Exit the application',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
              Column(
                children: [
                  Container(
                    height: 200,
                    child: HomePage(
                      // We pass it the current theme mode.
             //    themeMode: themeMode,
                      /// The selected icon
                      // themeMode: arrays4[0].checkThemeMode,
                       themeMode:  themeMode,
                      // On the home page we can toggle theme mode between light and dark.
                      onThemeModeChanged: (ThemeMode mode) {
                        setState(() {
                         themeMode = mode;
                         _checkStorage();
                     //   arrays4[0].themeMode = mode;
                          arrays4[0].checkThemeMode = mode;
                          cart.add3(arrays4[0]);
                        });

                        log("acart.add3(arrays4[0]");
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



