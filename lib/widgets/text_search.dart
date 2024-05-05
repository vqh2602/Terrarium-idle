import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget textSearch({
  required TextEditingController textController,
  String? hintText,
  EdgeInsets? padding,
  double widthSearch = 65,
  required Function onTapSearch,
  FocusNode? focusNode,
}) {
  return TextField(
      controller: textController,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText ?? 'Nhập từ khoá',
        contentPadding: padding ?? const EdgeInsets.fromLTRB(12, 12, 12, 12),
        suffixIcon: Container(
          width: widthSearch,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Get.theme.primaryColor,
          ),
          child: IconButton(
            onPressed: () {
              onTapSearch();
            },
            icon: const Icon(
              LucideIcons.search,
              color: Colors.white,
            ),
          ),
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Get.theme.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ));
}
