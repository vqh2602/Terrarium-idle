import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/mixin/user_mixin.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/service/firebase_config.dart';
import 'package:terrarium_idle/widgets/base/text/text_style.dart';
import 'package:terrarium_idle/widgets/image_custom.dart';

class GiftController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin {
  UserController userController = Get.find();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> products = [];
  ProductDetails? productSelect;
  UserData? userData = UserData();

  @override
  Future<void> onInit() async {
    super.onInit();

    userData = await userController.getUserData();
    await initStreamPurchase();

    changeUI();
  }

  /// lấy dữ liệu câu shình khuyến mãi
  Widget getDataConfigGiftGems() {
    var result = RemoteConfig.getDataByKeyBool('diamond_promotion');
    DateTime isShow =
        DateTime.tryParse(box.read('diamond_promotion').toString()) ??
            DateTime(1999);
    if (result && DateTime.now().difference(isShow).inDays > 7) {
      return GestureDetector(
        onTap: () {
          Get.defaultDialog(
            title: 'Thông báo'.tr,
            titleStyle: STextTheme.bodyMedium
                .value(Get.context!)
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            content: Container(
              child: imageNetwork(
                  url: 'https://iili.io/2TmwITJ.md.png',
                  height: Get.height * 0.7),
            ),
            backgroundColor: Colors.white,
            onConfirm: () async {
              await buyApp(products
                  .where((element) =>
                      element.id == 'com.vqh2602.terrarium.1000gem.promotion')
                  .first);
              await box.write('diamond_promotion', DateTime.now().toString());
              result = false;
              update();
              Get.back();
            },
            onCancel: () async {
              await box.write('diamond_promotion', DateTime.now().toString());
              result = false;
              Get.back();
              update();
            },
            barrierDismissible: false,
            textConfirm: 'Dùng khuyến mãi'.tr,
            textCancel: 'Không hiển thị lại'.tr,
          );
        },
        child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.yellowAccent.withOpacity(0.3),
                  Colors.yellowAccent.withOpacity(0.05)
                ],
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            width: Get.width * 0.2,
            height: Get.width * 0.2,
            child: Image.asset(Assets.images.gift.path)),
      );
    }
    return Container();
  }

  initStreamPurchase() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      // print('purchased done');
      _subscription.cancel();
    }, onError: (Object error) {
      // print('err: $error');
      _subscription.cancel();
    });
    initStoreInfo();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      return;
    }

    // Set literals require Dart 2.2. Alternatively, use
// `Set<String> _kIds = <String>['product1', 'product2'].toSet()`.
    Set<String> kIds = <String>{'com.vqh2602.terrarium.1000gem.promotion'};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    products = response.productDetails;
    products.sort(
        (ProductDetails a, ProductDetails b) => a.price.compareTo(b.price));

    // productSelect = products.firstOrNull;
    update();
  }

  Future<void> buyApp(ProductDetails productDetails) async {
    loadingUI();
    // if (productSelect == null) return;
    // final ProductDetails productDetails = productSelect!;
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);

    if (await InAppPurchase.instance
        .buyConsumable(purchaseParam: purchaseParam)) {
      if (kDebugMode) {
        print('Hiện bảng mua hàng');
      }
    } else {
      if (kDebugMode) {
        print('khôgn hiện bảng');
      }
    }
    changeUI();
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        if (kDebugMode) {
          print('đang load mua hàng');
        }
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          if (kDebugMode) {
            print('Lỗi mua hàng');
          }
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (kDebugMode) {
            print('mua/ khôi phục thành công');
          }
          userController.updateUser(
              userData: userController.user?.copyWith(
                  money: userController.user?.money?.copyWith(
                      gemstone: (userController.user?.money?.gemstone ?? 0) +
                          (purchaseDetails.productID.contains('1000')
                              ? 1000
                              : purchaseDetails.productID.contains('500')
                                  ? 500
                                  : 200))));
          // final bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   unawaited(deliverProduct(purchaseDetails));
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          //   return;
          // }
        }
        if (Platform.isAndroid) {
          // if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
          //   final InAppPurchaseAndroidPlatformAddition androidAddition =
          //       _inAppPurchase.getPlatformAddition<
          //           InAppPurchaseAndroidPlatformAddition>();
          //   await androidAddition.consumePurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        if (kDebugMode) {
          print('kết thúc thao tác');
        }
        // await _inAppPurchase.completePurchase(purchaseDetails);
        await _inAppPurchase.completePurchase(purchaseDetails);
        changeUI();
      }
    }
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
