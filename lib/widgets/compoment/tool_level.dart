import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/user/user_screen.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
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
                            textBodyMedium(
                                'Level: ${widget.user.user?.userLevel ?? 1}',
                                fontWeight: FontWeight.w700,
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
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.images.oxygen.path,
                                width: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                                height: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                              ),
                              textBodySmall('${widget.user.money?.oxygen ?? 0}',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.images.gemstone.path,
                                width: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                                height: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                              ),
                              textBodySmall(
                                  '${widget.user.money?.gemstone ?? 0}',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.images.fertilizer.path,
                                width: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                                height: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                              ),
                              textBodySmall(
                                  '${widget.user.item?.fertilizer ?? 0}',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.images.shovel.path,
                                width: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                                height: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                              ),
                              textBodySmall('${widget.user.item?.shovel ?? 0}',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.images.ticket.path,
                                width: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                                height: ShareFuntion.isIpad()
                                    ? constraints.maxWidth * 0.03
                                    : constraints.maxWidth * 0.10,
                              ),
                              textBodySmall('${widget.user.money?.ticket ?? 0}',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)
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
}
