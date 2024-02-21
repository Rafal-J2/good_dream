import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'launch_url.dart';
import 'privacy_policy.dart';

Widget privacyPolicyDialog() {
  return SizedBox(
    height: 300.0,
    width: 300.0,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: privacyPolicyContent.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            GestureDetector(
              onTap: privacyPolicyContent[index].onTap,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  privacyPolicyContent[index].privacyPolicyContent!,
                  style: privacyPolicyContent[index].headerTextStyle,
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

Widget acknowledgmentsDialog() {
  return SizedBox(
    height: 300.0, 
    width: 300.0, 
    child: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Acknowledgments',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(acknowledgments),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 24.0,
          ),
          child: GestureDetector(
            child: const Text('•	www.flaticon.com',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
            onTap: () => launchURL2(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(acknowledgments2),
        ),
      ],
    ),
  );
}
