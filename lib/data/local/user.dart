// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserData {
  User? user;
  Money? money;
  Item? item;
  Cart? cart;
  List<Plants>? plants;
  UserData({
    this.user,
    this.money,
    this.item,
    this.cart,
    this.plants,
  });

  UserData copyWith({
    User? user,
    Money? money,
    Item? item,
    Cart? cart,
    List<Plants>? plants,
  }) {
    return UserData(
      user: user ?? this.user,
      money: money ?? this.money,
      item: item ?? this.item,
      cart: cart ?? this.cart,
      plants: plants ?? this.plants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'money': money?.toMap(),
      'item': item?.toMap(),
      'cart': cart?.toMap(),
      'plants': plants?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      money: map['money'] != null
          ? Money.fromMap(map['money'] as Map<String, dynamic>)
          : null,
      item: map['item'] != null
          ? Item.fromMap(map['item'] as Map<String, dynamic>)
          : null,
      cart: map['cart'] != null
          ? Cart.fromMap(map['cart'] as Map<String, dynamic>)
          : null,
      plants: map['plants'] != null
          ? List<Plants>.from(
              (map['plants']).map<Plants?>(
                (x) => Plants.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(user: $user, money: $money, item: $item, cart: $cart, plants: $plants)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.money == money &&
        other.item == item &&
        other.cart == cart &&
        listEquals(other.plants, plants);
  }

  @override
  int get hashCode {
    return user.hashCode ^
        money.hashCode ^
        item.hashCode ^
        cart.hashCode ^
        plants.hashCode;
  }
}

class User {
  String? userID;
  String? userEmail;
  String? userName;
  String? userAvatar;
  int? userLevelEXP;
  int? userLevel;
  int? userTotalLike;
  int? userFloor;
  String? identifier;
  DateTime? latestPurchaseDate;
  User({
    this.userID,
    this.userEmail,
    this.userName,
    this.userAvatar,
    this.userLevelEXP,
    this.userLevel,
    this.userTotalLike,
    this.userFloor,
    this.identifier,
    this.latestPurchaseDate,
  });

  User copyWith({
    String? userID,
    String? userEmail,
    String? userName,
    String? userAvatar,
    int? userLevelEXP,
    int? userLevel,
    int? userTotalLike,
    int? userFloor,
    String? identifier,
    DateTime? latestPurchaseDate,
  }) {
    return User(
      userID: userID ?? this.userID,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      userLevelEXP: userLevelEXP ?? this.userLevelEXP,
      userLevel: userLevel ?? this.userLevel,
      userTotalLike: userTotalLike ?? this.userTotalLike,
      userFloor: userFloor ?? this.userFloor,
      identifier: identifier ?? this.identifier,
      latestPurchaseDate: latestPurchaseDate ?? this.latestPurchaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'userEmail': userEmail,
      'userName': userName,
      'userAvatar': userAvatar,
      'userLevelEXP': userLevelEXP,
      'userLevel': userLevel,
      'userTotalLike': userTotalLike,
      'userFloor': userFloor,
      'identifier': identifier,
      'latestPurchaseDate': latestPurchaseDate?.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'] != null ? map['userID'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userAvatar:
          map['userAvatar'] != null ? map['userAvatar'] as String : null,
      userLevelEXP:
          map['userLevelEXP'] != null ? map['userLevelEXP'] as int : null,
      userLevel: map['userLevel'] != null ? map['userLevel'] as int : null,
      userTotalLike:
          map['userTotalLike'] != null ? map['userTotalLike'] as int : null,
      userFloor: map['userFloor'] != null ? map['userFloor'] as int : null,
      identifier:
          map['identifier'] != null ? map['identifier'] as String : null,
      latestPurchaseDate: map['latestPurchaseDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['latestPurchaseDate'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userID: $userID, userEmail: $userEmail, userName: $userName, userAvatar: $userAvatar, userLevelEXP: $userLevelEXP, userLevel: $userLevel, userTotalLike: $userTotalLike, userFloor: $userFloor, identifier: $identifier, latestPurchaseDate: $latestPurchaseDate)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.userEmail == userEmail &&
        other.userName == userName &&
        other.userAvatar == userAvatar &&
        other.userLevelEXP == userLevelEXP &&
        other.userLevel == userLevel &&
        other.userTotalLike == userTotalLike &&
        other.userFloor == userFloor &&
        other.identifier == identifier &&
        other.latestPurchaseDate == latestPurchaseDate;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        userEmail.hashCode ^
        userName.hashCode ^
        userAvatar.hashCode ^
        userLevelEXP.hashCode ^
        userLevel.hashCode ^
        userTotalLike.hashCode ^
        userFloor.hashCode ^
        identifier.hashCode ^
        latestPurchaseDate.hashCode;
  }
}

class Money {
  int? oxygen;
  int? gemstone;
  int? ticket;
  Money({
    this.oxygen,
    this.gemstone,
    this.ticket,
  });

  Money copyWith({
    int? oxygen,
    int? gemstone,
    int? ticket,
  }) {
    return Money(
      oxygen: oxygen ?? this.oxygen,
      gemstone: gemstone ?? this.gemstone,
      ticket: ticket ?? this.ticket,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oxygen': oxygen,
      'gemstone': gemstone,
      'ticket': ticket,
    };
  }

  factory Money.fromMap(Map<String, dynamic> map) {
    return Money(
      oxygen: map['oxygen'] != null ? map['oxygen'] as int : null,
      gemstone: map['gemstone'] != null ? map['gemstone'] as int : null,
      ticket: map['ticket'] != null ? map['ticket'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Money.fromJson(String source) =>
      Money.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Money(oxygen: $oxygen, gemstone: $gemstone, ticket: $ticket)';

  @override
  bool operator ==(covariant Money other) {
    if (identical(this, other)) return true;

    return other.oxygen == oxygen &&
        other.gemstone == gemstone &&
        other.ticket == ticket;
  }

  @override
  int get hashCode => oxygen.hashCode ^ gemstone.hashCode ^ ticket.hashCode;
}

class Item {
  int? fertilizer;
  int? shovel;
  Item({
    this.fertilizer,
    this.shovel,
  });

  Item copyWith({
    int? fertilizer,
    int? shovel,
  }) {
    return Item(
      fertilizer: fertilizer ?? this.fertilizer,
      shovel: shovel ?? this.shovel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fertilizer': fertilizer,
      'shovel': shovel,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      fertilizer: map['fertilizer'] != null ? map['fertilizer'] as int : null,
      shovel: map['shovel'] != null ? map['shovel'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Item(fertilizer: $fertilizer, shovel: $shovel)';

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.fertilizer == fertilizer && other.shovel == shovel;
  }

  @override
  int get hashCode => fertilizer.hashCode ^ shovel.hashCode;
}

class Cart {
  List<String>? cartPlants;
  List<String>? cartPots;
  Cart({
    this.cartPlants,
    this.cartPots,
  });

  Cart copyWith({
    List<String>? cartPlants,
    List<String>? cartPots,
  }) {
    return Cart(
      cartPlants: cartPlants ?? this.cartPlants,
      cartPots: cartPots ?? this.cartPots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartPlants': cartPlants,
      'cartPots': cartPots,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartPlants: map['cartPlants'] != null
          ? List<String>.from((map['cartPlants'] as List<String>))
          : null,
      cartPots: map['cartPots'] != null
          ? List<String>.from((map['cartPots'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Cart(cartPlants: $cartPlants, cartPots: $cartPots)';

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return listEquals(other.cartPlants, cartPlants) &&
        listEquals(other.cartPots, cartPots);
  }

  @override
  int get hashCode => cartPlants.hashCode ^ cartPots.hashCode;
}

class Plants {
  String? idPlant;
  String? idPot;
  String? position;
  DateTime? harvestTime;
  int? platLevelExp;
  int? plantLevel;
  Plants({
    this.idPlant,
    this.idPot,
    this.position,
    this.harvestTime,
    this.platLevelExp,
    this.plantLevel,
  });

  Plants copyWith({
    String? idPlant,
    String? idPot,
    String? position,
    DateTime? harvestTime,
    int? platLevelExp,
    int? plantLevel,
  }) {
    return Plants(
      idPlant: idPlant ?? this.idPlant,
      idPot: idPot ?? this.idPot,
      position: position ?? this.position,
      harvestTime: harvestTime ?? this.harvestTime,
      platLevelExp: platLevelExp ?? this.platLevelExp,
      plantLevel: plantLevel ?? this.plantLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPlant': idPlant,
      'idPot': idPot,
      'position': position,
      'harvestTime': harvestTime?.millisecondsSinceEpoch,
      'platLevelExp': platLevelExp,
      'plantLevel': plantLevel,
    };
  }

  factory Plants.fromMap(Map<String, dynamic> map) {
    return Plants(
      idPlant: map['idPlant'] != null ? map['idPlant'] as String : null,
      idPot: map['idPot'] != null ? map['idPot'] as String : null,
      position: map['position'] != null ? map['position'] as String : null,
      harvestTime: map['harvestTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['harvestTime'] as int)
          : null,
      platLevelExp:
          map['platLevelExp'] != null ? map['platLevelExp'] as int : null,
      plantLevel: map['plantLevel'] != null ? map['plantLevel'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plants.fromJson(String source) =>
      Plants.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plants(idPlant: $idPlant, idPot: $idPot, position: $position, harvestTime: $harvestTime, platLevelExp: $platLevelExp, plantLevel: $plantLevel)';
  }

  @override
  bool operator ==(covariant Plants other) {
    if (identical(this, other)) return true;

    return other.idPlant == idPlant &&
        other.idPot == idPot &&
        other.position == position &&
        other.harvestTime == harvestTime &&
        other.platLevelExp == platLevelExp &&
        other.plantLevel == plantLevel;
  }

  @override
  int get hashCode {
    return idPlant.hashCode ^
        idPot.hashCode ^
        position.hashCode ^
        harvestTime.hashCode ^
        platLevelExp.hashCode ^
        plantLevel.hashCode;
  }
}
