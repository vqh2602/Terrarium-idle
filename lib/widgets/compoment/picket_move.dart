import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/compoment/search_item.dart';

showMovePickShovel(
    {num? floor,
    num? position, // cây đang chọn
    required UserData userData,
    BuildContext? context,
    required Function(UserData) update}) {
  List<SelectOptionItem> options = [];

  /// 1 tầng có 3 vị trí => nhân 3
  for (int index = 0; index < userData.user!.userFloor! * 3; index++) {
    // Tính vị trí của tầng và vị trí trong tầng
    int floor1 = index ~/ 3 + 1;
    int position1 = index % 3 + 1;
    options.add(
        SelectOptionItem(key: floor1.toString(), value: position1.toString()));
  }

// UI
  Get.bottomSheet(Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    height: Get.height * 0.85,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SText.titleLarge('Chọn vị trí di chuyển'.tr,
              fontWeight: FontWeight.w700, color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: searchItem<SelectOptionItem>(
              onSelected: (SelectOptionItem<SelectOptionItem>? value) async {
                Future.delayed(const Duration(milliseconds: 1000), () async {
                  _onTapMovePlant(
                      update: update,
                      floor: floor,
                      // ignore: use_build_context_synchronously
                      ctx: context,
                      position: position,
                      floorMove: num.parse(value?.data?.key ?? '0'),
                      positionMove: num.parse(value?.data?.value ?? '0'),
                      userData: userData);
                  // Get.back();
                });
              },
              options: options
                  .map((e) => SelectOptionItem<SelectOptionItem>(
                      key: '${'Tầng'.tr} ${e.key}, ${'vị trí'.tr} ${e.value}',
                      value: '',
                      data: e))
                  .toList()),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            // itemCount: userData.user!.userFloor! * 3,
            itemCount: options.length,
            itemBuilder: (BuildContext ctx, index) {
              // // Tính vị trí của tầng và vị trí trong tầng
              // int floor1 = index ~/ 3 + 1;
              // int position1 = index % 3 + 1;
              return Material(
                child: InkWell(
                  onTap: () {
                    _onTapMovePlant(
                        update: update,
                        ctx: ctx,
                        floor: floor,
                        position: position,
                        floorMove: num.parse(options[index].key ?? '0'),
                        positionMove: num.parse(options[index].value ?? '0'),
                        userData: userData);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white.withOpacity(0.2)
                            : Get.theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    // child: SText.bodyMedium(
                    //     '${'Tầng'.tr} $floor1, ${'vị trí'.tr} $position1',
                    //     color: Colors.black),
                    child: SText.bodyMedium(
                        '${'Tầng'.tr} ${options[index].key}, ${'vị trí'.tr} ${options[index].value}',
                        color: Colors.black),
                  ),
                ),
              );
            },
          ),
        )
      ],
    ),
  ));
}

_onTapMovePlant({
  required Function(UserData) update,
  BuildContext? ctx,
  num? floor,
  num? position, // vị trí đang chọn

  num? floorMove,
  num? positionMove, // vị trí muốn di chuyển
  required UserData userData,
}) async {
  ShareFuntion.tapPlayAudio();
  await ShareFuntion.onPopDialog(
    context: ctx ?? Get.context!,
    title: 'Bạn muốn di chuyển cây này?'.tr,
    onCancel: () {
      Get.back();
    },
    onSubmit: () {
      Get.back();
      if ((userData.item?.shovel ?? 0) <= 0) {
        buildToast(message: 'Không đủ xẻng'.tr, status: TypeToast.toastError);
        return;
      }

      var result = userData.plants;
      // tìm phần tử 1 tại vị trí chọn (tầng)
      // var p1 = result
      //     ?.where((element) => element.position!
      //         .contains('$floor1,$position1'))
      //     .firstOrNull;
      var p1 = result
          ?.where((element) =>
              element.position!.contains('$floorMove,$positionMove'))
          .firstOrNull;

      // tìm phần tử 2 tại vị ban đầu muốn di chuyển (cây)
      var p2 = result
          ?.where((element) => element.position!.contains('$floor,$position'))
          .firstOrNull;

      result?.removeWhere(
          (element) => element.position!.contains('$floor,$position'));

      // result?.removeWhere((element) =>
      //     element.position!.contains('$floor1,$position1'));
      result?.removeWhere(
          (element) => element.position!.contains('$floorMove,$positionMove'));

      // thêm phnà tử 2 vào vị trí 1

      // nếu phần tử 1 k null thì thêm phần tử 1 vào vị trí 2

      if (p1 == null) {
        // result!.add(p2!.copyWith(
        //   position: '$floor1,$position1',
        // ));
        result!.add(p2!.copyWith(
          position: '$floorMove,$positionMove',
        ));
      } else {
        // result?.add(p2!.copyWith(
        //   position: '$floor1,$position1',
        // ));
        result?.add(p2!.copyWith(
          position: '$floorMove,$positionMove',
        ));
        result?.add(p1.copyWith(position: '$floor,$position'));
      }
      // setState(() {
      int shovel = userData.item!.shovel! - 1;
      Item item = userData.item!.copyWith(shovel: shovel);
      userData = userData.copyWith(plants: result, item: item);
      // });
      // print(userData);
      update.call(userData);
      Get.back();
    },
  );
  // print(userData.plants);
}
