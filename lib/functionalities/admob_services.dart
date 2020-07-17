import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if(Platform.isAndroid) {
      return 'ca-app-pub-2657735445800645~8140747382';
    }
    return null;
  }

  String getBannerAdId() {
    if(Platform.isAndroid) {
//      return 'ca-app-pub-3940256099942544/6300978111';
      return 'ca-app-pub-2657735445800645/3902119477';
    }
    return null;
  }

}