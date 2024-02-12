
import 'package:flutter/material.dart';
import 'dialogs.dart';
import 'launch_url.dart';
import 'privacy_policy.dart';

Widget setupAlertDialogContainer() {
  return SizedBox(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: arrays5.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Padding(padding: const EdgeInsets.all(16.0),
              child: arrays5[index].gestureDetector,),
            Text(
              arrays5[index].text!,
              style: arrays5[index].textStyle,
            ),
          ],
        );
      },
    ),
  );
}

Widget showMyDialog3() {
  return SizedBox(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
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
                    decoration: TextDecoration.underline,
                    color: Colors.blue)),
            onTap: () => launchURL5(),
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