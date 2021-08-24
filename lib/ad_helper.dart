import 'dart:io';


class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9422636709954710/7985638637';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9422636709954710/7985638637';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9422636709954710/2350238389";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9422636709954710/2350238389";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

}