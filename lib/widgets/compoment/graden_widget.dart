import 'package:flutter/material.dart';
import 'package:flutx_ui/widgets/dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/widgets/compoment/action_menu.dart';
import 'package:terrarium_idle/widgets/compoment/picker_plants_pots.dart';
import 'package:terrarium_idle/widgets/compoment/rive_animation_item.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';

class Graden extends StatefulWidget {
  final bool isEdit;
  final UserData userData;
  final Function(UserData) update;
  const Graden(
      {super.key,
      required this.isEdit,
      required this.userData,
      required this.update});

  @override
  State<Graden> createState() => _GradenState();
}

class _GradenState extends State<Graden> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: PieCanvas(
        child: Row(
          children: [
            Image.asset('assets/images/r1.png'),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,

                  padding: EdgeInsets.only(
                      bottom: kBottomNavigationBarHeight,
                      top: kToolbarHeight + Get.height * 0.1),
                  shrinkWrap: true,
                  reverse: true,
                  children: [
                    for (int floor = 1;
                        floor <= (widget.userData.user?.userFloor ?? 1);
                        floor++)
                      Container(
                        height: Get.height * 0.3,
                        margin: const EdgeInsets.only(bottom: 0),
                        // color: Colors.green,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: textBodySmall('Tầng $floor',
                                    color: Colors.white24)),
                            Expanded(
                              child: Row(children: [
                                for (int position = 1;
                                    position <= 3;
                                    position++)
                                  (widget.userData.plants!
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
                                          actions: [
                                            ...listActionsMenu(context,
                                                floor: floor,
                                                position: position,
                                                userData: widget.userData,
                                                update: widget.update)
                                          ],
                                          child: Container(
                                            padding: EdgeInsets.zero,
                                            // color: Colors.red,
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                Plants plant = widget
                                                    .userData.plants!
                                                    .firstWhere((element) =>
                                                        element.position!.contains(
                                                            '$floor,$position'));

                                                return riveAnimation(
                                                    constraints,
                                                    plantId: plant.idPlant!,
                                                    potId: plant.idPot!,
                                                    level:
                                                        plant.plantLevel ?? 1);
                                              },
                                            ),
                                          ),
                                        ))
                                      : Expanded(
                                          child: widget.isEdit
                                              ? GestureDetector(
                                                  onTap: () {
                                                    ShareFuntion.tapPlayAudio();
                                                    showPickPotsAndPlants(
                                                        floor: floor,
                                                        position: position,
                                                        userData:
                                                            widget.userData,
                                                        update: widget.update);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    child: DottedBorder(
                                                      color: Get
                                                          .theme.primaryColor,
                                                      strokeWidth: 2,
                                                      borderType:
                                                          BorderType.RRect,
                                                      radius:
                                                          const Radius.circular(
                                                              12),
                                                      dashPattern: const [
                                                        6,
                                                        3,
                                                        2,
                                                        3
                                                      ],
                                                      child: Center(
                                                          child: Icon(
                                                        LucideIcons.sprout,
                                                        size: 50,
                                                        color: Get
                                                            .theme.primaryColor,
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox())
                              ]),
                            ),
                            Image.asset('assets/images/r2.png')
                          ],
                        ),
                      ),
                    // cHeight(kToolbarHeight)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
