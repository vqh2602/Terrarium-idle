import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/compoment/picket_move.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:url_launcher/url_launcher.dart';

List<PieAction> listActionsMenu(BuildContext context,
    {num? floor,
    num? position,
    required UserData userData,
    required Function(UserData) update}) {
  return [
    PieAction(
      tooltip: _itemMenuPlant('sell'),
      onSelect: () {
        ShareFuntion.onPopDialog(
            context: context,
            title: 'Bạn muốn bán cây này ?',
            onCancel: () {
              Get.back();
            },
            onSubmit: () {
              Plants? plant = userData.plants?.firstWhere(
                  (element) => element.position!.contains('$floor,$position'));
              userData.plants?.removeWhere(
                  (element) => element.position!.contains('$floor,$position'));
              userData = userData.copyWith(
                  money: userData.money!.copyWith(
                      oxygen: (userData.money?.oxygen ?? 0) +
                          (plant?.plantLevel == 1
                              ? 5
                              : plant?.plantLevel == 2
                                  ? 20
                                  : 50)));
              // setState(() {});
              Get.back();
              // print(userData.plants?.length);
              update.call(userData);
            });
      },
      buttonTheme: const PieButtonTheme(
        backgroundColor: Colors.white,
        iconColor: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/sell.png',
        ),
      ), // Can be any widget
    ),
    PieAction(
      tooltip: _itemMenuPlant('fertilizer'),
      onSelect: () {
        ShareFuntion.onPopDialog(
            context: context,
            title: 'Tiêu hao 10 phân bón để tăng 1 cấp cho cây',
            onCancel: () {
              Get.back();
            },
            onSubmit: () {
              if ((userData.item?.fertilizer ?? 0) < 10) {
                buildToast(
                    message: 'Không đủ phân bón',
                    status: TypeToast.toastDefault);
                return;
              }
              Plants? plant = userData.plants?.firstWhere(
                  (element) => element.position!.contains('$floor,$position'));
              List<Plants> plants = userData.plants ?? [];
              plants.removeWhere(
                  (element) => element.position!.contains('$floor,$position'));
              plants.add(plant!.copyWith(
                plantLevel: plant.plantLevel! + 1,
              ));
              userData = userData.copyWith(
                  item: userData.item!.copyWith(
                      fertilizer: (userData.item?.fertilizer ?? 0) - 10),
                  plants: plants);
              update.call(userData);
              Get.back();
            });
      },
      buttonTheme: const PieButtonTheme(
        backgroundColor: Colors.white,
        iconColor: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/fertilizer.png',
        ),
      ), // Can be any widget
    ),
    PieAction(
      tooltip: _itemMenuPlant('shovel'),
      onSelect: () {
        showMovePickShovel(
            floor: floor,
            position: position,
            userData: userData,
            update: update);
      },
      buttonTheme: const PieButtonTheme(
        backgroundColor: Colors.white,
        iconColor: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/shovel.png',
        ),
      ), // Can be any widget
    ),
    PieAction(
      tooltip: _itemMenuPlant('info'),
      onSelect: () {
        ShareFuntion.showWebInApp('https://vqhapps.gitbook.io/terrarium-idle/',
            mode: LaunchMode.inAppBrowserView);
      },
      buttonTheme: const PieButtonTheme(
        backgroundColor: Colors.white,
        iconColor: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/info_plant.png',
        ),
      ), // Can be any widget
    ),
  ];
}

_itemMenuPlant(String title) {
  return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: textBodySmall(title,
          color: Get.theme.primaryColor, fontWeight: FontWeight.w700));
}
