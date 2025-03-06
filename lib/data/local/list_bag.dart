import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/item.dart';
import 'package:terrarium_idle/function/color_helper.dart';

List<ItemData> listBagsData = [
  ItemData(
    id: 'bag1',
    name: 'Kinh nghiệm nhà vườn'.tr,
    description: 'đạt khi tới level 50',
    image: 'https://i.imgur.com/lNNpfPS.png',
    priceStore: 0,
    priceOxygen: 0,
    currencyUnit: '',
    type: 'bag',
    effect: Colors.black.toInt32.toString(),
    levelUnlock: 1,
  ),
  ItemData(
    id: 'bag2',
    name: 'Triệu phú tích trữ'.tr,
    description: 'đạt khi tích lượng oxygen = 100000',
    image: 'https://i.imgur.com/KYcMj2f.jpeg',
    priceStore: 0,
    priceOxygen: 0,
    currencyUnit: '',
    type: 'bag',
    effect: Colors.blue.shade700.toInt32.toString(),
    levelUnlock: 1,
  ),
  ItemData(
    id: 'bag3',
    name: 'Triệu phú giàu sang'.tr,
    description: 'đạt được khi mở khóa thành công 20 tầng',
    image: 'https://i.imgur.com/FIhoo77.png',
    priceStore: 0,
    priceOxygen: 0,
    currencyUnit: '',
    type: 'bag',
    effect: Colors.green.shade700.toInt32.toString(),
    levelUnlock: 1,
  ),
  ItemData(
    id: 'bag4',
    name: 'Lá xanh trắng bay'.tr,
    description: 'nhận trong sự kiện',
    image: 'https://i.imgur.com/kdiEu3g.png',
    priceStore: 0,
    priceOxygen: 0,
    currencyUnit: '',
    type: 'bag',
    effect: Colors.lightGreen.shade800.toInt32.toString(),
    levelUnlock: 1,
  ),
];
