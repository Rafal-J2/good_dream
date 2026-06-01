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
    text: privacyPolicyIntro,
  ),
  PrivacyPolicyContent(
    text: 'Information We Collect',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyCollect,
  ),
  PrivacyPolicyContent(
    text: 'How We Use Information',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyUse,
  ),
  PrivacyPolicyContent(
    text: 'Third-Party Services',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyThirdParty,
  ),
  PrivacyPolicyContent(
    text: '•	Google Play Services',
    type: PrivacyPolicyContentType.link,
    url: 'google_privacy',
  ),
  PrivacyPolicyContent(
    text: 'Data Retention',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyRetention,
  ),
  PrivacyPolicyContent(
    text: 'International Data Transfers',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyTransfers,
  ),
  PrivacyPolicyContent(
    text: "Children's Privacy",
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyChildren,
  ),
  PrivacyPolicyContent(
    text: 'Security',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicySecurity,
  ),
  PrivacyPolicyContent(
    text: 'Your Rights',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyRights,
  ),
  PrivacyPolicyContent(
    text: 'Changes to This Privacy Policy',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyChanges,
  ),
  PrivacyPolicyContent(
    text: 'Contact Us',
    type: PrivacyPolicyContentType.header,
  ),
  PrivacyPolicyContent(
    text: privacyPolicyContact,
  ),
];
