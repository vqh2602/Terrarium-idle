import 'package:terrarium_idle/data/local/user.dart';
import 'package:terrarium_idle/mixin/user_mixin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

class FirebaseAnalyticsService with UserMixin {
  appAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
  // evenFistOpen() async {
  //   UserData user = getUserInBox();
  //   await _analytics.setUserId(id: user.);
  //   await _analytics.logAppOpen();
  // }

  // evenBuyApp() async {
  //   await _analytics.logEvent(name: "buy_app", parameters: {});
  // }

  // evenRemoveApp() async {
  //   await _analytics.logEvent(
  //     name: "app_remove",
  //   );
  // }
}
