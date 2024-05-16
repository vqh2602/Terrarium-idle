import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';

showMovePickShovel(
    {num? floor,
    num? position, // cây đang chọn
    required UserData userData,
    required Function(UserData) update}) {
  Get.bottomSheet(Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    height: Get.height * 0.7,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: textTitleLarge('Chọn vị trí di chuyển',
              fontWeight: FontWeight.w700, color: Colors.black),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: userData.user!.userFloor! * 3,
            itemBuilder: (BuildContext ctx, index) {
              // Tính vị trí của tầng và vị trí trong tầng
              int floor1 = index ~/ 3 + 1;
              int position1 = index % 3 + 1;
              return Material(
                child: InkWell(
                  onTap: () {
                    ShareFuntion.tapPlayAudio();
                    ShareFuntion.onPopDialog(
                      context: ctx,
                      title: 'Bạn muốn di chuyển cây này ?',
                      onCancel: () {
                        Get.back();
                      },
                      onSubmit: () {
                        Get.back();
                        if ((userData.item?.shovel ?? 0) <= 0) {
                          buildToast(
                              message: 'Không đủ xẻng',
                              status: TypeToast.toastError);
                          return;
                        }

                        var result = userData.plants;
                        // tìm phần tử 1 tại vị trí chọn (tầng)
                        var p1 = result
                            ?.where((element) => element.position!
                                .contains('$floor1,$position1'))
                            .firstOrNull;
                        // tìm phần tử 2 tại vị ban đầu muốn di chuyển (cây)
                        var p2 = result
                            ?.where((element) =>
                                element.position!.contains('$floor,$position'))
                            .firstOrNull;

                        result?.removeWhere((element) =>
                            element.position!.contains('$floor,$position'));
                        result?.removeWhere((element) =>
                            element.position!.contains('$floor1,$position1'));
                        // thêm phnà tử 2 vào vị trí 1

                        // nếu phần tử 1 k null thì thêm phần tử 1 vào vị trí 2

                        if (p1 == null) {
                          result!.add(p2!.copyWith(
                            position: '$floor1,$position1',
                          ));
                        } else {
                          result?.add(p2!.copyWith(
                            position: '$floor1,$position1',
                          ));
                          result
                              ?.add(p1.copyWith(position: '$floor,$position'));
                        }
                        // setState(() {
                        int shovel = userData.item!.shovel! - 1;
                        Item item = userData.item!.copyWith(shovel: shovel);
                        userData =
                            userData.copyWith(plants: result, item: item);
                        // });
                        // print(userData);
                        update.call(userData);
                      },
                    );
                    // print(userData.plants);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.white.withOpacity(0.2)
                            : Get.theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: textBodyMedium('Tầng $floor1, vị trí $position1',
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
