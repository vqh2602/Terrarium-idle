// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
// thuộc tính đặc biệt
enum ItemTypeAttribute {
  /// treo, áp dụng cho cây và chậu có phải dạng treo lên hay k
  hanging,
  none
}

class ItemData {
  String? id;
  String? name;
  String? description;
  String? image;
  int? priceStore;
  int? priceOxygen;
  String? currencyUnit;
  String? type;
  String? effect;
  num? levelUnlock;
  ItemTypeAttribute? itemTypeAttribute;
  ItemData({
    this.id,
    this.name,
    this.description,
    this.image,
    this.priceStore,
    this.priceOxygen,
    this.currencyUnit,
    this.type,
    this.effect,
    this.levelUnlock,
    this.itemTypeAttribute,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'priceStore': priceStore,
      'priceOxygen': priceOxygen,
      'currencyUnit': currencyUnit,
      'type': type,
      'effect': effect,
      'levelUnlock': levelUnlock,
      'itemTypeAttribute': itemTypeAttribute?.toString(),
    };
  }

  factory ItemData.fromMap(Map<String, dynamic> map) {
    return ItemData(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      priceStore: map['priceStore']?.toInt(),
      priceOxygen: map['priceOxygen']?.toInt(),
      currencyUnit: map['currencyUnit'],
      type: map['type'],
      effect: map['effect'],
      levelUnlock: map['levelUnlock'],
      itemTypeAttribute: map['itemTypeAttribute'] != null
          ? ItemTypeAttribute.values.byName(map['itemTypeAttribute'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemData.fromJson(String source) =>
      ItemData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemData(id: $id, name: $name, description: $description, image: $image, priceStore: $priceStore, priceOxygen: $priceOxygen, currencyUnit: $currencyUnit, type: $type, effect: $effect, levelUnlock: $levelUnlock, itemTypeAttribute: $itemTypeAttribute)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemData &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.priceStore == priceStore &&
        other.priceOxygen == priceOxygen &&
        other.currencyUnit == currencyUnit &&
        other.type == type &&
        other.effect == effect &&
        other.levelUnlock == levelUnlock &&
        other.itemTypeAttribute == itemTypeAttribute;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        priceStore.hashCode ^
        priceOxygen.hashCode ^
        currencyUnit.hashCode ^
        type.hashCode ^
        effect.hashCode ^
        levelUnlock.hashCode ^
        itemTypeAttribute.hashCode;
  }

  ItemData copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? priceStore,
    int? priceOxygen,
    String? currencyUnit,
    String? type,
    String? effect,
    num? levelUnlock,
    ItemTypeAttribute? itemTypeAttribute,
  }) {
    return ItemData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      priceStore: priceStore ?? this.priceStore,
      priceOxygen: priceOxygen ?? this.priceOxygen,
      currencyUnit: currencyUnit ?? this.currencyUnit,
      type: type ?? this.type,
      effect: effect ?? this.effect,
      levelUnlock: levelUnlock ?? this.levelUnlock,
      itemTypeAttribute: itemTypeAttribute ?? this.itemTypeAttribute,
    );
  }
}
