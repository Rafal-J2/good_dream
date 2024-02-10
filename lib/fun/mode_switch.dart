import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    this.themeMode,
    this.onThemeModeChanged,
    this.flexSchemeData,
  }) : super(key: key);
  final ThemeMode? themeMode;
  final ValueChanged<ThemeMode>? onThemeModeChanged;
  final FlexSchemeData? flexSchemeData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          height: 200,
          //width: 100,
          child: FlexThemeModeSwitch(
            height: 20,
            width: 20,
            title: const Text(
              'Chose a Colors',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            selectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            themeMode: themeMode!,
            onThemeModeChanged: onThemeModeChanged!,
            flexSchemeData: flexSchemeData!,
          ),
        ),
      ],
    );
  }
}
