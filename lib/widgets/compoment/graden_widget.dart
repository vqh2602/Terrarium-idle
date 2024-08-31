import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutx_ui/widgets/dotted_border/dotted_border.dart';
import 'package:flutx_ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/widgets/blur_box.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/compoment/action_menu.dart';
import 'package:terrarium_idle/widgets/compoment/picker_plants_pots.dart';
import 'package:terrarium_idle/widgets/compoment/rive_animation_item.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';

class Graden extends StatelessWidget {
  final bool isEdit;
  final bool isCoop;
  final UserData userData;
  final Function(UserData) update;
  final Function changeUI;
  const Graden(
      {super.key,
      required this.isEdit,
      required this.userData,
      required this.update,
      required this.changeUI,
      required this.isCoop});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: PieCanvas(
        child: Row(
          children: [
            SizedBox(
                height: Get.height,
                child: Image.asset(Assets.images.r1.path, fit: BoxFit.fill)),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                    itemCount: (userData.user?.userFloor ?? 0) + 1,
                    padding: EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight + Get.height * 0.05,
                        top: kToolbarHeight + Get.height * 0.1),
                    reverse: true,
                    shrinkWrap: true,
                    itemBuilder: (context, floor) {
                      if (floor == (userData.user?.userFloor ?? 0)) {
                        int oxygenUnlock =
                            (2500 * (userData.user?.userFloor ?? 1) +
                                    ((userData.user?.userLevel ?? 1) / 100))
                                .toInt();
                        return ((userData.user?.userLevel ?? 1) ~/ 5 >
                                    (userData.user?.userFloor ?? 1) &&
                                !isCoop)
                            ? Container(
                                key: Key('$floor'),
                                height: Get.height * 0.2,
                                margin: const EdgeInsets.all(20),
                                child: GestureDetector(
                                  onTap: () {
                                    ShareFuntion.tapPlayAudio();
                                    if ((userData.money?.oxygen ?? 0) <
                                        oxygenUnlock) {
                                      buildToast(
                                          message: 'Không đủ oxygen'.tr,
                                          status: TypeToast.toastError);
                                      return;
                                    }
                                    ShareFuntion.onPopDialog(
                                        context: context,
                                        title: 'Xác nhận mở khóa'.tr,
                                        onCancel: () {
                                          Get.back();
                                        },
                                        onSubmit: () {
                                          Get.back();
                                          UserData userDataCustom = userData;
                                          Money? money = userData.money
                                              ?.copyWith(
                                                  oxygen:
                                                      (userData.money?.oxygen ??
                                                              0) -
                                                          oxygenUnlock);

                                          userDataCustom = userData.copyWith(
                                            money: money,
                                            user: userData.user!.copyWith(
                                              userFloor:
                                                  userData.user!.userFloor! + 1,
                                            ),
                                          );
                                          update(userDataCustom);
                                        });
                                  },
                                  child: BlurBox(
                                      blurColor: Colors.white.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      blurSigma: 3,
                                      child: Center(
                                        child: textBodyMedium(
                                            '${'Mở khóa với'.tr} $oxygenUnlock oxygen',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              )
                            : const SizedBox();
                      }

                      return Container(
                        key: Key('$floor'),
                        height: (ShareFuntion.isIpad() ? 300 : 100) +
                            Get.height * 0.15,
                        margin: const EdgeInsets.only(bottom: 0, top: 20),
                        // color: Colors.green,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: textBodySmall(
                                    '${'Tầng'.tr} ${floor + 1}',
                                    color: Colors.white24)),
                            Expanded(child: _lowOptions(floor: floor)),
                            // Expanded(
                            //     child: _hightOptions(
                            //         floor: floor, context: context)),
                            SizedBox(
                                width: Get.width,
                                child: Image.asset(
                                  'assets/images/r2.png',
                                  fit: BoxFit.fill,
                                ))
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  _clamOxygen(Plants plant, {required int floor, required int position}) {
    if (kDebugMode) {
      print('clam oxygen');
    }
    UserData userDataCustom = userData;
    Money? money = userData.money?.copyWith(
        oxygen: (userData.money?.oxygen ?? 0) +
            (plant.plantLevel == 3
                ? 20
                : plant.plantLevel == 2
                    ? 10
                    : 5));
    List<Plants> plants = userData.plants!;
    plants.removeWhere((element) =>
        element.position!.contains('${floor + 1},${position + 1}'));
    plants.add(plant.copyWith(
        platLevelExp: plant.platLevelExp! + 100, harvestTime: DateTime.now()));
    userDataCustom = userData.copyWith(
        money: money,
        user: userData.user!
            .copyWith(userLevelEXP: userData.user!.userLevelEXP! + 100),
        plants: plants);
    update(userDataCustom);
  }

  // _hightOptions({required int floor, required BuildContext context}) {
  //   item(
  //       {required int floor,
  //       required int position,
  //       required BuildContext context}) {
  //     Plants? plant = userData.plants?.firstWhereOrNull((element) =>
  //         element.position?.contains('${floor + 1},${position + 1}') ?? false);
  //     return (userData.plants!
  //             .where((element) =>
  //                 element.position!.contains('${floor + 1},${position + 1}'))
  //             .isNotEmpty)
  //         ? (plant != null)
  //             ? Container(
  //                 width: Get.width * 0.32,
  //                 padding: EdgeInsets.zero,
  //                 child: PieMenu(
  //                   onToggle: (val) {
  //                     ShareFuntion.tapPlayAudio();
  //                   },
  //                   onPressed: () {
  //                     ShareFuntion.tapPlayAudio(isNewAudioPlay: true);
  //                     if (ShareFuntion.gacha(winRate: 2) && !isCoop) {
  //                       _clamOxygen(plant, floor: floor, position: position);
  //                     }
  //                   },
  //                   theme: const PieTheme(
  //                       overlayColor: Colors.black45,
  //                       rightClickShowsMenu: true,
  //                       customAngleAnchor: PieAnchor.center),
  //                   actions: [
  //                     if (!isCoop)
  //                       ...listActionsMenu(context,
  //                           floor: floor + 1,
  //                           position: position + 1,
  //                           userData: userData,
  //                           update: update)
  //                   ],
  //                   child: Container(
  //                     padding: EdgeInsets.zero,
  //                     // color: Colors.red,
  //                     child: LayoutBuilder(
  //                       builder: (context, constraints) {
  //                         // Plants plant = userData
  //                         //     .plants!
  //                         //     .firstWhere((element) =>
  //                         //         element.position!
  //                         //             .contains(
  //                         //                 '${floor + 1},${position + 1}'));
  //                         // print(
  //                         //     '/n plant: ${plant.idPlant} ${'${floor + 1},$position'} : level: ${plant.plantLevel}');
  //                         bool showClamOxygen = (DateTime.now()
  //                                     .difference(
  //                                         plant.harvestTime ?? DateTime.now())
  //                                     .inMinutes >=
  //                                 30 &&
  //                             ShareFuntion.gacha(
  //                                 winRate: plant.plantLevel == 3
  //                                     ? 95
  //                                     : plant.plantLevel == 2
  //                                         ? 70
  //                                         : 60));
  //                         // changeUI.call();
  //                         return Stack(
  //                           key: Key(plant.position ?? ''),
  //                           children: [
  //                             RiveAnimationItem(
  //                                 constraints: constraints,
  //                                 plantId: plant.idPlant!,
  //                                 potId: plant.idPot!,
  //                                 changeUI: changeUI,
  //                                 level: plant.plantLevel ?? 1),
  //                             if (showClamOxygen && !isCoop)
  //                               IconButton(
  //                                 focusColor: Colors.transparent,
  //                                 hoverColor: Colors.transparent,
  //                                 onPressed: () async {
  //                                   // ShareFuntion
  //                                   //     .tapPlayAudio(
  //                                   //         isNewAudioPlay:
  //                                   //             false);
  //                                   /// lấy oxy gen và tăng cấp cây khi hiện oxygen
  //                                   _clamOxygen(plant,
  //                                       floor: floor, position: position);
  //                                 },
  //                                 icon: Align(
  //                                   alignment: Alignment.bottomRight,
  //                                   child: Image.asset(
  //                                     Assets.images.oxygen.path,
  //                                     width: 30,
  //                                     height: 30,
  //                                   ),
  //                                 ),
  //                               )
  //                           ],
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 ))
  //             : const SizedBox()
  //         : Container(
  //             width: Get.width * 0.33,
  //             padding: EdgeInsets.zero,
  //             child: isEdit
  //                 ? GestureDetector(
  //                     onTap: () {
  //                       ShareFuntion.tapPlayAudio();
  //                       showPickPotsAndPlants(
  //                           floor: floor + 1,
  //                           position: position + 1,
  //                           userData: userData,
  //                           update: update);
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.all(8),
  //                       width: double.infinity,
  //                       height: double.infinity,
  //                       child: DottedBorder(
  //                         color: Get.theme.primaryColor,
  //                         strokeWidth: 2,
  //                         borderType: BorderType.RRect,
  //                         radius: const Radius.circular(12),
  //                         dashPattern: const [6, 3, 2, 3],
  //                         child: Center(
  //                             child: Icon(
  //                           LucideIcons.sprout,
  //                           size: 50,
  //                           color: Get.theme.primaryColor,
  //                         )),
  //                       ),
  //                     ),
  //                   )
  //                 : const SizedBox());
  //   }

  //   return ListView(
  //     // itemCount: 3,
  //     shrinkWrap: true,
  //     primary: true,
  //     padding: EdgeInsets.zero,
  //     scrollDirection: Axis.horizontal,
  //     children: [
  //       for (int position = 0; position < 3; position++) ...[
  //         item(floor: floor, position: position, context: context)
  //       ]
  //     ],
  //   );
  // }

  _lowOptions({required int floor}) {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {
          Plants? plant = userData.plants?.firstWhereOrNull((element) =>
              element.position?.contains('${floor + 1},${position + 1}') ??
              false);
          return (userData.plants!
                  .where((element) => element.position!
                      .contains('${floor + 1},${position + 1}'))
                  .isNotEmpty)
              ? (plant != null)
                  ? Container(
                      width: Get.width * 0.32,
                      padding: EdgeInsets.zero,
                      child: PieMenu(
                        onToggle: (val) {
                          ShareFuntion.tapPlayAudio();
                        },
                        onPressed: () {
                          ShareFuntion.tapPlayAudio(isNewAudioPlay: true);
                          if (ShareFuntion.gacha(winRate: 2) && !isCoop) {
                            _clamOxygen(plant,
                                floor: floor, position: position);
                          }
                        },
                        theme: const PieTheme(
                            overlayColor: Colors.black45,
                            rightClickShowsMenu: true,
                            customAngleAnchor: PieAnchor.center),
                        actions: [
                          if (!isCoop)
                            ...listActionsMenu(context,
                                floor: floor + 1,
                                position: position + 1,
                                userData: userData,
                                update: update)
                        ],
                        child: Container(
                          padding: EdgeInsets.zero,
                          // color: Colors.red,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              // Plants plant = userData
                              //     .plants!
                              //     .firstWhere((element) =>
                              //         element.position!
                              //             .contains(
                              //                 '${floor + 1},${position + 1}'));
                              // print(
                              //     '/n plant: ${plant.idPlant} ${'${floor + 1},$position'} : level: ${plant.plantLevel}');
                              bool showClamOxygen = (DateTime.now()
                                          .difference(plant.harvestTime ??
                                              DateTime.now())
                                          .inMinutes >=
                                      30 &&
                                  ShareFuntion.gacha(
                                      winRate: plant.plantLevel == 3
                                          ? 95
                                          : plant.plantLevel == 2
                                              ? 70
                                              : 60));
                              // changeUI.call();
                              return Stack(
                                key: Key(plant.position ?? ''),
                                children: [
                                  RiveAnimationItem(
                                      constraints: constraints,
                                      plantId: plant.idPlant!,
                                      potId: plant.idPot!,
                                      changeUI: changeUI,
                                      level: plant.plantLevel ?? 1),
                                  if (showClamOxygen && !isCoop)
                                    IconButton(
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onPressed: () async {
                                        // ShareFuntion
                                        //     .tapPlayAudio(
                                        //         isNewAudioPlay:
                                        //             false);
                                        /// lấy oxy gen và tăng cấp cây khi hiện oxygen
                                        _clamOxygen(plant,
                                            floor: floor, position: position);
                                      },
                                      icon: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Image.asset(
                                          Assets.images.oxygen.path,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                        ),
                      ))
                  : const SizedBox()
              : Container(
                  width: Get.width * 0.33,
                  padding: EdgeInsets.zero,
                  child: isEdit
                      ? GestureDetector(
                          onTap: () {
                            ShareFuntion.tapPlayAudio();
                            showPickPotsAndPlants(
                                floor: floor + 1,
                                position: position + 1,
                                userData: userData,
                                update: update);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: double.infinity,
                            height: double.infinity,
                            child: DottedBorder(
                              color: Get.theme.primaryColor,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              dashPattern: const [6, 3, 2, 3],
                              child: Center(
                                  child: Icon(
                                LucideIcons.sprout,
                                size: 50,
                                color: Get.theme.primaryColor,
                              )),
                            ),
                          ),
                        )
                      : const SizedBox());
        });
  }
}
