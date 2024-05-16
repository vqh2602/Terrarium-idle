import 'package:firebase_auth/firebase_auth.dart';
import 'package:terrarium_idle/mixin/user_mixin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

class FirebaseAnalyticsService with UserMixin {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  appAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
  evenFistOpen() async {
    User? user = firebaseAuth.currentUser;
    await _analytics.setUserId(id: user?.uid);
    await _analytics.logAppOpen();
  }

  evenBuyAppSandbox() async {
    await _analytics.logEvent(name: "buy_app_sandbox", parameters: {});
  }

  evenBuyApp() async {
    await _analytics.logEvent(name: "buy_app", parameters: {});
  }

  evenRemoveApp() async {
    await _analytics.logEvent(
      name: "app_remove",
    );
  }
}
