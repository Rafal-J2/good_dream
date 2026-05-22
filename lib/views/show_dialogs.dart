import 'package:flutter/material.dart';
import 'package:good_dream/style/theme_text_styles.dart';
import '../constants/dialogs.dart';
import '../services/launch_url.dart';
import '../models/privacy_policy.dart';

Widget privacyPolicyDialog(BuildContext context) {
  final Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
  final launcher = UrlLauncherService();
  return SizedBox(
    height: imageSize['heightDialog'],
    width: imageSize['widthDialog'],
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: privacyPolicyContent.length,
      itemBuilder: (BuildContext context, int index) {
        final item = privacyPolicyContent[index];
        TextStyle? textStyle;
        VoidCallback? onTap;

        switch (item.type) {
          case PrivacyPolicyContentType.header:
            textStyle = const TextStyle(fontWeight: FontWeight.bold);
            break;
          case PrivacyPolicyContentType.link:
            textStyle = ThemeTextStyles.textStyleForUrlLauncher;
            if (item.url == 'google_privacy') {
              onTap = launcher.launchPrivacyPolicyUrl;
            }
            break;
          case PrivacyPolicyContentType.body:
            textStyle = null; // default style
            break;
        }

        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: AppPaddings.paddingForDialogs,
            child: Text(
              item.text,
              style: textStyle,
            ),
          ),
        );
      },
    ),
  );
}

Widget acknowledgmentsDialog(BuildContext context) {
  final Map<String, double> imageSize = MediaQuerySize.getImageSize(context);
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
