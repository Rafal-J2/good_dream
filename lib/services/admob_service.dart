import 'dart:io';


class AdMobService {

  String? getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1694522060476593/2285006502';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1694522060476593/2285006502';
    }
    return null;
  }

  String? getBannerAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1694522060476593/2285006502';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1694522060476593/2285006502';
    }
    return null;
  }
}

String? getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-1694522060476593/2285006502';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-1694522060476593/2285006502';
  }
  return null;
}

String? getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-1694522060476593/2285006502';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-1694522060476593/2285006502';
  }
  return null;
}


