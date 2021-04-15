import 'package:url_launcher/url_launcher.dart';

  launchURL() async {
    const url = 'https://policies.google.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURL2() async {
    const url = 'https://support.google.com/admob/answer/6128543?hl=en';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURL3() async {
    const url = 'https://firebase.google.com/policies/analytics';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURL4() async {
    const url = 'https://firebase.google.com/support/privacy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURL5() async {
    const url = 'https://www.flaticon.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void switch2(){
    String url = 'A';
    switch(url) {
      case 'A':
        print('test');
        break;

      case 'B' :
        print('test2');

    }
  }

