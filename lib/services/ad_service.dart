import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdService {
  static final String bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-5219793941962827/9673448955' // Real banner ad unit
      : 'ca-app-pub-3940256099942544/2934735716'; // iOS test ad unit

  static final String interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-5219793941962827/6125920333' // Real interstitial ad unit
      : 'ca-app-pub-3940256099942544/4411468910'; // iOS test ad unit

  InterstitialAd? _interstitialAd;

  /// Loads an interstitial ad.
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Shows the interstitial ad if it is loaded.
  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadInterstitialAd(); // Pre-load the next ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadInterstitialAd(); // Pre-load the next ad
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }
}
