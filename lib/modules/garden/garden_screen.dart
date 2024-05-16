// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:rive/rive.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/coop/coop_screen.dart';
import 'package:terrarium_idle/modules/event/event_screen.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:terrarium_idle/modules/store/store_screen.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/compoment/graden_widget.dart';
import 'package:terrarium_idle/widgets/compoment/tool_level.dart';

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
  @override
  void initState() {
    super.initState();
    gardenController.checkLogin();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      // backgroundColor: const Color(0xfffaf3e1),
      context: context,
      body: _buildBody(),
      appBar: null,
      floatingActionButtonLocation: ExpandableFab.location,
      createFloatingActionButton: ExpandableFab(
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
          FloatingActionButton(
            heroTag: null,
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            child: Icon(
              LucideIcons.droplets,
              color: Get.theme.primaryColor,
            ),
            onPressed: () {
              _key.currentState?.toggle();
              // ShareFuntion.tapPlayAudio();
              // Future.delayed(const Duration(seconds: 500), () {
              ShareFuntion.tapPlayAudio(
                  type: TypeSound.rain, isNewAudioPlay: true);
              // });
              // Get.back();
            },
          ),
          FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            heroTag: null,
            child: Icon(
              LucideIcons.calendarRange,
              color: Get.theme.primaryColor,
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
            child: Icon(
              LucideIcons.shoppingBag,
              color: Get.theme.primaryColor,
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
            child: Icon(
              LucideIcons.handshake,
              color: Get.theme.primaryColor,
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
              LucideIcons.penLine,
              color: Get.theme.primaryColor,
            ),
            onPressed: () {
              _key.currentState?.toggle();
              // ShareFuntion.tapPlayAudio();
              gardenController.isEdit = !gardenController.isEdit;
              gardenController.update();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return gardenController.obx((state) => Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.zero,
              child: RiveAnimation.asset(
                Random().nextInt(10) < 2
                    ? DateTime.now().hour > 18
                        ? 'assets/backgrounds/sky_moon_night.riv'
                        : 'assets/backgrounds/sky_sun_day.riv'
                    : 'assets/backgrounds/sky_rain.riv',
                fit: BoxFit.cover,
              ),
            ),
            userController.obx(
              (state) => Positioned.fill(
                child: Graden(
                  isEdit: gardenController.isEdit,
                  userData: userController.user ?? UserData(),
                  update: (UserData userData) {
                    userController.user = userData;
                    gardenController.updateDataUser(
                        userData: userController.user);
                    gardenController.update();
                  },
                ),
              ),
            ),
            userController.obx(
              (state) => ToolLevel(
                showLevel: true,
                user: userController.user ?? UserData(),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                // color:
                //     Colors.black.withOpacity(0.5), // Màu nền đen với độ mờ 50%
                width: Get.width,
                height: Get.height,
                padding: EdgeInsets.zero,
                child: const RiveAnimation.asset(
                  // 'assets/backgrounds/sky_sun_day.riv',
                  // 'assets/backgrounds/sky_rain.riv',
                  'assets/rive/overlay/overlay1.riv',
                  fit: BoxFit.cover,
                ),
                // Căn container để nó phủ lên toàn bộ màn hình
              ),
            )
          ],
        ));
  }
}
