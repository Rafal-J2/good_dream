import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:good_dream/models/ViewModels.dart';

import 'launch_url.dart';

List<ViewModels> get models5 => arrays5;
final arrays5 = [
  ViewModels(
    text: 'Privacy Policy',
   textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partOne,
  ),
  ViewModels(
    text: "Personal Information",
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partTwo,
  ),
  ViewModels(
    text: 'Consent',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partThree,
  ),
 ViewModels(
    text: 'Information Collection and Use',
     textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partFour,
  ),
  ViewModels(
    text: 'Links to Other Sites',
      textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partFive,
  ),

  ViewModels(
    text: 'Analytics',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partSeven,
  ),

  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: Text('•	Google Play Services',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),
 ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: Text('•	Google Analytics for Firebase',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),
  ViewModels(
      text: '',
      gestureDetector: GestureDetector(
        child: Text('•	Firebase Crashlytics',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),

  ViewModels(
    text: 'Children’s Privacy',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partEight,
  ),
  ViewModels(
    text: 'Cookies',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partNine,
  ),
  ViewModels(
    text: 'Information security',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partTen,
  ),
  ViewModels(
    text: 'Contact Information',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partEleven,
  ),

  ViewModels(
    text: 'Advertising AdMob',
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  ViewModels(
    text: partSix,
  ),

  ViewModels(
      text: '',
      textStyle: TextStyle(fontWeight: FontWeight.bold,
      ),
      gestureDetector: GestureDetector(
        child: Text('•	AdMob',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue)),
        onTap: () => launchURL2(),
      )
  ),

];

String partOne =
    "Our Privacy Policy (“Privacy Policy”) helps you understand how we collect, use and safeguard the information you provide to us and to assist you in making informed decisions when using our Service";

// Personal Information
String partTwo =
    "We Don’t Collect Any Personal Information with Our Applications"
    "When you download and use our mobile applications, we don’t require you to provide any information and we don’t collect any information about you. "
    "In other words, we do not collect information such as your full name, address, phone number or email address.";

// Consent
String partThree =
    "By using our website, you hereby consent to our Privacy Policy and agree to its terms.";

//Log Data *
String partThree2 = "";

// Information Collection and Use *
String partFour =
    "We collect several different types of information for various purposes to provide and"
    "improve our Service to you.";

//Links to Other Sites  GNU
String partFive =
    "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated. Therefore,strongly advise you to review the Privacy Policy of these websites. "
    "I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.";

//Advertising AdMob

String partSix =
    "These services allow User Data to be utilized for advertising communication purposes displayed in the form of banners and other advertisements on this Application, possibly based on User interests."
    "This does not mean that all Personal Data are used for this purpose."
    " --- AdMob (AdMob Google Inc.) --- "
    "AdMob is an advertising service provided by AdMob Google Inc. "
    "Information and conditions of use are shown below.";
//"AdMob collected: Cookie and Usage data. --- "
//"Place of processing: USA – Privacy Policy --- ";

//Analytics *
String partSeven =
    "We collect some anonymous usage information to help us improve our apps. We use third party analytics services "
    "(Google Analytics, Firebase, Firebase Crashlytics) that may collect data as a device type and OS, an app identifier, unique device identifiers, app session time, events and lengths."
    "We do not exchange these information with any other Third Parties Google Analytics (Google Inc.)Google Analytics is a web analysis service provided by Google Inc."
    "(“Google”). Google utilizes the Data collected to track and examine the use of this Application, to prepare reports on its activities and share them with other Google services."
    "Google may use the Data collected to contextualize and personalize the ads of its own advertising network. Analytics collected: Cookie and Usage data. Place of processing: USA – Privacy Policy"
    "Information and conditions of use are shown below.";

//Children’s Privacy ** GNU
String partEight =
    "Our Services do not address anyone under the age of 13. We do not knowingly collect personal identifiable information from children under 13."
    " In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. "
    "If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.";

// Cookies
String partNine =
    "A cookie is a file containing an identifier (a string of letters and numbers) that is sent by a web server to a web browser and is stored by the browser. "
    "The identifier is then sent back to the server each time the browser requests a page from the server."
    "This Service does not use these “cookies” explicitly. However,  third parties that advertise goods or services in our App or website may use cookies to track your use of the Service. "
    "We advise you to check the privacy policies of these Advertisers for information about their cookie usage and other privacy practices. "
    "Advertisers may also use cookies to track your online activities across websites over time to provide interest-based advertising.";

//Information security *
String partTen =
    "Security of our users' information is a priority. However, while we take responsible measures to protect your Personal Information, the internet is not a 100% secure environment. "
    "We cannot guarantee the absolute security of all information transmitted or electronically stored. We disclaim any liability for any unauthorized access to, disclosure or damage to, theft of, or loss of any Personal Information. "
    "By using our App, you acknowledge that you understand and agree to assume these risks.";

//Contact Information *
String partEleven =
    "If you have any questions, comments or complaints about this Privacy Policy, please contact us as follows: you may email us at Dev.Software15@gmail.com We will respond within a reasonable amount time.";

String acknowledgments =
    "Icons made by Freepik from Flaticon - www.flaticon.com";
String acknowledgments2 =
    "Icons Train made by Smashicons www.flaticon.com/authors/smashicons - Icons Emotional Piano made by Those Icons www.flaticon.com/authors/those-icons";
