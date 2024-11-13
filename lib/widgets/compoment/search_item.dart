import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';
import 'package:terrarium_idle/widgets/image_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

Widget searchItem<T>(
    {required Function(SelectOptionItem<T>?) onSelected,
    SelectOptionItem<T>? initialValue,
    required List<SelectOptionItem<T>> options,

    /// nếu image == true thì value sẽ là url image
    bool isImage = false,
    double? width}) {
  return CustomDropdown<SelectOptionItem<T>>.searchRequest(
    // hintText: 'Chọn phân loại'.tr,
    hintBuilder: (context, hint, enabled) {
      return SText.bodyMedium('Chọn phân loại'.tr);
    },
    searchHintText: 'Tìm kiếm'.tr,
    listItemBuilder: (context, item, isSelected, onItemSelect) => isImage
        ? Row(
            children: [
              imageNetwork(
                url: item.value.toString(),
                width: 25,
                height: 25,
              ),
              cWidth(4),
              SText.bodyMedium('${item.key}')
            ],
          )
        : SText.bodyMedium('${item.key} (${item.value})'),
    headerBuilder: (context, selectedItem, enabled) => isImage
        ? Row(
            children: [
              imageNetwork(
                url: selectedItem.value.toString(),
                width: 25,
                height: 25,
              ),
              SText.bodyMedium('${selectedItem.key}')
            ],
          )
        : SText.bodyMedium('${selectedItem.key} (${selectedItem.value})'),
    items: options,
    initialItem: initialValue,
    excludeSelected: false,
    overlayHeight: width ?? Get.width,
    validator: (value) {
      if (value == null) {
        return '';
      }
      return null;
    },
    onChanged: (value) async {
      await onSelected.call(value);
      // Get.back();
    },

    decoration: CustomDropdownDecoration(
      closedFillColor: Colors.white,
      closedBorder: Border.all(color: Get.theme.primaryColor),

      // expandedBorder: Border.all(),
    ),
    futureRequest: (String search) {
      return Future.delayed(
          const Duration(milliseconds: 200),
          () => options
              .where((element) =>
                  (element.value
                          ?.toLowerCase()
                          .contains(search.toLowerCase()) ??
                      false) ||
                  (element.key?.toLowerCase().contains(search.toLowerCase()) ??
                      false))
              .toList());
    },
  );
}
