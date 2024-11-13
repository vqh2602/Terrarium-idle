import 'package:flutter/material.dart';
import 'package:flutx_ui/widgets/button/button.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/coop/garden_coop/garden_coop_controller.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';

import 'package:terrarium_idle/widgets/widgets.dart';

// hiển thị thời tiết
showPickWeather({
  required List<SelectOptionItem> listWeather,
  SelectOptionItem? selectWeather,
  Function(SelectOptionItem?)? onChangedWeather,
  bool isCoop = false,
}) async {
  await Get.bottomSheet(
      isCoop
          ? GetBuilder(
              init: GardenCoopController(),
              builder: (controller) {
                return _bottomsheetEffects(
                    listWeather: listWeather,
                    selectWeather: controller.selectWeatherLandscape,
                    onChangedWeather: onChangedWeather);
              })
          : GetBuilder(
              init: GardenController(),
              builder: (controller) {
                return _bottomsheetEffects(
                    listWeather: listWeather,
                    selectWeather: controller.selectWeatherLandscape,
                    onChangedWeather: onChangedWeather);
              }),
      isScrollControlled: true);
}

_pickEffect({
  required List<SelectOptionItem> listWeather,
  SelectOptionItem? selectWeather,
  Function(SelectOptionItem?)? onChangedWeather,
}) {
  return Column(
    children: [
      // if (idPot != '')
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child:
      //         SText.titleLarge('Chậu đang chọn', fontWeight: FontWeight.w700),
      //   ),
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listWeather.length,
          itemBuilder: (BuildContext ctx, index) {
            return Material(
              child: _buttonPicker(
                  value: listWeather[index],
                  selectEffect: selectWeather,
                  onChanged: onChangedWeather),
            );
          },
        ),
      )
    ],
  );
}

_buttonPicker(
    {required SelectOptionItem value,
    SelectOptionItem? selectEffect,
    Function(SelectOptionItem?)? onChanged}) {
  return RadioListTile<SelectOptionItem>(
    title: SText.bodyMedium(value.key ?? ''),
    value: value,
    // toggleable: value.key == selectEffect?.key,
    groupValue: selectEffect,
    onChanged: onChanged,
  );
}

_showEmpty() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Center(
      child: SText.bodyMedium(
          'Trồng cây hoặc chậu có hiệu ứng đặc biệt để mở khóa'.tr,
          textAlign: TextAlign.center,
          color: Colors.black),
    ),
  );
}

_bottomsheetEffects({
  required List<SelectOptionItem> listWeather,
  SelectOptionItem? selectWeather,
  Function(SelectOptionItem?)? onChangedWeather,
}) {
  PageController pageController = PageController();

  bool isEffect = true;
  return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: Get.height * 0.8,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            cHeight(12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FxButton.medium(
                        backgroundColor:
                            isEffect ? Get.theme.primaryColor : Colors.grey,
                        onPressed: () {
                          setState(() {
                            isEffect = true;
                          });
                          ShareFuntion.tapPlayAudio();
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: SText.titleMedium('Thời tiết'.tr,
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    isEffect = index == 0;
                  });
                },
                children: [
                  listWeather.isNotEmpty
                      ? _pickEffect(
                          listWeather: listWeather,
                          selectWeather: selectWeather,
                          onChangedWeather: onChangedWeather)
                      : _showEmpty(),
                ],
              ),
            ),
          ],
        );
      }));
}
