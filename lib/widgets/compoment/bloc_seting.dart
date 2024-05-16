import 'package:terrarium_idle/c_theme/colors.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget blockSetting(
    {double? height,
    Color? color,
    String title = '',
    IconData? icon,
    Function()? onTap,
    bool showLeading = true}) {
  return GestureDetector(
    onTap: () {
      if (onTap != null) onTap();
    },
    child: Container(
        height: height,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: color ?? b500.withOpacity(.05),
          // border: Border.all(
          //   // color: Colors.white.withOpacity(.7),
          //   // width: 1,
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: Colors.black,
                      size: 16,
                    ),
                    cWidth(8),
                  ],
                  Expanded(
                    child: textLableMedium(title,
                        color: Get.isDarkMode ? null : text500),
                  ),
                ],
              ),
            ),
            if (showLeading)
              Icon(
                LucideIcons.chevronRight,
                color: Get.isDarkMode ? null : text500,
              )
          ],
        )),
  );
}
