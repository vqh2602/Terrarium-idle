import 'package:flutter/material.dart';
import 'package:flutx_ui/widgets/button/button.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/local/list_plants.dart';
import 'package:terrarium_idle/data/local/list_pots.dart';
import 'package:terrarium_idle/data/local/list_stickers.dart';
import 'package:terrarium_idle/data/models/item.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/compoment/search_item.dart';
import 'package:terrarium_idle/widgets/image_custom.dart';

import 'package:terrarium_idle/widgets/widgets.dart';

showPickPotsAndPlants(
    {num? floor,
    num? position,
    required UserData userData,
    required Function(UserData) update}) async {
  PageController pageController = PageController();
  ItemData? idPot;
  ItemData? idPlant;
  String typeSelect = 'pot';
  List<ItemData> listPlants = listPlantsData
      .where((plant) => userData.cart?.cartPlants?.contains(plant.id) ?? false)
      .toList();
  List<ItemData> listPots = listPotsData
      .where((pot) => userData.cart?.cartPots?.contains(pot.id) ?? false)
      .toList();
  List<ItemData> listStickers = listStickersData
      .where((pot) => userData.cart?.cartStickers?.contains(pot.id) ?? false)
      .toList();

  await Get.bottomSheet(
      Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: Get.height * 0.85,
          width: Get.width,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                cHeight(12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: FxButton.medium(
                            backgroundColor: typeSelect == 'pot'
                                ? Get.theme.primaryColor
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                if (typeSelect == 'sticker') {
                                  idPot = null;
                                  idPlant = null;
                                }
                                typeSelect = 'pot';
                              });
                              ShareFuntion.tapPlayAudio();
                              pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: SText.titleMedium('Chọn chậu'.tr,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        cWidth(8),
                        Expanded(
                          child: FxButton.medium(
                            backgroundColor: typeSelect == 'plant'
                                ? Get.theme.primaryColor
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                if (typeSelect == 'sticker') {
                                  idPot = null;
                                  idPlant = null;
                                }
                                typeSelect = 'plant';
                              });
                              ShareFuntion.tapPlayAudio();
                              pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: SText.titleMedium('Chọn cây'.tr,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        cWidth(8),
                        Expanded(
                          child: FxButton.medium(
                            backgroundColor: typeSelect == 'sticker'
                                ? Get.theme.primaryColor
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                // if (typeSelect == 'sticker') {
                                idPot = null;
                                idPlant = null;
                                // }
                                typeSelect = 'sticker';
                              });
                              ShareFuntion.tapPlayAudio();
                              pageController.animateToPage(2,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: SText.titleMedium('Trang trí'.tr,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        )
                      ]),
                ),
                Row(
                  children: [
                    if (typeSelect == 'sticker')
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (idPot != null && idPlant != null) ...[
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              idPot = null;
                                              idPlant = null;
                                            });
                                          },
                                          icon: const Icon(Icons.close)),
                                      cWidth(4),
                                      Expanded(
                                        child: SText.bodySmall(
                                            'Trang trí đang chọn'.tr,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: Get.width * 0.15,
                                    height: Get.width * 0.15,
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: imageNetwork(
                                          url: listStickers
                                              .where((element) =>
                                                  element.id == idPlant?.id)
                                              .firstOrNull!
                                              .image!,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      )),
                    if (typeSelect != 'sticker') ...[
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (idPot != null) ...[
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              idPot = null;
                                            });
                                          },
                                          icon: const Icon(Icons.close)),
                                      cWidth(4),
                                      Expanded(
                                        child: SText.bodySmall(
                                            'Chậu đang chọn'.tr,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: Get.width * 0.15,
                                    height: Get.width * 0.15,
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: imageNetwork(
                                          url: listPots
                                              .where((element) =>
                                                  element.id == idPot?.id)
                                              .firstOrNull!
                                              .image!,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (idPlant != null) ...[
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              idPlant = null;
                                            });
                                          },
                                          icon: const Icon(Icons.close)),
                                      cWidth(4),
                                      Expanded(
                                        child: SText.bodySmall(
                                            'Cây đang chọn'.tr,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: Get.width * 0.15,
                                    height: Get.width * 0.15,
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: imageNetwork(
                                          url: listPlants
                                              .where((element) =>
                                                  element.id == idPlant?.id)
                                              .firstOrNull!
                                              .image!,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ))
                    ]
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (value) {
                      if (value == 0) {
                        setState(() {
                          if (typeSelect == 'sticker') {
                            idPot = null;
                            idPlant = null;
                          }
                          typeSelect = 'pot';
                        });
                      } else if (value == 1) {
                        setState(() {
                          if (typeSelect == 'sticker') {
                            idPot = null;
                            idPlant = null;
                          }
                          typeSelect = 'plant';
                        });
                      } else if (value == 2) {
                        setState(() {
                          typeSelect = 'sticker';
                        });
                      }
                    },
                    children: [
                      listPots.isNotEmpty
                          ? _pickPots(
                              listPots: listPots,
                              setIdPot: (id) {
                                idPot = id;
                                setState(() {});
                              },
                            )
                          : _showEmpty(),
                      listPlants.isNotEmpty
                          ? _pickPlants(
                              listPlants: listPlants,
                              setIdPlant: (id) {
                                idPlant = id;
                                setState(() {});
                              },
                            )
                          : _showEmpty(),
                      listStickers.isNotEmpty
                          ? _pickSticker(
                              listSticker: listStickers,
                              setIdPlantandPotWithIdSticker: (ItemData id) {
                                id = (id).copyWith(
                                    priceOxygen: (id.priceOxygen! / 2).toInt());
                                idPlant = id;
                                idPot = id;
                                setState(() {});
                              },
                            )
                          : _showEmpty(),
                    ],
                  ),
                ),
              ],
            );
          })),
      isScrollControlled: true);

  if (idPlant != null && idPot != null && userData.money != null) {
    // Get.back();

    if (idPlant?.itemTypeAttribute != idPot?.itemTypeAttribute) {
      buildToast(
          message: 'Hãy chọn đúng thuộc tính cây và chậu'.tr,
          status: TypeToast.toastDefault);
    } else if (userData.money!.oxygen! <
        (idPlant!.priceOxygen! + idPot!.priceOxygen!)) {
      buildToast(message: 'Không đủ oxygen'.tr, status: TypeToast.toastDefault);
    } else {
      var result = userData.plants;
      result!.add(Plants(
          position: '$floor,$position',
          idPlant: idPlant?.id,
          idPot: idPot?.id,
          harvestTime: DateTime.now(),
          isHanging: idPlant?.itemTypeAttribute == ItemTypeAttribute.hanging,
          platLevelExp: 0,
          plantLevel: 1));
      // setState(() {
      userData = userData.copyWith(
          plants: result,
          money: userData.money!.copyWith(
              oxygen: userData.money!.oxygen! -
                  (idPlant!.priceOxygen! + idPot!.priceOxygen!)));
      update.call(userData);
    }
    // });
    // print(userData.plants);
  }
}

