import 'package:flutter/material.dart';

class ThemeTextStyles {
  static const TextStyle textStyle =
      TextStyle(fontSize: 14, color: Colors.white);
}

class AppPaddings {
  static const EdgeInsets paddingTopBetweenTextAndImage =
      EdgeInsets.only(top: 10.0);
  static const EdgeInsets paddingTopForGridView = EdgeInsets.only(top: 30.0);
}

class MediaQuerySize {
  static Map<String, double> getImageSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.3;
    double imageHeight = screenHeight * 0.1;

    return {'width': imageWidth, 'height': imageHeight};
  }
}
