import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

/// chọn 1 phần tử trong danh sách
///
/// phải được bao bằng get.bottomsheet
Widget showBottomListChose(
    {List<SelectOptionItem>? options,
    SelectOptionItem? value,
    Function(SelectOptionItem)? onSelect,
    Function? onCancel,
    Function? onSubmitted,
    Function? onSearch,
    String? title,
    Widget Function(SelectOptionItem)? buildOption}) {
  return StatefulBuilder(
      builder: ((context, setState) => Container(
            height: Get.height * 0.55,
            width: Get.width,
            padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12)),
                    width: Get.width * 0.1,
                    height: 3,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          if (onCancel != null) onCancel();
                        },
                        icon: textBodyMedium(
                          'Huỷ',
                          // color: Get.theme.primaryColor,
                        )),
                    textTitleMedium(
                      title ?? "Danh sách",
                      // fontWeight: 800,
                      fontSize: 18,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                          if (onSubmitted != null) onSubmitted();
                        },
                        icon: textBodyMedium(
                          'Thêm',
                          color: Get.theme.primaryColor,
                        ))
                  ],
                ),
                const Divider(),
                TextField(
                  // controller: textEditingController,
                  decoration: InputDecoration(
                      labelText: "Tìm kiếm...",
                      labelStyle: const TextStyle(fontSize: 14),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 1,
                          )),
                      suffixIcon: InkWell(
                          onTap: () {}, child: const Icon(Icons.close))),
                  onSubmitted: (value) {},
                  onChanged: (value) {
                    if (onSearch != null) onSearch(value);
                  },
                ),
                cHeight(8),
                Expanded(
                  child: ListView.builder(
                    itemCount: options?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (onSelect != null) onSelect(options[index]);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          decoration: BoxDecoration(
                              color: value == options![index]
                                  ? Get.theme.primaryColor
                                  : (index % 2 == 0
                                      ? Get.theme.colorScheme.surface
                                      : Get.theme.colorScheme.onSurface
                                          .withOpacity(0.05)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: buildOption!(options[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )));
}

/// Ô nhập đoạn văn
///
/// phải được bao bằng get.bottomsheet
Widget showBottomTextInput(TextEditingController? controller,
    {String? title,
    bool? autocorrect,
    Function? onCancel,
    Function? onSubmitted,
    Function? onChange,
    TextInputType? keyboardType}) {
  return Container(
    padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
    decoration: BoxDecoration(
      color: Get.theme.colorScheme.surface,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), topRight: Radius.circular(12)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                  if (onCancel != null) onCancel();
                },
                icon: textBodyMedium(
                  'Đóng',
                  // color: Get.theme.primaryColor,
                )),
            textTitleMedium(
              title ?? "Nhập thông tin",
              // fontWeight: 800,
              fontSize: 18,
            ),
            IconButton(
                onPressed: () {
                  Get.back();
                  if (onSubmitted != null) onSubmitted();
                },
                icon: textBodyMedium(
                  'Thêm',
                  color: Get.theme.primaryColor,
                ))
          ],
        ),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            child: TextField(
              autocorrect: autocorrect ?? true,
              maxLines: 16,
              controller: controller,
              keyboardType: keyboardType,
              onChanged: (val) {
                if (onChange != null) onChange(val);
              },
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Nhập thông tin...'),
            ),
          ),
        ),
      ],
    ),
  );
}

/// chọn nhiều phần tử trong danh sách
///
/// phải được bao bằng get.bottomsheet
Widget showBottomListMutilChose(
    {List<SelectOptionItem>? options,
    List<SelectOptionItem>? value,
    Function(SelectOptionItem)? onSelect,
    Function? onSearch,
    Function? onCancel,
    Function? onSubmitted,
    String? title,
    Widget Function(SelectOptionItem)? buildOption}) {
  return StatefulBuilder(
      builder: ((context, setState) => Container(
            height: Get.height * 0.55,
            width: Get.width,
            padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12)),
                    width: Get.width * 0.1,
                    height: 3,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          if (onCancel != null) onCancel();
                        },
                        icon: textBodyMedium(
                          'Huỷ',
                          // color: Get.theme.primaryColor,
                        )),
                    textTitleMedium(
                      title ?? "Danh sách",
                      // fontWeight: 800,
                      fontSize: 18,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                          if (onSubmitted != null) onSubmitted();
                        },
                        icon: textBodyMedium(
                          'Thêm',
                          color: Get.theme.primaryColor,
                        ))
                  ],
                ),
                const Divider(),
                TextField(
                  // controller: textEditingController,
                  decoration: InputDecoration(
                      labelText: "Tìm kiếm...",
                      labelStyle: const TextStyle(fontSize: 14),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 1,
                          )),
                      suffixIcon: InkWell(
                          onTap: () {}, child: const Icon(Icons.close))),
                  onSubmitted: (value) {},
                  onChanged: (value) {
                    if (onSearch != null) onSearch(value);
                  },
                ),
                cHeight(8),
                Expanded(
                  child: ListView.builder(
                    itemCount: options?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (onSelect != null) onSelect(options[index]);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          decoration: BoxDecoration(
                              color: value?.contains(options![index]) ?? false
                                  ? Get.theme.primaryColor
                                  : (index % 2 == 0
                                      ? Get.theme.colorScheme.surface
                                      : Get.theme.colorScheme.onSurface
                                          .withOpacity(0.05)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: buildOption!(options![index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )));
}
