import '../constants/dialogs.dart';

enum PrivacyPolicyContentType {
  header,
  body,
  link,
}

class PrivacyPolicyContent {
  final String text;
  final PrivacyPolicyContentType type;
  final String? url;

  const PrivacyPolicyContent({
    required this.text,
    this.type = PrivacyPolicyContentType.body,
    this.url,
  });
}

const List<PrivacyPolicyContent> privacyPolicyContent = [
  PrivacyPolicyContent(
    text: 'Privacy Policy',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicy,
  ),
  PrivacyPolicyContent(
    text: "Consent",
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: consent,
  ),
  PrivacyPolicyContent(
    text: "ADS",
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: ads,
  ),
  PrivacyPolicyContent(
    text: 'Personal Information',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: personalInformation,
  ),
  PrivacyPolicyContent(
    text: 'Links to Other Sites',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: linksToOtherSitesGNU,
  ),
  PrivacyPolicyContent(
    text: 'Collection of Technical Data',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: collectionOfTechnicalData,
  ),
  PrivacyPolicyContent(
    text: '•	Google Play Services',
    type: PrivacyPolicyContentType.link,
    url: 'google_privacy',
  ),
  PrivacyPolicyContent(
    text: "Children's Privacy Protection",
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: childrensPrivacyGNU,
  ),
  PrivacyPolicyContent(
    text: 'Cookies',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: cookies,
  ),
  PrivacyPolicyContent(
    text: 'Information security',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: informationSecurity,
  ),
  PrivacyPolicyContent(
    text: 'Contact Information ',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: contactInformation,
  ),
];
