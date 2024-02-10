import 'package:flutter/material.dart';
import 'package:good_dream/models/ViewModels.dart';
import 'dialogs.dart';
import 'launch_url.dart';

List<ViewModels> get models5 => arrays5;
final arrays5 = [
  ViewModels(
    text: 'Privacy Policy',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partOne,
  ),
  ViewModels(
    text: "Personal Information",
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partTwo,
  ),
  ViewModels(
    text: 'Consent',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partThree,
  ),
  ViewModels(
    text: 'Information Collection and Use',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partFour,
  ),
  ViewModels(
    text: 'Links to Other Sites',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partFive,
  ),

  ViewModels(
    text: 'Analytics',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partSeven,
  ),

  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: const Text('•	Google Play Services',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),
  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: const Text('•	Google Analytics for Firebase',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),
  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: const Text('•	Firebase Crashlytics',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),

  ViewModels(
    text: 'Children’s Privacy',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partEight,
  ),
  ViewModels(
    text: 'Cookies',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partNine,
  ),
  ViewModels(
    text: 'Information security',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partTen,
  ),
  ViewModels(
    text: 'Contact Information',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partEleven,
  ),

  ViewModels(
    text: 'Advertising AdMob',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partSix,
  ),

  ViewModels(
      text: '',
      textStyle: const TextStyle(fontWeight: FontWeight.bold,
      ),
      gestureDetector: GestureDetector(
        child: const Text('•	AdMob',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),

];

