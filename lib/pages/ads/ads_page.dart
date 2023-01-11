import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meme_app/widgets/text_button.dart';

class AdsPage extends StatefulWidget {
  AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initBannerAd();
    _initInterstitialAd();
  }

  void _initInterstitialAd() {
    InterstitialAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/1033173712",
      // adUnitId: "ca-app-pub-3940256099942544/8691691433",
      // my own test id
      adUnitId: "ca-app-pub-4441763398481537/7735811790",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: ((error) {}),
      ),
    );
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-4441763398481537/5116020337",
      // test id
      // adUnitId: "ca-app-pub-3940256099942544/6300978111",
      // adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {},
      ),
      request: AdRequest(),
    );

    _bannerAd.load();
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isInterstitialAdLoaded = true;

    _interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      // call some other event after ad shown

      _interstitialAd
          .dispose(); // need to dispose otherwise it will stay in memeory forever
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      _interstitialAd.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ads'),
      ),
      body: Center(
        child: TextBtn(
          color: Colors.black,
          onPress: () {
            if (_isInterstitialAdLoaded) {
              _interstitialAd.show();
            } else {
              print("Ad not loaded!!!!!!!!!!!!!!!!!!!!!!!!!!");
            }
          },
          text: 'Show Ad',
        ),
      ),
      bottomNavigationBar: _isBannerAdLoaded
          ? Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : Container(
              color: Colors.amber,
              height: 70,
            ),
    );
  }
}
