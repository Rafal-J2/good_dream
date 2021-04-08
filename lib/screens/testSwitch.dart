import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ****************************************************************************
// Const and finals for setup and theme



// Custom Eden palette
// Color sources: https://www.w3schools.com/colors/colors_2019.asp
const Color lightPrimary = Color(0xFF264E36); // Eden 23%
const Color lightPrimaryVariant = Color(0xFF224430); // Eden 20%
const Color lightSecondary = Color(0xFF797b3a); // Guacamole 35%
const Color lightSecondaryVariant = Color(0xFF555729); // Guacamole 25%

final Color lightCanvas = Color.alphaBlend(
    lightPrimary.withAlpha((256 * 0.07).toInt()), Colors.white);

const Color darkPrimary = Color(0xFF59a678); // Eden light 50%
const Color darkPrimaryVariant = Color(0xFF478560); // Eden light 40%
const Color darkSecondary = Color(0xFFd5d6a8); // Guacamole 75%
const Color darkSecondaryVariant = Color(0xFFbbbe74); // Guacamole 60%

final Color darkCanvas = Color.alphaBlend(
    darkPrimary.withAlpha((256 * 0.12).toInt()), const Color(0xFF121212));

const ColorScheme lightScheme = ColorScheme.light(
  primary: lightPrimary,
  primaryVariant: lightPrimaryVariant,
  secondary: lightSecondary,
  secondaryVariant: lightSecondaryVariant,
);

const ColorScheme darkScheme = ColorScheme.dark(
  primary: darkPrimary,
  primaryVariant: darkPrimaryVariant,
  secondary: darkSecondary,
  secondaryVariant: darkSecondaryVariant,
);

final ThemeData lightTheme = ThemeData.from(colorScheme: lightScheme).copyWith(
  canvasColor: lightCanvas,
  toggleableActiveColor: lightScheme.secondary,
  buttonTheme: const ButtonThemeData(
    colorScheme: lightScheme,
    textTheme: ButtonTextTheme.primary,
  ),
);

final ThemeData darkTheme = ThemeData.from(colorScheme: darkScheme).copyWith(
  canvasColor: darkCanvas,
  toggleableActiveColor: darkScheme.secondary,
  buttonTheme: const ButtonThemeData(
    colorScheme: darkScheme,
    textTheme: ButtonTextTheme.primary,
  ),
);

// ****************************************************************************

void main() {
  runApp(TestApp());
}
class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}
class _TestAppState extends State<TestApp> {
  bool isDarkMode;
  bool colorSchemeTheme;

  @override
  void initState() {
    isDarkMode = false;
    colorSchemeTheme = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  // final ThemeData theme = Theme.of(context);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: colorSchemeTheme ? lightTheme : ThemeData.light(),
      darkTheme: colorSchemeTheme ? darkTheme : ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: DemoPage(
        setDarkMode: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({
    Key key,
    this.setDarkMode,
  }) : super(key: key);
  final ValueChanged<bool> setDarkMode;

  @override
  _DemoPageState createState() => _DemoPageState();
}
//-----------------------------


class _DemoPageState extends State<DemoPage> {
  bool isDarkMode;
  @override
  void initState() {
    isDarkMode = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Scrollbar(
        child: Center(
          child: ListView(
            children: <Widget>[
              SwitchListTile.adaptive(
                title: const Text('Use dark theme'),
                subtitle:
                const Text('OFF for light theme, ON for dark theme.'),
                value: isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    isDarkMode = value;
                    widget.setDarkMode(isDarkMode);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}