_pickPots({Function? setIdPot, required List<ItemData> listPots}) {
  return Column(
    children: [
      // if (idPot != '')
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child:
      //         SText.titleLarge('Chậu đang chọn', fontWeight: FontWeight.w700),
      //   ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: searchItem<ItemData>(
            isImage: true,
            onSelected: (SelectOptionItem<ItemData>? value) async {
              ShareFuntion.tapPlayAudio();
              setIdPot!(value?.data!);
            },
            options: listPots
                .map((e) => SelectOptionItem<ItemData>(
                    key: '${e.name}', data: e, value: e.image))
                .toList()),
      ),

      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listPots.length,
          itemBuilder: (BuildContext ctx, index) {
            return Material(
              child: InkWell(
                onTap: () {
                  ShareFuntion.tapPlayAudio();
                  setIdPot!(listPots[index]);
                  // Get.back();
                  // var result = userData.plants;
                  // result!.add(Plants(
                  //   position: '$floor,$position',
                  // ));
                  // setState(() {
                  //   userData.copyWith(plants: result);
                  // });
                  // print(userData.plants);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Colors.white.withOpacity(0.2)
                          : Get.theme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: imageNetwork(
                              url: listPots[index].image!, fit: BoxFit.contain),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SText.bodyMedium(
                              '${listPots[index].name!} ${listPots[index].itemTypeAttribute == ItemTypeAttribute.hanging ? '(☁Treo)' : ''}',
                              color: Colors.black,
                            ),
                            SText.bodySmall(listPots[index].description!,
                                color: Colors.black),
                            SText.bodySmall(
                                '${'Hiệu ứng'.tr}: ${listPots[index].effect}',
                                color: Colors.black)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width * 0.05,
                              // margin: const EdgeInsets.all(8),
                              child: Image.asset(
                                Assets.images.oxygen.path,
                                // listPots[index].currencyUnit == 'oxygen'
                                //     ? 'assets/images/oxygen.png'
                                //     : listPots[index].currencyUnit ==
                                //             'ticket'
                                //         ? 'assets/images/ticket.png'
                                //         : 'assets/images/gemstone.png',
                              ),
                            ),
                            SText.bodySmall(
                              listPots[index].priceOxygen!.toString(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}

_pickPlants({Function? setIdPlant, required List<ItemData> listPlants}) {
  return Column(
    children: [
      // if (idPlant != '')
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: SText.titleLarge('Cáy đang chọn', fontWeight: FontWeight.w700),
      //   ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: searchItem<ItemData>(
            isImage: true,
            onSelected: (SelectOptionItem<ItemData>? value) async {
              ShareFuntion.tapPlayAudio();
              setIdPlant!(value?.data!);
            },
            options: listPlants
                .map((e) => SelectOptionItem<ItemData>(
                    key: '${e.name}', data: e, value: e.image))
                .toList()),
      ),

      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listPlants.length,
          itemBuilder: (BuildContext ctx, index) {
            return Material(
              child: InkWell(
                onTap: () {
                  ShareFuntion.tapPlayAudio();
                  setIdPlant!(listPlants[index]);
                  // Get.back();
                  // var result = userData.plants;
                  // result!.add(Plants(
                  //   position: '$floor,$position',
                  // ));
                  // setState(() {
                  //   userData.copyWith(plants: result);
                  // });
                  // print(userData.plants);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Colors.white.withOpacity(0.2)
                          : Get.theme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            width: Get.width * 0.15,
                            height: Get.width * 0.15,
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: imageNetwork(
                                  url: listPlants[index].image!,
                                  fit: BoxFit.contain),
                            ),
                          )),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SText.bodyMedium(
                                '${listPlants[index].name!} ${listPlants[index].itemTypeAttribute == ItemTypeAttribute.hanging ? '(☁Treo)' : ''}',
                                color: Colors.black),
                            SText.bodySmall(listPlants[index].description!,
                                color: Colors.black),
                            SText.bodySmall(
                                'Hiệu ứng: ${listPlants[index].effect}',
                                color: Colors.black)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width * 0.05,
                              // margin: const EdgeInsets.all(8),
                              child: Image.asset(
                                Assets.images.oxygen.path,
                              ),
                            ),
                            SText.bodySmall(
                              listPlants[index].priceOxygen!.toString(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}

_pickSticker(
    {Function? setIdPlantandPotWithIdSticker,
    required List<ItemData> listSticker}) {
  return Column(
    children: [
      // if (idPlant != '')
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: SText.titleLarge('Cáy đang chọn', fontWeight: FontWeight.w700),
      //   ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: searchItem<ItemData>(
            isImage: true,
            onSelected: (SelectOptionItem<ItemData>? value) async {
              ShareFuntion.tapPlayAudio();
              setIdPlantandPotWithIdSticker!(value?.data!);
            },
            options: listSticker
                .map((e) => SelectOptionItem<ItemData>(
                    key: '${e.name}', data: e, value: e.image))
                .toList()),
      ),

      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listSticker.length,
          itemBuilder: (BuildContext ctx, index) {
            return Material(
              child: InkWell(
                onTap: () {
                  ShareFuntion.tapPlayAudio();
                  setIdPlantandPotWithIdSticker!(listSticker[index]);
                  // Get.back();
                  // var result = userData.plants;
                  // result!.add(Plants(
                  //   position: '$floor,$position',
                  // ));
                  // setState(() {
                  //   userData.copyWith(plants: result);
                  // });
                  // print(userData.plants);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Colors.white.withOpacity(0.2)
                          : Get.theme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            width: Get.width * 0.15,
                            height: Get.width * 0.15,
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: imageNetwork(
                                  url: listSticker[index].image!,
                                  fit: BoxFit.contain),
                            ),
                          )),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SText.bodyMedium(
                                '${listSticker[index].name!} ${listSticker[index].itemTypeAttribute == ItemTypeAttribute.hanging ? '(☁Treo)' : ''}',
                                color: Colors.black),
                            SText.bodySmall(listSticker[index].description!,
                                color: Colors.black),
                            SText.bodySmall(
                                'Hiệu ứng: ${listSticker[index].effect}',
                                color: Colors.black)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width * 0.05,
                              // margin: const EdgeInsets.all(8),
                              child: Image.asset(
                                Assets.images.oxygen.path,
                              ),
                            ),
                            SText.bodySmall(
                              listSticker[index].priceOxygen!.toString(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}

_showEmpty() {
  return Center(
    child: SText.bodyMedium('Vào cửa hàng để mở khóa'.tr, color: Colors.black),
  );
}
