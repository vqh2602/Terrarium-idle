import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/user/user_screen.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';

import 'package:terrarium_idle/widgets/widgets.dart';

class ToolLevel extends StatefulWidget {
  final bool showLevel;
  final UserData user;
  const ToolLevel({super.key, required this.showLevel, required this.user});

  @override
  State<ToolLevel> createState() => _ToolLevelState();
}

class _ToolLevelState extends State<ToolLevel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: kToolbarHeight,
        child: Row(
          children: [
            if (widget.showLevel) cWidth(20),
            if (widget.showLevel)
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    ShareFuntion.tapPlayAudio(
                        type: TypeSound.tap, isNewAudioPlay: true);
                    Get.toNamed(UserScreen.routeName);
                  },
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
                            SText.bodyMedium(
                                'Level: ${widget.user.user?.userLevel ?? 1}',
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            LinearProgressIndicator(
                              value: (widget.user.user?.userLevelEXP ?? 0) /
                                  ((1000 * (widget.user.user?.userLevel ?? 1)) *
                                      0.75),
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(100),
                              backgroundColor: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.showLevel) cWidth(20),
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
                        _itemTool(
                            constraints: constraints,
                            image: Assets.images.oxygen.path,
                            data: widget.user.money?.oxygen ?? 0),
                        _itemTool(
                            constraints: constraints,
                            image: Assets.images.gemstone.path,
                            data: widget.user.money?.gemstone ?? 0),
                        _itemTool(
                            constraints: constraints,
                            image: Assets.images.fertilizer.path,
                            data: widget.user.item?.fertilizer ?? 0),
                        _itemTool(
                            constraints: constraints,
                            image: Assets.images.shovel.path,
                            data: widget.user.item?.shovel ?? 0),
                        _itemTool(
                            constraints: constraints,
                            image: Assets.images.ticket.path,
                            data: widget.user.money?.ticket ?? 0),
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
}

_itemTool(
    {required BoxConstraints constraints,
    required int data,
    required String image}) {
  return GestureDetector(
    onTap: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: ShareFuntion.isIpad()
              ? constraints.maxWidth * 0.03
              : constraints.maxWidth * 0.10,
          height: ShareFuntion.isIpad()
              ? constraints.maxWidth * 0.03
              : constraints.maxWidth * 0.10,
        ),
        SText.bodySmall(ShareFuntion.shortenNumber(data),
            fontWeight: FontWeight.bold, color: Colors.black)
      ],
    ),
  );
}
