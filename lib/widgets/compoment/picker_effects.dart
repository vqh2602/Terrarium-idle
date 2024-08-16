import 'package:flutter/material.dart';
import 'package:flutx_ui/widgets/button/button.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/coop/garden_coop/garden_coop_controller.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

showPickEffects({
  required List<SelectOptionItem> listEffect,
  required List<SelectOptionItem> listMusic,
  SelectOptionItem? selectEffect,
  SelectOptionItem? selectMusic,
  Function(SelectOptionItem?)? onChangedEffect,
  Function(SelectOptionItem?)? onChangedMusic,
  bool isCoop = false,
}) async {
  await Get.bottomSheet(
      !isCoop
          ? GetBuilder(
              init: GardenController(),
              builder: (controller) {
                return _bottomsheetEffects(
                    controller: controller,
                    listEffect: listEffect,
                    listMusic: listMusic,
                    onChangedEffect: onChangedEffect,
                    onChangedMusic: onChangedMusic);
              })
          : GetBuilder(
              init: GardenCoopController(),
              builder: (controller) {
                return _bottomsheetEffects(
                    controller: controller,
                    listEffect: listEffect,
                    listMusic: listMusic,
                    onChangedEffect: onChangedEffect,
                    onChangedMusic: onChangedMusic);
              }),
      isScrollControlled: true);
}

_pickEffect(
    {Function(SelectOptionItem?)? onChanged,
    required List<SelectOptionItem> listEffect,
    SelectOptionItem? selectEffect}) {
  return Column(
    children: [
      // if (idPot != '')
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child:
      //         textTitleLarge('Chậu đang chọn', fontWeight: FontWeight.w700),
      //   ),
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listEffect.length,
          itemBuilder: (BuildContext ctx, index) {
            return Material(
              child: _buttonPicker(
                  value: listEffect[index],
                  onChanged: onChanged,
                  selectEffect: selectEffect),
            );
          },
        ),
      )
    ],
  );
}

_pickMusic(
    {Function(SelectOptionItem?)? onChanged,
    required List<SelectOptionItem> listMusic,
    SelectOptionItem? selectMusic}) {
  return Column(
    children: [
      // if (idPot != '')
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child:
      //         textTitleLarge('Chậu đang chọn', fontWeight: FontWeight.w700),
      //   ),
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listMusic.length,
          itemBuilder: (BuildContext ctx, index) {
            return Material(
              child: _buttonPicker(
                  value: listMusic[index],
                  onChanged: onChanged,
                  selectEffect: selectMusic),
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
    title: textBodyMedium(value.key ?? ''),
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
      child: textBodyMedium(
          'Trồng cây hoặc chậu có hiệu ứng đặc biệt để mở khóa'.tr,
          textAlign: TextAlign.center,
          color: Colors.black),
    ),
  );
}

_bottomsheetEffects(
    {dynamic controller,
    listEffect,
    listMusic,
    onChangedEffect,
    onChangedMusic}) {
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
                        child: textTitleLarge('Hiệu ứng'.tr,
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                    cWidth(8),
                    Expanded(
                      child: FxButton.medium(
                        backgroundColor:
                            !isEffect ? Get.theme.primaryColor : Colors.grey,
                        onPressed: () {
                          setState(() {
                            isEffect = false;
                          });
                          ShareFuntion.tapPlayAudio();
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: textTitleLarge('Âm nhạc'.tr,
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    )
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
                  listEffect.isNotEmpty
                      ? _pickEffect(
                          listEffect: listEffect,
                          selectEffect: controller.selectEffect,
                          onChanged: onChangedEffect,
                        )
                      : _showEmpty(),
                  listMusic.isNotEmpty
                      ? _pickMusic(
                          listMusic: listMusic,
                          selectMusic: controller.selectMusic,
                          onChanged: onChangedMusic,
                        )
                      : _showEmpty(),
                ],
              ),
            ),
          ],
        );
      }));
}
