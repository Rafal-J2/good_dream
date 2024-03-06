import 'package:flutter/material.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import '../constants/dialogs.dart';
import '../services/launch_url.dart';
import '../models/privacy_policy.dart';




Widget privacyPolicyDialog(BuildContext context) {
  Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
  return SizedBox(
    height: imageSize['heightDialog'],
    width: imageSize['widthDialog'],
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: privacyPolicyContent.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: privacyPolicyContent[index].onTap,
          child: Padding(
            padding: AppPaddings.paddingForDialogs,
            child: Text(
              privacyPolicyContent[index].privacyPolicyContent ?? "Default content",
              style: privacyPolicyContent[index].headerTextStyle,
            ),
          ),
        );
      },
    ),
  );
}

Widget acknowledgmentsDialog(BuildContext context) {
  Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
  return SizedBox(
     height: imageSize['heightDialog'],
    width: imageSize['widthDialog'],
    child: ListView(
      children: [
        const Padding(
          padding: AppPaddings.paddingForTitle,
          child: Text(
            'Acknowledgments',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: AppPaddings.paddingForDialogs,
          child: Text(acknowledgments),
        ),
        Padding(
          padding: AppPaddings.paddingForUrlLauncher, 
          child: GestureDetector(
            child: const Text('•	www.flaticon.com',
                style: ThemeTextStyles.textStyleForUrlLauncher),
            onTap: () => UrlLauncherService().launchFlaticonUrl(),
          ),
        ),
        Padding(
          padding: AppPaddings.paddingForDialogs,
          child: Text(acknowledgments2),
        ),
      ],
    ),
  );
}
