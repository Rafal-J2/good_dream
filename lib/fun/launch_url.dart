import 'package:url_launcher/url_launcher.dart';


final Uri _url = Uri.parse('https://policies.google.com/privacy');
Future<void> launchURL() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}



Future<void> launchURL5() async {
  final Uri url = Uri.parse('https://www.flaticon.com');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}


