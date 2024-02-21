import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://policies.google.com/privacy');
Future<void> launchURL() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

final Uri _url2 = Uri.parse('https://www.flaticon.com');
Future<void> launchURL2() async {
  if (!await launchUrl(_url2)) {
    throw Exception('Could not launch $_url');
  }
}
