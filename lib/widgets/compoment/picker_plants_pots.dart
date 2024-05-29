import 'package:flutter/material.dart';
import 'package:flutx_ui/widgets/button/button.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/local/list_plants.dart';
import 'package:terrarium_idle/data/local/list_pots.dart';
import 'package:terrarium_idle/data/models/item.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/image_custom.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

showPickPotsAndPlants(
    {num? floor,
    num? position,
    required UserData userData,
    required Function(UserData) update}) async {
  PageController pageController = PageController();
  ItemData? idPot;
  ItemData? idPlant;
  bool isPot = true;
  List<ItemData> listPlants = listPlantsData
      .where((plant) => userData.cart?.cartPlants?.contains(plant.id) ?? false)
      .toList();
  List<ItemData> listPots = listPotsData
      .where((pot) => userData.cart?.cartPots?.contains(pot.id) ?? false)
      .toList();

  await Get.bottomSheet(
      Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: Get.height * 0.8,
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
                            backgroundColor:
                                isPot ? Get.theme.primaryColor : Colors.grey,
                            onPressed: () {
                              setState(() {
                                isPot = true;
                              });
                              ShareFuntion.tapPlayAudio();
                              pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: textTitleLarge('Chọn chậu'.tr,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        cWidth(8),
                        Expanded(
                          child: FxButton.medium(
                            backgroundColor:
                                !isPot ? Get.theme.primaryColor : Colors.grey,
                            onPressed: () {
                              setState(() {
                                isPot = false;
                              });
                              ShareFuntion.tapPlayAudio();
                              pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: textTitleLarge('Chọn cây'.tr,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        )
                      ]),
                ),
                Row(
                  children: [
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
                                    textBodySmall('Chậu đang chọn'.tr,
                                        color: Colors.black),
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
                                    textBodySmall('Cây đang chọn'.tr,
                                        color: Colors.black),
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
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
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
                    ],
                  ),
                ),
              ],
            );
          })),
      isScrollControlled: true);

  if (idPlant != null && idPot != null && userData.money != null) {
    // Get.back();
    if (userData.money!.oxygen! <
        (idPlant!.priceOxygen! + idPot!.priceOxygen!)) {
      buildToast(message: 'Không đủ oxygen'.tr, status: TypeToast.toastDefault);
    } else {
      var result = userData.plants;
      result!.add(Plants(
          position: '$floor,$position',
          idPlant: idPlant?.id,
          idPot: idPot?.id,
          harvestTime: DateTime.now(),
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
      //         textTitleLarge('Chậu đang chọn', fontWeight: FontWeight.w700),
      //   ),
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
                            textBodyMedium(listPots[index].name!,
                                color: Colors.black),
                            textBodySmall(listPots[index].description!,
                                color: Colors.black),
                            textBodySmall('${'Hiệu ứng'.tr}: ${listPots[index].effect}',
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
                              child: Image.asset('assets/images/oxygen.png'
                                  // listPots[index].currencyUnit == 'oxygen'
                                  //     ? 'assets/images/oxygen.png'
                                  //     : listPots[index].currencyUnit ==
                                  //             'ticket'
                                  //         ? 'assets/images/ticket.png'
                                  //         : 'assets/images/gemstone.png',
                                  ),
                            ),
                            textBodySmall(
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
      //     child: textTitleLarge('Cáy đang chọn', fontWeight: FontWeight.w700),
      //   ),
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
                            textBodyMedium(listPlants[index].name!,
                                color: Colors.black),
                            textBodySmall(listPlants[index].description!,
                                color: Colors.black),
                            textBodySmall(
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
                                'assets/images/oxygen.png',
                              ),
                            ),
                            textBodySmall(
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

_showEmpty() {
  return Center(
    child: textBodyMedium('Vào cửa hàng để mở khóa', color: Colors.black),
  );
}
