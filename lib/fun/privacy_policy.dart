import 'package:flutter/material.dart';
import 'package:good_dream/models/view_models.dart';
import 'dialogs.dart';
import 'launch_url.dart';

List<ViewModels> get models5 => arrays5;
final arrays5 = [
  ViewModels(
    privacyPolicySections: 'Privacy Policy',
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: privacyPolicy,
  ),
  ViewModels(
    privacyPolicySections: "Consent",
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: consent,
  ),
  ViewModels(
    privacyPolicySections: "ADS",
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: ads,
  ),
  ViewModels(
    privacyPolicySections: 'Personal Information',
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: personalInformation,
  ),
  ViewModels(
    privacyPolicySections: 'Links to Other Sites',
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: linksToOtherSitesGNU,
  ),
  ViewModels(
    privacyPolicySections: 'Collection of Technical Data',
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: collectionOfTechnicalData,
  ),
  ViewModels(
      privacyPolicySections: '',
      gestureDetector: GestureDetector(
        child: const Text('•	Google Play Services',
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue)),
        onTap: () => launchURL(),
      )),
  ViewModels(
    privacyPolicySections: "Children's Privacy Protection",
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: childrensPrivacyGNU,
  ),
  ViewModels(
    privacyPolicySections: 'Cookies',
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: cookies,
  ),
  ViewModels(
    privacyPolicySections: 'Information security',
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: informationSecurity,
  ),
  ViewModels(
    privacyPolicySections: 'Contact Information ',
    policyHeaderTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    privacyPolicySections: contactInformation,
  ),
];
