import 'package:flutter/material.dart';

class ThemeTextStyles {
  static const TextStyle textStyle =
      TextStyle(fontSize: 14, color: Colors.white);

  static const TextStyle textStyleForUrlLauncher =
      TextStyle(decoration: TextDecoration.underline, color: Colors.blue);
}

class AppPaddings {
  static const EdgeInsets paddingTopBetweenTextAndImage =
      EdgeInsets.only(top: 10.0);
  static const EdgeInsets paddingTopForGridView = EdgeInsets.only(top: 30.0);
  static const EdgeInsets paddingForDialogs = EdgeInsets.only(top: 16.0);
  static const EdgeInsets paddingForTitle = EdgeInsets.only(top: 12.0);
  static const EdgeInsets paddingForUrlLauncher = EdgeInsets.only(top: 12.0,left: 24.0,
  );
}

class MediaQuerySize {
  static Map<String, double> getImageSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.3;
    double imageHeight = screenHeight * 0.1;
    double imageWidthForDialog = screenWidth * 0.8;
    double imageHeightForDialog = screenHeight * 0.8;

    return {
      'width': imageWidth,
      'height': imageHeight,
      'widthDialog': imageWidthForDialog,
      'heightDialog': imageHeightForDialog
    };
  }
}
