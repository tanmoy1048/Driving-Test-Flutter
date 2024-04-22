import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../service/const.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({super.key});

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  late BannerAdListener bannerAdListener;
  bool isLoaded = false;
  late BannerAd bannerAd;

  @override
  void initState() {
    super.initState();
    bannerAdListener = BannerAdListener(onAdClosed: (ad) {
      debugPrint("Ad Got Closeed");
    }, onAdLoaded: (ad) {
      if (mounted) {
        isLoaded = true;
        setState(() {});
      }
    });
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Strings.getBannerAdIdAndroid(),
      listener: bannerAdListener,
      request: const AdRequest(),
    );

    bannerAd.load();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            padding: const EdgeInsets.all(4),
            height: bannerAd.size.height.toDouble(),
            child: AdWidget(ad: bannerAd),
          )
        : const SizedBox();
  }
}
