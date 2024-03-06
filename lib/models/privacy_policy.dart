import 'package:flutter/material.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import '../constants/dialogs.dart';
import '../services/launch_url.dart';

class PrivacyPolicyContent {
  String? privacyPolicyContent;
  TextStyle? headerTextStyle;
  VoidCallback? onTap;

  PrivacyPolicyContent({
    this.privacyPolicyContent,
    this.headerTextStyle,
    this.onTap,
  });

  factory PrivacyPolicyContent.withBoldHeader(
      {String? privacyPolicyContent, VoidCallback? onTap}) {
    return PrivacyPolicyContent(
        privacyPolicyContent: privacyPolicyContent,
        headerTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: onTap);
  }
}

final List<PrivacyPolicyContent> privacyPolicyContent = [
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: 'Privacy Policy',
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: privacyPolicy,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: "Consent",
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: consent,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: "ADS",
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: ads,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: 'Personal Information',
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: personalInformation,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: 'Links to Other Sites',
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: linksToOtherSitesGNU,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: 'Collection of Technical Data',
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: collectionOfTechnicalData,
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: '•	Google Play Services',
    headerTextStyle: ThemeTextStyles.textStyleForUrlLauncher,
    onTap: UrlLauncherService().launchPrivacyPolicyUrl,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: "Children's Privacy Protection",
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: childrensPrivacyGNU,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: 'Cookies',
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: cookies,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: 'Information security',
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: informationSecurity,
  ),
  PrivacyPolicyContent.withBoldHeader(
    privacyPolicyContent: 'Contact Information ',
  ),
  PrivacyPolicyContent(
    privacyPolicyContent: contactInformation,
  ),
];
