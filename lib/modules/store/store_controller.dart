import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:terrarium_idle/config/config.dart';
import 'package:terrarium_idle/data/local/list_items.dart';
import 'package:terrarium_idle/data/local/list_plants.dart';
import 'package:terrarium_idle/data/local/list_pots.dart';
import 'package:terrarium_idle/data/models/item.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';

class StoreController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, FireStoreMixin {
  UserController userController = Get.find();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> products = [];
  ProductDetails? productSelect;

  List<ItemData> listStorePlants = [];

  List<ItemData> listStorePots = [];

  List<ItemData> listStoreItems = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    initDataList();
    await initStreamPurchase();
    changeUI();
  }

  initDataList() {
    listStorePlants = listPlantsData
        .where((plant) =>
            !(userController.user?.cart?.cartPlants?.contains(plant.id) ??
                false))
        .toList();
    listStorePlants.sort((a, b) => a.levelUnlock!.compareTo(b.levelUnlock!));
    listStorePots = listPotsData
        .where((pot) =>
            !(userController.user?.cart?.cartPots?.contains(pot.id) ?? false))
        .toList();
    listStorePots.sort((a, b) => a.levelUnlock!.compareTo(b.levelUnlock!));
    listStoreItems = listItemsData;
    update();
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
    Set<String> kIds = <String>{
      Env.config.productId1000Gemstone,
      Env.config.productId500Gemstone,
      Env.config.productId200Gemstone,
    };
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
    // if (await InAppPurchase.instance
    //     .buyNonConsumable(purchaseParam: purchaseParam)) {}

    // user = user?.copyWith(
    //     latestPurchaseDate: DateTime.parse(
    //         customerInfo!.entitlements.all["premium"]!.latestPurchaseDate),
    //     identifier:
    //         customerInfo!.entitlements.all["premium"]?.productIdentifier);
    // await saveUserInBox(user: user!);
    // buildToast(
    //     message: 'Mua hàng thành công'.tr, status: TypeToast.toastSuccess);
    // await firebaseAnalyticsService.evenBuyApp();
    // clearAndResetApp();
// From here the purchase flow will be handled by the underlying store.
// Updates will be delivered to the `InAppPurchase.instance.purchaseStream`.
  }

  Future<void> restorePucharses() async {
    // loadingUI();
    // try {
    //   customerInfo = await Purchases.restorePurchases();
    //   // ... check restored purchaserInfo to see if entitlement is now active
    //   try {
    //     if (customerInfo?.entitlements.all["premium"]?.isActive ?? false) {
    //       // Unlock that great "pro" content
    //       user = user?.copyWith(
    //           latestPurchaseDate: DateTime.parse(customerInfo!
    //               .entitlements.all["premium"]!.latestPurchaseDate),
    //           identifier:
    //               customerInfo!.entitlements.all["premium"]?.productIdentifier);
    //       saveUserInBox(user: user!);
    //       buildToast(
    //           message: 'Khôi phục thành công'.tr,
    //           status: TypeToast.toastSuccess);
    //       await box.write(Storages.dataRenewSub, true);
    //       clearAndResetApp();
    //     } else {
    //       user = user?.copyWith(latestPurchaseDate: null, identifier: null);
    //       saveUserInBox(user: user!);
    //       buildToast(
    //           message: 'Khôi phục thất bại'.tr, status: TypeToast.toastError);
    //       await box.write(Storages.dataRenewSub, false);
    //     }
    //   } on PlatformException catch (e) {
    //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
    //     if (errorCode != PurchasesErrorCode.purchaseCancelledError) {}
    //   }

    //   //print('khôi phục mua hàng: ${customerInfo?.entitlements.all}');
    // } catch (e) {
    //   //print('lỗi mua hàng: ${e}');
    // }
    // changeUI();
  }

  buyItems(UserData? user) async {
    await userController.updateUser(userData: user);
    // if (result != null) {
    // userController.user = result;
    // userController.update();
    initDataList();
    // }
  }

  String? getStringLockLevel(num level) {
    return (userController.user?.user!.userLevel ?? 0) < level
        ? 'Level $level'
        : null;
  }

  buyItemStore(ItemData item) {
    if (checkMoney(item)) {
      switch (item.type) {
        case 'plant':
          List<String> addNew = (userController.user?.cart?.cartPlants ?? []);
          addNew.add(item.id ?? '');
          buyItems(userController.user?.copyWith(
              cart: userController.user?.cart?.copyWith(
            cartPlants: addNew,
          )));
          break;
        case 'pot':
          List<String> addNew = (userController.user?.cart?.cartPots ?? []);
          addNew.add(item.id ?? '');
          buyItems(userController.user?.copyWith(
            cart: userController.user?.cart?.copyWith(
              cartPots: addNew,
            ),
          ));
          break;
        case 'item':
          Item? itemNew = userController.user?.item;
          Money? moneyNew = userController.user?.money;
          if (item.id == 'item1') {
            itemNew?.fertilizer = (itemNew.fertilizer ?? 0) + 10;
            buyItems(userController.user?.copyWith(
                item: userController.user?.item!
                    .copyWith(fertilizer: itemNew?.fertilizer)));
          }
          if (item.id == 'item2') {
            itemNew?.shovel = (itemNew.shovel ?? 0) + 1;
            buyItems(userController.user?.copyWith(
                item: userController.user?.item!
                    .copyWith(shovel: itemNew?.shovel)));
          }
          if (item.id == 'item3') {
            moneyNew = moneyNew?.copyWith(oxygen: (moneyNew.oxygen ?? 0) + 175);
            buyItems(userController.user?.copyWith(money: moneyNew));
          }
          break;
        default:
          // Xử lý khi không có loại nào khớp
          break;
      }
    }
  }

  bool checkMoney(ItemData item) {
    switch (item.currencyUnit) {
      case 'oxygen':
        if ((userController.user?.money?.oxygen ?? 0) <
            (item.priceStore ?? 1)) {
          buildToast(
              message: 'Không đủ oxygen', status: TypeToast.toastDefault);
          return false;
        }
        userController.user = userController.user?.copyWith(
            money: userController.user?.money?.copyWith(
          oxygen: (userController.user?.money?.oxygen ?? 0) -
              (item.priceStore ?? 0),
        ));
        userController.update();
        return true;

      case 'gemstone':
        if ((userController.user?.money?.gemstone ?? 0) <
            (item.priceStore ?? 1)) {
          buildToast(
              message: 'Không đủ gemstone', status: TypeToast.toastDefault);
          return false;
        }
        userController.user = userController.user?.copyWith(
            money: userController.user?.money?.copyWith(
          gemstone: (userController.user?.money?.gemstone ?? 0) -
              (item.priceStore ?? 0),
        ));
        userController.update();
        return true;

      case 'ticket':
        if ((userController.user?.money?.ticket ?? 0) <
            (item.priceStore ?? 1)) {
          buildToast(
              message: 'Không đủ ticket', status: TypeToast.toastDefault);
          return false;
        }
        userController.user = userController.user?.copyWith(
            money: userController.user?.money?.copyWith(
          ticket: (userController.user?.money?.ticket ?? 0) -
              (item.priceStore ?? 0),
        ));
        return true;

      default:
        // Xử lý khi không có loại nào khớp
        return false;
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
