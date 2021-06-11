import 'package:flutter/material.dart';
import 'package:good_dream/models/ViewModels.dart';
import 'dialogs.dart';
import 'launch_url.dart';

List<ViewModels> get models5 => arrays5;
final arrays5 = [
  ViewModels(
    text: 'Privacy Policy',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partOne,
  ),
  ViewModels(
    text: "Personal Information",
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partTwo,
  ),
  ViewModels(
    text: 'Consent',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partThree,
  ),
  ViewModels(
    text: 'Information Collection and Use',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partFour,
  ),
  ViewModels(
    text: 'Links to Other Sites',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partFive,
  ),

  ViewModels(
    text: 'Analytics',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partSeven,
  ),

  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: Text('•	Google Play Services',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),
  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: Text('•	Google Analytics for Firebase',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),
  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: Text('•	Firebase Crashlytics',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),

  ViewModels(
    text: 'Children’s Privacy',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partEight,
  ),
  ViewModels(
    text: 'Cookies',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partNine,
  ),
  ViewModels(
    text: 'Information security',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partTen,
  ),
  ViewModels(
    text: 'Contact Information',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partEleven,
  ),

  ViewModels(
    text: 'Advertising AdMob',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partSix,
  ),

  ViewModels(
      text: '',
      textStyle: TextStyle(fontWeight: FontWeight.bold,
      ),
      gestureDetector: GestureDetector(
        child: Text('•	AdMob',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),

];

