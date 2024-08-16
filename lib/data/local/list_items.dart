import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/item.dart';

List<ItemData> listItemsData = [
  ItemData(
    id: 'item1',
    name: 'Phân bón x10'.tr,
    description: 'Kích thích tăng trưởng cho cây'.tr,
    image: 'https://i.imgur.com/dXKrKlk.png',
    priceStore: 200,
    priceOxygen: 200,
    currencyUnit: 'gemstone',
    type: 'item',
    effect: '',
    levelUnlock: 1,
  ),
  ItemData(
    id: 'item2',
    name: 'Xẻng'.tr,
    description: 'Di dời cây và chậu đến vị trí mới'.tr,
    image: 'https://i.imgur.com/nJt20X8.png',
    priceStore: 10,
    priceOxygen: 10,
    currencyUnit: 'gemstone',
    type: 'item',
    effect: 'N.A',
    levelUnlock: 1,
  ),
    ItemData(
    id: 'item3',
    name: 'Oxygen'.tr,
    description: 'chuyển 100 đá quý sang oxygen với tỷ lệ 1.75'.tr,
    image: 'https://i.imgur.com/6n7hREG.png',
    priceStore: 100,
    priceOxygen: 100,
    currencyUnit: 'gemstone',
    type: 'item',
    effect: 'N.A',
    levelUnlock: 1,
  ),
  
];
