import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

Widget waterRain(bool isShow) {
  return   IgnorePointer(
    ignoring: false,
    child: Opacity(
      opacity: 0.5,
      child: Container(
        key: Key('cloud_icon${isShow.toString()}'),
        // color:
        //     Colors.black.withOpacity(0.5), // Màu nền đen với độ mờ 50%
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.zero,
        child: RiveAnimation.asset(
          'assets/rive/overlay/cloud_icon.riv',
          onInit: (artboardRive) {
            var artboard = artboardRive;
            // print('/n animation plant: $plantId $level');
          var  state = StateMachineController.fromArtboard(
                artboard, 'State Machine 1');
            var input = state!.findInput<bool>('isPressed') as SMIBool;
            input.change(true);
            // print(_input!.value);
            artboard.addController(state);
          },
          fit: BoxFit.cover,
        ),
        // Căn container để nó phủ lên toàn bộ màn hình
      ),
    ),
  );
}