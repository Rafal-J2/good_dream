import 'package:flutter/material.dart';
import 'package:good_dream/models/view_models.dart';
import 'dialogs.dart';
import 'launch_url.dart';

List<ViewModels> get models5 => arrays5;
final arrays5 = [
  ViewModels(
    text: 'Privacy Policy',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: privacyPolicy,
  ),
  ViewModels(
    text: "Consent",
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: consent,
  ),
  ViewModels(
    text: "ADS",
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: ads,
  ),
  ViewModels(
    text: 'Personal Information',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: personalInformation,
  ),
  ViewModels(
    text: 'Links to Other Sites',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: linksToOtherSitesGNU,
  ),
  ViewModels(
    text: 'Collection of Technical Data',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: collectionOfTechnicalData,
  ),
  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: const Text('•	Google Play Services',
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue)),
        onTap: () => launchURL(),
      )),
  ViewModels(
    text: "Children's Privacy Protection",
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: childrensPrivacyGNU,
  ),
  ViewModels(
    text: 'Cookies',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: cookies,
  ),
  ViewModels(
    text: 'Information security',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: informationSecurity,
  ),
  ViewModels(
    text: 'Contact Information ',
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: contactInformation,
  ),
];
