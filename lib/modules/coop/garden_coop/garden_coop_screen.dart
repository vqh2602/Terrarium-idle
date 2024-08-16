// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:rive/rive.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/coop/garden_coop/garden_coop_controller.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/blur_box.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/compoment/coop_widget.dart';
import 'package:terrarium_idle/widgets/compoment/graden_widget.dart';
import 'package:terrarium_idle/widgets/compoment/like_widget.dart';
import 'package:terrarium_idle/widgets/compoment/picker_effects.dart';
import 'package:terrarium_idle/widgets/compoment/water_rain.dart';

class GardenCoopScreen extends StatefulWidget {
  const GardenCoopScreen({super.key});
  static const String routeName = '/gardenCoop';

  @override
  State<GardenCoopScreen> createState() => _GardenCoopScreenState();
}

class _GardenCoopScreenState extends State<GardenCoopScreen>
    with SingleTickerProviderStateMixin {
  GardenCoopController gardenCoopController = Get.find();
  UserController userController = Get.find();

  final _key = GlobalKey<ExpandableFabState>();
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    gardenCoopController.checkLogin();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        gardenCoopController.isRain = ShareFuntion.gacha(winRate: 5);
        gardenCoopController.update();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
        // backgroundColor: const Color(0xfffaf3e1),
        context: context,
        body: _buildBody(),
        appBar: null,
        floatingActionButtonLocation: ExpandableFab.location,
        createFloatingActionButton: gardenCoopController.obx(
          (state) => ExpandableFab(
            key: _key,
            type: ExpandableFabType.up,
            distance: Get.height * 0.1,
            overlayStyle: ExpandableFabOverlayStyle(
              color: Colors.black.withOpacity(0.5),
              // blur: 5
            ),
            onClose: () {
              ShareFuntion.tapPlayAudio();
            },
            onOpen: () {
              ShareFuntion.tapPlayAudio();
            },
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(LucideIcons.blocks),
              foregroundColor: Get.theme.primaryColor,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
            ),
            children: [
              if (!gardenCoopController.isWater &&
                  !gardenCoopController.isLike) ...[
                FloatingActionButton(
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: const Icon(
                    LucideIcons.heart,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    _key.currentState?.toggle();
                    // ShareFuntion.tapPlayAudio();
                    // Future.delayed(const Duration(seconds: 500), () {
                    ShareFuntion.tapPlayAudio(
                        type: TypeSound.like, isNewAudioPlay: true);
                    gardenCoopController.isLike = true;
                    gardenCoopController.update();
                    await Future.delayed(const Duration(seconds: 3), () {
                      gardenCoopController.isLike = false;
                      gardenCoopController.update();
                    });
                    // });
                    // Get.back();
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: const Icon(
                    LucideIcons.droplets,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    _key.currentState?.toggle();
                    // ShareFuntion.tapPlayAudio();
                    // Future.delayed(const Duration(seconds: 500), () {
                    ShareFuntion.tapPlayAudio(
                        type: TypeSound.rain, isNewAudioPlay: true);
                    gardenCoopController.isWater = true;
                    gardenCoopController.update();
                    await Future.delayed(const Duration(seconds: 12), () {
                      gardenCoopController.isWater = false;
                      gardenCoopController.update();
                    });
                    // Get.back();
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: Icon(
                    LucideIcons.sparkles,
                    color: Get.theme.primaryColor,
                  ),
                  onPressed: () {
                    _key.currentState?.toggle();
                    // ShareFuntion.tapPlayAudio();
                    // Future.delayed(const Duration(seconds: 500), () {
                    // ShareFuntion.tapPlayAudio(type: TypeSound.tap);
                    showPickEffects(
                      isCoop: true,
                      listEffect: gardenCoopController.listSelectOptionEffect,
                      listMusic: gardenCoopController.listSelectOptionMusic,
                      selectEffect: gardenCoopController.selectEffect,
                      selectMusic: gardenCoopController.selectMusic,
                      onChangedEffect: (p0) => {
                        gardenCoopController.selectEffect = p0,
                        // print('selectEffect: ${gardenCoopController.selectEffect}'),
                        gardenCoopController.update()
                      },
                      onChangedMusic: (p0) => {
                        gardenCoopController.selectMusic = p0,
                        gardenCoopController.initAudio(
                            asset: gardenCoopController.selectMusic?.value ??
                                Assets.audios.peacefulgarden),
                        // print('selectEffect: ${gardenCoopController.selectEffect}'),
                        gardenCoopController.update()
                      },
                    );
                    // });
                    // Get.back();
                  },
                ),
              ]
            ],
          ),
        ));
  }

  Widget _buildBody() {
    return gardenCoopController.obx((state) => Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.zero,
              child: RiveAnimation.asset(
                !gardenCoopController.isRain
                    ? DateTime.now().hour >= 18
                        ? Assets.backgrounds.skyMoonNight
                        : Assets.backgrounds.skySunDay
                    : Assets.backgrounds.skyRain,
                fit: BoxFit.cover,
              ),
            ),
            userController.obx(
              (state) {
                if (userController.user?.user == null ||
                    userController.user?.plants == null ||
                    userController.user?.money == null) {
                  userController.logOut();
                }
                return Positioned.fill(
                  child: Graden(
                    isEdit: gardenCoopController.isEdit,
                    isCoop: true,
                    userData: gardenCoopController.userData ?? UserData(),
                    changeUI: () {
                      gardenCoopController.changeUI();
                    },
                    update: (UserData userData) {
                      // userController.user = userData;
                      // gardenCoopController.userData = userData;
                      // userController.updateUser(userData: userController.user);
                      // gardenCoopController.initDataEffect();
                      gardenCoopController.update();
                    },
                  ),
                );
              },
            ),
            Container(
              // height: 200,
              padding: const EdgeInsets.only(top: 20),
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: 20),
              child: BlurBox(
                blurColor: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    coopWidget(
                        userData: gardenCoopController.userData!,
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                                  text: gardenCoopController
                                          .userData?.user?.userID ??
                                      ''))
                              .then((_) {
                            buildToast(
                                message: 'Đã sao chép'.tr,
                                status: TypeToast.toastDefault);
                          });
                        }),
                    IconButton(
                      icon: const Icon(LucideIcons.chevronLeft),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
            // userController.obx(
            //   (state) => ToolLevel(
            //     showLevel: true,
            //     user: userController.user ?? UserData(),
            //   ),
            // ),
            if (gardenCoopController.selectEffect?.value != null)
              IgnorePointer(
                ignoring: true,
                child: Container(
                  // color:
                  //     Colors.black.withOpacity(0.5), // Màu nền đen với độ mờ 50%
                  width: Get.width,
                  height: Get.height,
                  padding: EdgeInsets.zero,
                  child: RiveAnimation.asset(
                    gardenCoopController.selectEffect?.value ?? '',
                    // 'assets/rive/overlay/overlay1.riv',
                    fit: BoxFit.cover,
                  ),
                  // Căn container để nó phủ lên toàn bộ màn hình
                ),
              ),
            if (gardenCoopController.isWater)
              waterRain(gardenCoopController.isWater),
            if (gardenCoopController.isLike)
              likeWidget(gardenCoopController.isLike),
          ],
        ));
  }
}
