
import 'package:app_links/app_links.dart';
// import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/event/event_screen.dart';

Future<void> initDeepLinks() async {
  var appLinks = AppLinks();

  // Check initial link if app was in cold state (terminated)
  // final appLink = await _appLinks.getInitialAppLink();
  // if (appLink != null) {
  //   // print('Initial link: ${appLink.toString()}');
  // }

  // Handle link when app is in warm state (front or background)
  appLinks.uriLinkStream.listen((uri) async {
    // print('uri: ' + uri.toString());
    if (uri.toString().contains('firebaseauth')) {
      // return;
    } else {
      if (uri
          .toString()
          .replaceAll('appterrarium:', '')
          .contains('gettickets')) {
        Get.toNamed(EventScreen.routeName);
      }
    }
  });
}
