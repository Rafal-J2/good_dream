import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ModeSwitch extends StatelessWidget {
  const ModeSwitch({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    this.flexSchemeData,
  });
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final FlexSchemeData? flexSchemeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: FlexThemeModeSwitch(
        title: const Text(
          '',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        selectedLabelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        themeMode: themeMode,
        onThemeModeChanged: onThemeModeChanged,
        flexSchemeData: flexSchemeData!,
      ),
    );
  }
}
