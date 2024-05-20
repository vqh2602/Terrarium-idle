import 'package:flutter/material.dart';
import 'package:flutx_ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:terrarium_idle/c_theme/colors.dart';
import 'package:terrarium_idle/data/local/list_plants.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/store/store_controller.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/compoment/tool_level.dart';
import 'package:terrarium_idle/widgets/image_custom.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});
  static const String routeName = '/store';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  StoreController storeController = Get.find();
  UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      backgroundColor: const Color(0xfffaf3e1),
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return storeController.obx((state) => userController.obx((state) => Stack(
          children: <Widget>[
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: DefaultTabController(
                initialIndex: 0,
                length: 4,
                child: Scaffold(
                  backgroundColor: bg500,
                  appBar: AppBar(
                    backgroundColor: bg500,
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    // title: const Text('TabBar Sample'),
                    leading: const SizedBox(),
                    bottom: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: <Widget>[
                        Tab(
                          child: textTitleMedium('Chậu',
                              textAlign: TextAlign.center),
                        ),
                        Tab(
                          child: textTitleMedium('Cây',
                              textAlign: TextAlign.center),
                        ),
                        Tab(
                          child: textTitleMedium('Đá quý',
                              textAlign: TextAlign.center),
                        ),
                        Tab(
                          child: textTitleMedium('Dụng cụ',
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      _listStorePots(),
                      _listStorePlants(),
                      _listStoreGems(),
                      _listStoreTools(),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SafeArea(
                  child: IconButton(
                    icon: const Icon(LucideIcons.chevronLeft),
                    onPressed: () => Get.back(),
                  ),
                ),
                Expanded(
                  child: userController.obx((state) => ToolLevel(
                        showLevel: false,
                        user: userController.user ?? UserData(),
                      )),
                ),
              ],
            )
          ],
        )));
  }

  Widget _listStorePots() {
    return SizedBox(
        height: Get.height,
        width: Get.width,
        child: storeController.listStorePots.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: storeController.listStorePots.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white.withOpacity(0.2)
                            : Get.theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          width: ShareFuntion.isIpad()
                              ? Get.width * 0.1
                              : Get.width * 0.2,
                          padding: const EdgeInsets.all(8.0),
                          child: imageNetwork(
                            url: storeController.listStorePots[index].image ??
                                '',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textBodyMedium(
                                  storeController.listStorePots[index].name ??
                                      '',
                                  color: Colors.black),
                              textBodySmall(
                                  storeController
                                          .listStorePots[index].description ??
                                      '',
                                  color: Colors.black),
                              textBodySmall(
                                  'Hiệu ứng: ${storeController.listStorePots[index].effect ?? 'N.A'}',
                                  color: Colors.black),
                              textBodySmall(
                                  'Cấp độ mở khóa: ${storeController.listStorePots[index].levelUnlock ?? 'N.A'}',
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        cWidth(4),
                        FxButton.outlined(
                          onPressed: () async {
                            if (storeController.getStringLockLevel(
                                    storeController
                                            .listStorePots[index].levelUnlock ??
                                        1) !=
                                null) return;
                            ShareFuntion.onPopDialog(
                                context: context,
                                title: 'Xác nhận mua',
                                onCancel: () => Get.back(),
                                onSubmit: () async {
                                  Get.back();
                                  storeController.buyItemStore(
                                      storeController.listStorePots[index]);
                                });
                          },
                          side: BorderSide(color: Get.theme.primaryColor),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (storeController.getStringLockLevel(
                                      storeController.listStorePots[index]
                                              .levelUnlock ??
                                          1) ==
                                  null)
                                Container(
                                  width: ShareFuntion.isIpad()
                                      ? Get.width * 0.05
                                      : Get.width * 0.1,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Image.asset(
                                    storeController.listStorePots[index]
                                                .currencyUnit ==
                                            'oxygen'
                                        ? 'assets/images/oxygen.png'
                                        : storeController.listStorePots[index]
                                                    .currencyUnit ==
                                                'ticket'
                                            ? 'assets/images/ticket.png'
                                            : 'assets/images/gemstone.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              textTitleMedium(
                                  storeController.getStringLockLevel(
                                          storeController.listStorePots[index]
                                                  .levelUnlock ??
                                              1) ??
                                      storeController
                                          .listStorePots[index].priceStore
                                          ?.toString() ??
                                      '',
                                  color: Colors.black)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : _buildEmpty());
  }

  Widget _listStorePlants() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: storeController.listStorePlants.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: storeController.listStorePlants.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Colors.white.withOpacity(0.2)
                          : Get.theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: ShareFuntion.isIpad()
                            ? Get.width * 0.1
                            : Get.width * 0.2,
                        padding: const EdgeInsets.all(8.0),
                        child: imageNetwork(
                          url: storeController.listStorePlants[index].image ??
                              '',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBodyMedium(listPlantsData[index].name ?? '',
                                color: Colors.black),
                            textBodySmall(
                                listPlantsData[index].description ?? '',
                                color: Colors.black),
                            textBodySmall(
                                'Hiệu ứng: ${listPlantsData[index].effect ?? 'N.A'}',
                                color: Colors.black),
                            textBodySmall(
                                'Cấp độ mở khóa: ${storeController.listStorePlants[index].levelUnlock ?? 'N.A'}',
                                color: Colors.black)
                          ],
                        ),
                      ),
                      cWidth(4),
                      FxButton.outlined(
                        onPressed: () {
                          if (storeController.getStringLockLevel(storeController
                                      .listStorePlants[index].levelUnlock ??
                                  1) !=
                              null) return;
                          ShareFuntion.onPopDialog(
                              context: context,
                              title: 'Xác nhận mua',
                              onCancel: () => Get.back(),
                              onSubmit: () async {
                                Get.back();
                                storeController.buyItemStore(
                                    storeController.listStorePlants[index]);
                              });
                        },
                        side: BorderSide(color: Get.theme.primaryColor),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (storeController.getStringLockLevel(
                                    storeController.listStorePlants[index]
                                            .levelUnlock ??
                                        1) ==
                                null)
                              Container(
                                width: ShareFuntion.isIpad()
                                    ? Get.width * 0.05
                                    : Get.width * 0.1,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Image.asset(
                                  storeController.listStorePlants[index]
                                              .currencyUnit ==
                                          'oxygen'
                                      ? 'assets/images/oxygen.png'
                                      : storeController.listStorePlants[index]
                                                  .currencyUnit ==
                                              'ticket'
                                          ? 'assets/images/ticket.png'
                                          : 'assets/images/gemstone.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            textTitleMedium(
                                storeController.getStringLockLevel(
                                        storeController.listStorePlants[index]
                                                .levelUnlock ??
                                            1) ??
                                    storeController
                                        .listStorePlants[index].priceStore
                                        ?.toString() ??
                                    '',
                                color: Colors.black)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : _buildEmpty(),
    );
  }

  Widget _listStoreTools() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: storeController.listStoreItems.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: storeController.listStoreItems.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Colors.white.withOpacity(0.2)
                          : Get.theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: ShareFuntion.isIpad()
                            ? Get.width * 0.1
                            : Get.width * 0.2,
                        padding: const EdgeInsets.all(8.0),
                        child: imageNetwork(
                          url:
                              storeController.listStoreItems[index].image ?? '',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBodyMedium(
                                storeController.listStoreItems[index].name ??
                                    '',
                                color: Colors.black),
                            textBodySmall(
                                storeController
                                        .listStoreItems[index].description ??
                                    '',
                                color: Colors.black),
                            // textBodySmall(
                            //     'Hiệu ứng: ${storeController.listStoreItems[index].effect ?? 'N.A'}',
                            //     color: Colors.black)
                          ],
                        ),
                      ),
                      cWidth(4),
                      FxButton.outlined(
                        onPressed: () async {
                          ShareFuntion.onPopDialog(
                              context: context,
                              title: 'Xác nhận mua',
                              onCancel: () => Get.back(),
                              onSubmit: () async {
                                Get.back();
                                storeController.buyItemStore(
                                    storeController.listStoreItems[index]);
                              });
                        },
                        side: BorderSide(color: Get.theme.primaryColor),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: ShareFuntion.isIpad()
                                  ? Get.width * 0.05
                                  : Get.width * 0.1,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(
                                storeController.listStoreItems[index]
                                            .currencyUnit ==
                                        'oxygen'
                                    ? 'assets/images/oxygen.png'
                                    : storeController.listStoreItems[index]
                                                .currencyUnit ==
                                            'ticket'
                                        ? 'assets/images/ticket.png'
                                        : 'assets/images/gemstone.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            textTitleMedium(
                                storeController.listStoreItems[index].priceStore
                                        ?.toString() ??
                                    '',
                                color: Colors.black)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : _buildEmpty(),
    );
  }

  Widget _listStoreGems() {
    return SizedBox(
        height: Get.height,
        width: Get.width,
        child: storeController.products.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: storeController.products.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white.withOpacity(0.2)
                            : Get.theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                            width: ShareFuntion.isIpad()
                                ? Get.width * 0.1
                                : Get.width * 0.2,
                            // flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/gemstone.png'),
                            )),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textBodyMedium(
                                  storeController.products[index].title,
                                  color: Colors.black),
                              textBodySmall('Loại đá màu xanh tự bầu trời',
                                  color: Colors.black),
                              textBodySmall(
                                  'Tiết kiệm: ${storeController.products[index].description}',
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        FxButton.outlined(
                          onPressed: () async {
                            await storeController
                                .buyApp(storeController.products[index]);
                          },
                          side: BorderSide(color: Get.theme.primaryColor),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: ShareFuntion.isIpad()
                              // ? Get.width * 0.05
                              // : Get.width * 0.1,
                              //   // margin: const EdgeInsets.all(8),
                              //   child: Image.asset(
                              //     'assets/images/ticket.png',
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              textTitleMedium(
                                  storeController.products[index].price,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : _buildEmpty());
  }

  Widget _buildEmpty() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: textBodyMedium(
            'Đã sở hữu hết sản phẩm, sản phẩm mới sẽ sớm được bày bán',
            textAlign: TextAlign.center),
      ),
    );
  }
}
