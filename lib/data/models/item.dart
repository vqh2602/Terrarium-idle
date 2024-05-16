// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  });
  

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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
    };
  }

  factory ItemData.fromMap(Map<String, dynamic> map) {
    return ItemData(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      priceStore: map['priceStore'] != null ? map['priceStore'] as int : null,
      priceOxygen: map['priceOxygen'] != null ? map['priceOxygen'] as int : null,
      currencyUnit: map['currencyUnit'] != null ? map['currencyUnit'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      effect: map['effect'] != null ? map['effect'] as String : null,
      levelUnlock: map['levelUnlock'] != null ? map['levelUnlock'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemData.fromJson(String source) => ItemData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemData(id: $id, name: $name, description: $description, image: $image, priceStore: $priceStore, priceOxygen: $priceOxygen, currencyUnit: $currencyUnit, type: $type, effect: $effect, levelUnlock: $levelUnlock)';
  }

  @override
  bool operator ==(covariant ItemData other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.image == image &&
      other.priceStore == priceStore &&
      other.priceOxygen == priceOxygen &&
      other.currencyUnit == currencyUnit &&
      other.type == type &&
      other.effect == effect &&
      other.levelUnlock == levelUnlock;
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
      levelUnlock.hashCode;
  }
}
