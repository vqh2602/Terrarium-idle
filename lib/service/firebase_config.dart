import 'package:firebase_remote_config/firebase_remote_config.dart';

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

      // Use the new config values here.
    });
  }
}
