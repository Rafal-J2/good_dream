import 'package:flutter/material.dart';

class ThemeTextStyles {
 static const TextStyle texStyle =  TextStyle(fontSize: 14, color: Colors.white);

static Map<String, double> getImageSize(BuildContext context) {
   double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.3;
    double imageHeight = screenHeight * 0.1; 

    return {'width': imageWidth, 'height': imageHeight};
 }
}
