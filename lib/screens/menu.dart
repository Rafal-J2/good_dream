import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/fun/arrays.dart';

import 'package:good_dream/fun/modeSwitch.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:provider/provider.dart';
import '../fun/dialogs.dart';
import '../fun/launch_url.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key key,
    this.setDarkMode,
  }) : super(key: key);
  final ValueChanged<bool> setDarkMode;


  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with AutomaticKeepAliveClientMixin {

 // bool isSwitched = false;
 bool isDarkMode;

  void initState() {
    isDarkMode = false;
    super.initState();
  }

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
/*        theme: FlexColorScheme
            .light(scheme: FlexScheme.red,
         // onSecondary: Colors.white,
       //   scaffoldBackground: Color(0xFF20124d),
        )
            .toTheme,
        darkTheme: FlexColorScheme
            .dark(scheme: FlexScheme.red,
        )
            .toTheme,
          themeMode: cart.basketItems3.isEmpty  ? ThemeMode.system : cart.basketItems3[0].themeMode,*/
        return ListView(

          children: <Widget>[
      /*      DrawerHeader(
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),*/
            Column(
              children: [
                ListTile(
                  title:
                  Text('Privacy Policy', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    showMyDialog2();
                  },
                ),
            /*    ListTile(
                  title: Text('Terms & Conditions',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    //  showMyDialog3();
                  },
                ),*/
                ListTile(
                  title: Text(
                    'Acknowledgments',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    showMyDialog3();
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
               Container(
                  height: 200,
                  child: HomePage(
                    // We pass it the current theme mode.
                    themeMode: themeMode,
                    // On the home page we can toggle theme mode between light and dark.
                    onThemeModeChanged: (ThemeMode mode) {
                      setState(() {
                       themeMode = mode;
                        arrays4[0].themeMode = mode;
                        cart.add3(arrays4[0]);
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

  Future<void> showMyDialog2() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text('Privacy Policy'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partOne),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(partTwo),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Consent',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partThree),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Information Collection and Use',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partFour),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Links to Other Sites',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partFive),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Advertising AdMob',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partSix),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 24.0,
                  ),
                  child: GestureDetector(
                    child: Text('•	AdMob',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () => launchURL2(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Analytics',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partSeven),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 24.0,
                  ),
                  child: GestureDetector(
                    child: Text('•	Google Play Services',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () => launchURL(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 24.0,
                  ),
                  child: GestureDetector(
                    child: Text('•	Google Analytics for Firebase',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () => launchURL3(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 24.0,
                  ),
                  child: GestureDetector(
                    child: Text('•	Firebase Crashlytics',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () => launchURL4(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Children’s Privacy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partEight),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Cookies',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partNine),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Information security',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partTen),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Contact Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(partEleven),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog3() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text('Acknowledgments'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Acknowledgments',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(acknowledgments),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 24.0,
                  ),
                  child: GestureDetector(
                    child: Text('•	www.flaticon.com',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () => launchURL5(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(acknowledgments2),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
