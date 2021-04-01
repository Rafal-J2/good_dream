import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigatrors.dart';

class NavTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // The Mandy red, light theme.
      theme: FlexColorScheme
          .light(scheme: FlexScheme.mandyRed)
          .toTheme,
      // The Mandy red, dark theme.
      darkTheme: FlexColorScheme
          .dark(scheme: FlexScheme.mandyRed)
          .toTheme,
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}