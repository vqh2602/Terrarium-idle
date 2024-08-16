import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';

Widget likeWidget(bool isShow) {
  return IgnorePointer(
    ignoring: false,
    child: Opacity(
      opacity: 1,
      child: Container(
        key: Key('light_like${isShow.toString()}'),
        // color:
        //     Colors.black.withOpacity(0.5), // Màu nền đen với độ mờ 50%
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.zero,
        child: RiveAnimation.asset(
          Assets.rive.overlay.lightLike,
          onInit: (artboardRive) async {
            var artboard = artboardRive;

            var state = StateMachineController.fromArtboard(
                artboard, 'State Machine 1');
            var input = state!.findInput<bool>('Hover') as SMIBool;
            input.change(false);
            artboard.addController(state);
            await Future.delayed(const Duration(milliseconds: 200), () {});

            input = state.findInput<bool>('Hover') as SMIBool;
            input.change(true);

            artboard.addController(state);

            // await Future.delayed(const Duration(seconds: 200), () {});
            var input1 = state.findInput<bool>('Pressed') as SMIBool;
            input1.change(true);
            artboard.addController(state);
          },
          fit: BoxFit.cover,
        ),
        // Căn container để nó phủ lên toàn bộ màn hình
      ),
    ),
  );
}
