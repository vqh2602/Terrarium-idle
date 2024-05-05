import 'package:flutter/material.dart';
import 'package:flutx_ui/flutx.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

/// bắn thống báo + hiệu ứng pháo hoa
dialogConfetti({
  bool? isShowConfetti,
  String? description,
  String? images,
  String? title,
  Function? onPressed,
  Color? backgroundColor,
  Color? textColor,
  Color? buttonColor,
  Color? textButtonColor,
  Color? boxShadowColor,
}) {
  Get.dialog(Material(
    child: Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          AbsorbPointer(
            absorbing: false,
            child: Visibility(
              visible: isShowConfetti ?? false,
              child: SizedBox(
                width: Get.width,
                height: Get.height,
                child: Lottie.asset('assets/iconAnimation/confetti.json',
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.purple.shade700,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: boxShadowColor ?? Colors.transparent,
                      spreadRadius: 20,
                      blurRadius: 50,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (images != null)
                    Image.asset(
                      images,
                      height: Get.width * 0.4,
                    ),
                  cHeight(20),
                  textDisplayMedium(title ?? '',
                      color: textColor ?? Colors.white,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w900),
                  cHeight(20),
                  textBodyLarge(description ?? '',
                      color: textColor ?? Colors.white,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w900),
                  cHeight(20),
                  FxButton.medium(
                      onPressed: () {
                        if (onPressed != null) {
                          onPressed();
                        }
                      },
                      backgroundColor: buttonColor,
                      child: textBodyMedium('Xác nhận'.tr,
                          fontWeight: FontWeight.bold,
                          color: textButtonColor ?? Colors.white))
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}
