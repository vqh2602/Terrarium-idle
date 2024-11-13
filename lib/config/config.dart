import 'package:flutter/material.dart';
import 'package:terrarium_idle/c_theme/c_theme.dart';

class Env {
  static late ModuleConfig config;
}

class ModuleConfig {
  String flavor = 'base';
  String baseUrl = '';
  String idADSNativeAndroid = '';
  String idADSNativeIos = '';
  String idADSInterstitialAdAndroid = '';
  String idADSInterstitialAdIos = '';
  String idRewardedAdAndroid = '';
  String idRewardedAdIos = '';
  String botToken =
      'MTE5MjY1OTU2NTA3MDc4NjYxMQ.G94xyR.vWuQ82qEFONP0bcw2DW4pP2vzGPD6cnqZb0XpQ';
  String channelId = '1279471257296834580';
  String imgurApi = 'https://api.imgur.com';

  String productId1000Gemstone = 'com.vqh2602.terrarium.1000gem';
  String productId500Gemstone = 'com.vqh2602.terrarium.500gem';
  String productId200Gemstone = 'com.vqh2602.terrarium.200gem';

  String firebaseprojectId = 'terrarium-i';
  String firebaseprojectNumber = '38854833849';
  String dataServer = 'https://vqh2602.github.io/terrarium_data.github.io';

  ThemeData lightTheme = SThemeTask.lightTheme;
  ThemeData darkTheme = SThemeTask.darkTheme;
}
