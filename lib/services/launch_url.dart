import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  final Uri _privacyPolicyUrl = Uri.parse('https://policies.google.com/privacy');
  final Uri _flaticonUrl = Uri.parse('https://www.flaticon.com');

  Future<void> launchPrivacyPolicyUrl() async {
    if (!await launchUrl(_privacyPolicyUrl)) {
      throw 'Could not launch $_privacyPolicyUrl';
    }
  }

  Future<void> launchFlaticonUrl() async {
    if (!await launchUrl(_flaticonUrl)) {
      throw 'Could not launch $_flaticonUrl';
    }
  }
}
