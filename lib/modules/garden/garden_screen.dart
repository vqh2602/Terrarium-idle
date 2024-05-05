// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutx_ui/widgets/dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:rive/rive.dart';
import 'package:terrarium_idle/data/local/data_test.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});
  static const String routeName = '/garden';

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  GardenController gardenController = Get.put(GardenController());

  @override
  void initState() {
    super.initState();
    gardenController.checkLogin();
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
      floatingActionButtonLocation: ExpandableFab.location,
      createFloatingActionButton: ExpandableFab(
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
              ShareFuntion.tapPlayAudio();
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
              ShareFuntion.tapPlayAudio();
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
              ShareFuntion.tapPlayAudio();
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
              ShareFuntion.tapPlayAudio();
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
              child: const RiveAnimation.asset(
                // 'assets/backgrounds/sky_sun_day.riv',
                'assets/backgrounds/sky_rain.riv',
                // 'assets/backgrounds/sky_moon_night.riv',
                fit: BoxFit.cover,
              ),
            ),
            _graden(),
            _tool(),
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

  _rivetest(BoxConstraints constraints) {
    return StatefulBuilder(builder: (context, setState) {
      SMIInput<double>? input;
      return Column(
        children: [
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.65,
            child: RiveAnimation.asset(
              'assets/rive/plants/plant1.riv',
              onInit: (artboard) {
                var state =
                    StateMachineController.fromArtboard(artboard, 'plant');
                input = state!.findInput<double>('level') as SMINumber;
                input!.change(3.0);
                setState(() {});
                // print(_input!.value);
                artboard.addController(state);
              },
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.35,
            child: const RiveAnimation.asset(
              'assets/rive/pots/pot1.riv',
            ),
          ),
        ],
      );
    });
  }

  _tool() {
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: 50,
        child: Row(
          children: [
            cWidth(20),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textBodyMedium('Level: 1', fontWeight: FontWeight.w700),
                        const LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            cWidth(20),
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/oxygen.png',
                                width: constraints.maxWidth * 0.10,
                                height: constraints.maxWidth * 0.10,
                              ),
                              textBodySmall('5000', fontWeight: FontWeight.w700)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/gemstone.png',
                                width: constraints.maxWidth * 0.10,
                                height: constraints.maxWidth * 0.10,
                              ),
                              textBodySmall('5000', fontWeight: FontWeight.w700)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/fertilizer.png',
                                width: constraints.maxWidth * 0.10,
                                height: constraints.maxWidth * 0.10,
                              ),
                              textBodySmall('5000', fontWeight: FontWeight.w700)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ticket.png',
                                width: constraints.maxWidth * 0.10,
                                height: constraints.maxWidth * 0.10,
                              ),
                              textBodySmall('5000', fontWeight: FontWeight.w700)
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            cWidth(12),
          ],
        ),
      ),
    );
  }

  _graden() {
    return PieCanvas(
      child: Row(
        children: [
          Image.asset('assets/images/r1.png'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int floor = 1;
                      floor <= (dataTest.user?.userFloor ?? 1);
                      floor++)
                    Container(
                      height: Get.height * 0.27,
                      margin: const EdgeInsets.only(bottom: 20),
                      // color: Colors.green,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: textBodySmall('Tầng $floor',
                                  color: Colors.white24)),
                          Expanded(
                            child: Row(children: [
                              for (int position = 1; position <= 3; position++)
                                (dataTest.plants!
                                        .where((element) => element.position!
                                            .contains('$floor,$position'))
                                        .isNotEmpty)
                                    ? Expanded(
                                        child: PieMenu(
                                        onToggle: (val) {
                                          ShareFuntion.tapPlayAudio();
                                        },
                                        onPressed: () {
                                          ShareFuntion.tapPlayAudio();
                                        },
                                        theme: const PieTheme(
                                            overlayColor: Colors.black45,
                                            rightClickShowsMenu: true,
                                            customAngleAnchor:
                                                PieAnchor.center),
                                        actions: [..._listActionsMenu()],
                                        child: Container(
                                          // color: Colors.red,
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return _rivetest(constraints);
                                            },
                                          ),
                                        ),
                                      ))
                                    : Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            ShareFuntion.tapPlayAudio();
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
                                        ),
                                      )
                            ]),
                          ),
                          Image.asset('assets/images/r2.png')
                        ],
                      ),
                    ),
                  cHeight(kToolbarHeight)
                ].reversed.toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  _itemMenuPlant(String title) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: textBodySmall(title,
            color: Get.theme.primaryColor, fontWeight: FontWeight.w700));
  }

  _listActionsMenu() {
    return [
      PieAction(
        tooltip: _itemMenuPlant('sell'),
        onSelect: () {},
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
        onSelect: () {},
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
        onSelect: () {},
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
        onSelect: () {},
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
}
