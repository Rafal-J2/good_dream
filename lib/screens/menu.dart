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
  //  themeMode = ThemeMode.light;
    intCheck = 1;
    switchThemeMode();
    dataStorage.read('intCheck');
    checkStorage();
 //   arrays4[0].checkThemeMode = themeMode;
 //   cart.add3(arrays4[0]);

    log("intCheck***$intCheck");
  //  switchThemeMode();
 //   arrays4[0].checkThemeMode = ThemeMode.light;
  //   dataStorage.read('key');
 //    dataStorage.read('key2');
   /* if(dataCount.read('key') != null) {
       dataCount.read('key');
    }*/
 //   log("initState controller ${dataStorage.read('key')}");
  //  log("initState themeMode ${themeMode = controller.dataStorage.read('key')}");
  }

   checkStorage() {
  if(themeMode == ThemeMode.light) {
    intCheck = 0;
  } else if (themeMode == ThemeMode.dark){
    intCheck = 1;
  } else {intCheck = 2;}
  dataStorage.write('intCheck', intCheck);
  log("intCheck $intCheck");
}

  void switchThemeMode(){
    switch(intCheck){
      case 0 :
        themeMode = ThemeMode.light;
        print('ThemeMode.light*');
        break;
      case 1 :
        themeMode = ThemeMode.dark;
        print('ThemeMode.dark*');
        break;
      case 2 :
        themeMode = ThemeMode.system;
        print('ThemeMode.system*');
    }
  }

  late int intCheck;

 // late ThemeMode themeMode;
  late ThemeMode themeMode;
//  ThemeMode themeMode = ThemeMode.light;
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
                       themeMode:  themeMode,
                      // On the home page we can toggle theme mode between light and dark.
                      onThemeModeChanged: (ThemeMode mode) {
                        setState(() {
                         themeMode = mode;
                         checkStorage();
                      //   switchThemeMode();
                      //    dataStorage.write('intCheck', intCheck);
                  /*      if(themeMode == ThemeMode.light) {
                           intCheck = 0;
                         } else if (themeMode == ThemeMode.dark){
                           intCheck = 1;
                         } else {intCheck = 2;}
                          log("intCheck $intCheck");
                         log("themeMode $themeMode");*/
                      //   dataStorage.write('key', mode);
                  //       dataStorage.write('key2', _counter);
                     //   arrays4[0].themeMode = mode;
                        arrays4[0].checkThemeMode = themeMode;
                          cart.add3(arrays4[0]);
                    //  log("arrys[0] ${arrays4[0]}");
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

class TapboxB {
}
