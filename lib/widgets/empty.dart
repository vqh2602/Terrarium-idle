import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';
import 'package:flutx_ui/flutx.dart';

Widget emptyWidget({double? width, double? height, Function? onTap}) {
  return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Lottie.asset('assets/animation/empty.json'),
          textBodyMedium('Không có thông tin!'),
          cHeight(12),
          if (onTap != null)
            FxButton.outlined(
                borderColor: Get.theme.primaryColor,
                child: textBodyMedium('Làm mới'),
                onPressed: () {
                  onTap();
                })
        ]),
      ));
}
