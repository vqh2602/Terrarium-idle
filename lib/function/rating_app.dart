import 'package:in_app_review/in_app_review.dart';

ratingAppInApp() async {
  final InAppReview inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  }
}

ratingAppInStore() async {
  final InAppReview inAppReview = InAppReview.instance;
  inAppReview.openStoreListing(appStoreId: '6502242384');
}
