import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfig {
  static final remoteConfig = FirebaseRemoteConfig.instance;
  static initRemoteConfig() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ));

    await remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();

      debugPrint(
          'diamond_promotion_event: ${event.updatedKeys.contains('diamond_promotion')}');
      debugPrint(
          'system_maintenance: ${event.updatedKeys.contains('system_maintenance')}');
    });
  }

  static bool getDataByKeyBool(String key) {
    return remoteConfig.getBool(key);
  }

  static String getDataByKeyString(String key) {
    return remoteConfig.getString(key);
  }

  static double getDataByKeyDouble(String key) {
    return remoteConfig.getDouble(key);
  }

  static int getDataByKeyInt(String key) {
    return remoteConfig.getInt(key);
  }

  static RemoteConfigValue getDataByKey(String key) {
    return remoteConfig.getValue(key);
  }
}
