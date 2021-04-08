import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
/*

void main() => runApp(DemoApp());
class DemoApp extends StatefulWidget {

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedFlexScheme = FlexScheme.mandyRed;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexColorScheme',
      theme: FlexColorScheme
          .light(scheme: FlexScheme.red,
      ).toTheme,
      darkTheme: FlexColorScheme
          .dark(scheme: FlexScheme.red,
      ).toTheme,
      // Use the above dark or light theme based on active themeMode.
      themeMode: themeMode,
      // This simple example app has only one page.
      home: HomePage(
        // We pass it the current theme mode.
        themeMode: themeMode,
        // On the home page we can toggle theme mode between light and dark.
        onThemeModeChanged: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
        flexSchemeData: FlexColor.schemes[usedFlexScheme],
      ),
    );
  }
}
*/

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
    this.themeMode,
    this.onThemeModeChanged,
    this.flexSchemeData,
  }) : super(key: key);
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final FlexSchemeData flexSchemeData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(40.0),
          height: 200,
          //width: 100,
          child: FlexThemeModeSwitch(
            title: Text(
              'Chose a Colors',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            selectedLabelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            themeMode: themeMode,
            onThemeModeChanged: onThemeModeChanged,
            flexSchemeData: flexSchemeData,
          ),
        ),
      ],
    );
  }
}
