import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showDialogCustom(Widget child) {
  Get.dialog(Container(
      padding: const EdgeInsets.all(0),
      width: Get.width,
      height: Get.height,
      child: BlurryContainer(
          child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.transparent,
            ),
          ),
          child
        ],
      ))));
}
