// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:rive/rive.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/models/ranking.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/coop/coop_screen.dart';
import 'package:terrarium_idle/modules/event/event_screen.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:terrarium_idle/modules/gift/gift_screen.dart';
import 'package:terrarium_idle/modules/store/store_screen.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/compoment/graden_widget.dart';
import 'package:terrarium_idle/widgets/compoment/picker_effects.dart';
import 'package:terrarium_idle/widgets/compoment/picker_weather.dart';
import 'package:terrarium_idle/widgets/compoment/tool_level.dart';
import 'package:terrarium_idle/widgets/compoment/water_rain.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});
  static const String routeName = '/garden';

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen>
    with SingleTickerProviderStateMixin {
  GardenController gardenController = Get.find();
  UserController userController = Get.find();

  final _key = GlobalKey<ExpandableFabState>();
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    gardenController.checkLogin();
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
        gardenController.isRain = ShareFuntion.gacha(winRate: 5);
        gardenController.update();
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
        createFloatingActionButton: gardenController.obx(
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
              if (!gardenController.isWater) ...[
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
                    gardenController.isWater = true;
                    gardenController.update();
                    await Future.delayed(const Duration(seconds: 12), () {
                      gardenController.isWater = false;
                      gardenController.update();
                    });
                    UserData? userData = userController.user;
                    // mỗi lần trời mưa có 10% nhận 5 oxygen và 50exp người dùng
                    if (ShareFuntion.gacha(winRate: 50)) {
                      userData = userData?.copyWith(
                        money: userData.money?.copyWith(
                          oxygen: (userData.money?.oxygen ?? 0) + 5,
                        ),
                        user: userData.user!.copyWith(
                            userLevelEXP: userData.user!.userLevelEXP! + 50),
                      );
                      await userController.updateUser(userData: userData!);
                      userController.getUserData();
                    }
                    // });
                    // Get.back();
                  },
                ),
                FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  heroTag: null,
                  child: const Icon(
                    LucideIcons.calendarRange,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    // ShareFuntion.tapPlayAudio();
                    Get.toNamed(EventScreen.routeName);
                    _key.currentState?.toggle();
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: const Icon(
                    LucideIcons.shoppingBag,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    Get.toNamed(StoreScreen.routeName);
                    // ShareFuntion.tapPlayAudio();
                    _key.currentState?.toggle();
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: const Icon(
                    LucideIcons.handshake,
                    color: Colors.indigo,
                  ),
                  onPressed: () {
                    // ShareFuntion.tapPlayAudio();
                    Get.toNamed(CoopScreen.routeName);
                    _key.currentState?.toggle();
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: Icon(
                    gardenController.isEdit
                        ? LucideIcons.pencilOff
                        : LucideIcons.penLine,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _key.currentState?.toggle();
                    // ShareFuntion.tapPlayAudio();
                    gardenController.isEdit = !gardenController.isEdit;
                    gardenController.update();
                  },
                ),
                FloatingActionButton(
                  heroTag: null,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: const Icon(
                    LucideIcons.tentTree,
                    color: Colors.lime,
                  ),
                  onPressed: () {
                    _key.currentState?.toggle();
                    // ShareFuntion.tapPlayAudio();
                    showPickWeather(
                      listWeather:
                          gardenController.listSelectOptionWeatherLandscape,
                      selectWeather: gardenController.selectWeatherLandscape,
                      onChangedWeather: (p0) => {
                        gardenController.selectWeatherLandscape = p0,
                        gardenController.update(),
                      },
                      // isCoop: false,
                    );
                    // gardenController.update();
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
                      listEffect: gardenController.listSelectOptionEffect,
                      listMusic: gardenController.listSelectOptionMusic,
                      selectEffect: gardenController.selectEffect,
                      selectMusic: gardenController.selectMusic,
                      onChangedEffect: (p0) => {
                        gardenController.selectEffect = p0,
                        // print('selectEffect: ${gardenController.selectEffect}'),
                        gardenController.update()
                      },
                      onChangedMusic: (p0) => {
                        gardenController.selectMusic = p0,
                        gardenController.initAudio(
                            asset: gardenController.selectMusic?.value ??
                                Assets.audios.peacefulgarden),
                        // print('selectEffect: ${gardenController.selectEffect}'),
                        gardenController.update()
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
    return gardenController.obx((state) => Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.zero,
              child: RiveAnimation.asset(
                gardenController.selectWeatherLandscape != null &&
                        gardenController.selectWeatherLandscape?.value != ''
                    ? gardenController.selectWeatherLandscape!.value!
                    : !gardenController.isRain
                        ? (DateTime.now().hour >= 6 && DateTime.now().hour < 15)
                            ? Assets.backgrounds.skySunDay
                            : (DateTime.now().hour >= 15 &&
                                    DateTime.now().hour < 19)
                                ? Assets.backgrounds.skySunSet
                                : Assets.backgrounds.skyMoonNight
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
                    isEdit: gardenController.isEdit,
                    isCoop: false,
                    userData: userController.user ?? UserData(),
                    rank: userController.rank,
                    updateRank: (Ranking ranking) {
                      userController.rank = ranking;
                      userController.updateDataRank(rank: ranking);
                      userController.update();
                    },
                    changeUI: () {
                      gardenController.changeUI();
                    },
                    update: (UserData userData) {
                      userController.user = userData;
                      gardenController.userData = userData;
                      userController.updateUser(userData: userData);

                      gardenController.initDataEffect();
                      gardenController.initDataMusic();

                      gardenController.update();
                    },
                    isGraphicsHight: userController.isGraphicsHight,
                    isCache: userController.isCache,
                  ),
                );
              },
            ),
            userController.obx(
              (state) => ToolLevel(
                showLevel: true,
                user: userController.user ?? UserData(),
              ),
            ),
            if (gardenController.selectEffect != null &&
                gardenController.selectEffect?.value != '')
              IgnorePointer(
                ignoring: true,
                child: Container(
                  // color:
                  //     Colors.black.withOpacity(0.5), // Màu nền đen với độ mờ 50%
                  width: Get.width,
                  height: Get.height,
                  padding: EdgeInsets.zero,
                  child: RiveAnimation.asset(
                    gardenController.selectEffect?.value ?? '',
                    // 'assets/rive/overlay/overlay1.riv',
                    fit: BoxFit.cover,
                  ),
                  // Căn container để nó phủ lên toàn bộ màn hình
                ),
              ),
            if (gardenController.isWater) waterRain(gardenController.isWater),
            Align(
              alignment: Alignment.bottomLeft,
              child: GiftScreen(),
            )
          ],
        ));
  }
}
