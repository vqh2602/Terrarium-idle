import 'dart:io';

import 'package:terrarium_idle/config/config.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

mixin ADmodMixin {
  //-- khởi tạo quản cáo gốc
  Future<NativeAd> createADNative(
      {required Function onLoad, required Function onFaile}) async {
    NativeAd? myNative;
    myNative = NativeAd(
        adUnitId: Platform.isAndroid
            ? Env.config.idADSNativeAndroid
            : Env.config.idADSNativeIos,
        request: const AdRequest(),
        listener: NativeAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            onLoad();
          }
          // print('Ad loaded.')

          ,
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // Dispose the ad here to free resources.
            ad.dispose();
            onFaile();
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) {}
          // print('Ad opened.')
          ,
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {}
          // print('Ad closed.')
          ,
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {}
          // print('Ad impression.')
          ,
          // Called when a click is recorded for a NativeAd.
          onAdClicked: (Ad ad) {}
          //  print('Ad clicked.')
          ,
        ),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: TemplateType.medium,
            mainBackgroundColor: const Color(0xfffffbed),
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
    // await myNative.load();
    return myNative;
  }
  // void showNativeADS(){
  //   myNative.load();
  // }

  //== khởi tạo quảng cáo xen kẽ
  InterstitialAd? interstitialAd;
  createInitInterstitialAd() async {
    await InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? Env.config.idADSInterstitialAdAndroid
            : Env.config.idADSInterstitialAdIos,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
            interstitialAd?.fullScreenContentCallback =
                FullScreenContentCallback(
                    onAdShowedFullScreenContent: (InterstitialAd ad) {}
                    // print('%ad onAdShowedFullScreenContent.')
                    ,
                    onAdDismissedFullScreenContent: (InterstitialAd ad) {
                      // print('$ad onAdDismissedFullScreenContent.');
                      ad.dispose();
                    },
                    onAdFailedToShowFullScreenContent:
                        (InterstitialAd ad, AdError error) {
                      ad.dispose();
                    },
                    onAdImpression: (InterstitialAd ad) {}
                    // print('$ad impression occurred.'),
                    );
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));

    // interstitialAd?.show();
  }

// khởi tạo
  AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  int numInterstitialLoadAttempts = 0;

  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? rewardedInterstitialAd;
  int numRewardedInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  Future<bool> createRewardedAd() async {
    bool status = false;
    await RewardedAd.load(
        //ca-app-pub-5964552069889646/6710029729
        //  test
        // adUnitId: Platform.isAndroid
        //     ? 'ca-app-pub-3940256099942544/5224354917'
        //     : 'ca-app-pub-3940256099942544/1712485313',
        adUnitId: Platform.isAndroid
            ? Env.config.idRewardedAdAndroid
            : Env.config.idRewardedAdIos,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            // print('$ad loaded.');
            rewardedAd = ad;
            numRewardedLoadAttempts = 0;
            status = true;
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('RewardedAd failed to load: $error');
            rewardedAd = null;
            numRewardedLoadAttempts += 1;
            if (numRewardedLoadAttempts < maxFailedLoadAttempts) {
              createRewardedAd();
            }
          },
        ));
    return status;
  }

  Future<bool> showRewardedAd() async {
    if (rewardedAd == null) {
      buildToast(
          message: 'Không có quảng cáo'.tr, status: TypeToast.toastError);
      // print('Warning: attempt to show rewarded before loaded.');
      return false;
    }
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          // ignore: avoid_print
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        if (kDebugMode) {
          print('$ad onAdDismissedFullScreenContent.');
        }
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        if (kDebugMode) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
        }
        ad.dispose();
        createRewardedAd();
      },
    );

    await rewardedAd?.setImmersiveMode(true);
    await rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      if (kDebugMode) {
        print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      }
    });
    if (rewardedAd != null) {
      rewardedAd = null;
      return true;
    } else {
      rewardedAd = null;
      return false;
    }
  }
}
