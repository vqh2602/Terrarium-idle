import 'package:terrarium_idle/data/models/item.dart';

List<ItemData> listItemsData = [
  ItemData(
    id: 'item1',
    name: 'Phân bón',
    description: 'Kích thích tăng trưởng cho cây',
    image: 'https://i.imgur.com/dXKrKlk.png',
    priceStore: 20,
    priceOxygen: 20,
    currencyUnit: 'gemstone',
    type: 'item',
    effect: 'Đá lấp lánh',
    levelUnlock: 1,
  ),
  ItemData(
    id: 'item2',
    name: 'Xẻng',
    description: 'Di dời cây và chậu đến vị trí mới',
    image: 'https://i.imgur.com/nJt20X8.png',
    priceStore: 10,
    priceOxygen: 10,
    currencyUnit: 'gemstone',
    type: 'item',
    effect: 'N.A',
    levelUnlock: 1,
  ),
  
];
