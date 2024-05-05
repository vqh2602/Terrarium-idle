// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class MyTheme {
  num? coins;
  String? code;
  String? name;
  String? image;
  String? description;
  List<String>? category;

  Color? iconColor;
  Color? textcolor;
  double? blur;
  Color? primaryColor;
  bool? isDarkModel;

// home
  String? e1;
  String? e2;
  String? e3;
  String? e4;
  String? e5;
  String? i1;
  String? eHome;
  String? e6;
  String? backgroundHome;
  Color? textHeaderCalendar;
// edit
  String? backgroundEdit;
  Color? blockBackgroundEdit;
  // detail home
  String? backgroundDetail;
  Color? blockBackgroundDetail;
  MyTheme({
    this.coins,
    this.code,
    this.name,
    this.image,
    this.description,
    this.category,
    this.iconColor,
    this.textcolor,
    this.blur,
    this.primaryColor,
    this.isDarkModel,
    this.e1,
    this.e2,
    this.e3,
    this.e4,
    this.e5,
    this.i1,
    this.eHome,
    this.e6,
    this.backgroundHome,
    this.textHeaderCalendar,
    this.backgroundEdit,
    this.blockBackgroundEdit,
    this.backgroundDetail,
    this.blockBackgroundDetail,
  });

  MyTheme copyWith({
    num? coins,
    String? code,
    String? name,
    String? image,
    String? description,
    List<String>? category,
    Color? iconColor,
    Color? textcolor,
    double? blur,
    Color? primaryColor,
    bool? isDarkModel,
    String? e1,
    String? e2,
    String? e3,
    String? e4,
    String? e5,
    String? i1,
    String? eHome,
    String? e6,
    String? backgroundHome,
    Color? textHeaderCalendar,
    String? backgroundEdit,
    Color? blockBackgroundEdit,
    String? backgroundDetail,
    Color? blockBackgroundDetail,
  }) {
    return MyTheme(
      coins: coins ?? this.coins,
      code: code ?? this.code,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      iconColor: iconColor ?? this.iconColor,
      textcolor: textcolor ?? this.textcolor,
      blur: blur ?? this.blur,
      primaryColor: primaryColor ?? this.primaryColor,
      isDarkModel: isDarkModel ?? this.isDarkModel,
      e1: e1 ?? this.e1,
      e2: e2 ?? this.e2,
      e3: e3 ?? this.e3,
      e4: e4 ?? this.e4,
      e5: e5 ?? this.e5,
      i1: i1 ?? this.i1,
      eHome: eHome ?? this.eHome,
      e6: e6 ?? this.e6,
      backgroundHome: backgroundHome ?? this.backgroundHome,
      textHeaderCalendar: textHeaderCalendar ?? this.textHeaderCalendar,
      backgroundEdit: backgroundEdit ?? this.backgroundEdit,
      blockBackgroundEdit: blockBackgroundEdit ?? this.blockBackgroundEdit,
      backgroundDetail: backgroundDetail ?? this.backgroundDetail,
      blockBackgroundDetail:
          blockBackgroundDetail ?? this.blockBackgroundDetail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coins': coins,
      'code': code,
      'name': name,
      'image': image,
      'description': description,
      'category': category,
      'iconColor': iconColor?.value,
      'textcolor': textcolor?.value,
      'blur': blur,
      'primaryColor': primaryColor?.value,
      'isDarkModel': isDarkModel,
      'e1': e1,
      'e2': e2,
      'e3': e3,
      'e4': e4,
      'e5': e5,
      'i1': i1,
      'eHome': eHome,
      'e6': e6,
      'backgroundHome': backgroundHome,
      'textHeaderCalendar': textHeaderCalendar?.value,
      'backgroundEdit': backgroundEdit,
      'blockBackgroundEdit': blockBackgroundEdit?.value,
      'backgroundDetail': backgroundDetail,
      'blockBackgroundDetail': blockBackgroundDetail?.value,
    };
  }

  factory MyTheme.fromMap(Map<String, dynamic> map) {
    return MyTheme(
      coins: map['coins'] != null ? map['coins'] as num : null,
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null
          ? List<String>.from((map['category'])) 
          : null,
      iconColor:
          map['iconColor'] != null ? Color(map['iconColor'] as int) : null,
      textcolor:
          map['textcolor'] != null ? Color(map['textcolor'] as int) : null,
      blur: map['blur'] != null ? map['blur'] as double : null,
      primaryColor: map['primaryColor'] != null
          ? Color(map['primaryColor'] as int)
          : null,
      isDarkModel:
          map['isDarkModel'] != null ? map['isDarkModel'] as bool : null,
      e1: map['e1'] != null ? map['e1'] as String : null,
      e2: map['e2'] != null ? map['e2'] as String : null,
      e3: map['e3'] != null ? map['e3'] as String : null,
      e4: map['e4'] != null ? map['e4'] as String : null,
      e5: map['e5'] != null ? map['e5'] as String : null,
      i1: map['i1'] != null ? map['i1'] as String : null,
      eHome: map['eHome'] != null ? map['eHome'] as String : null,
      e6: map['e6'] != null ? map['e6'] as String : null,
      backgroundHome: map['backgroundHome'] != null
          ? map['backgroundHome'] as String
          : null,
      textHeaderCalendar: map['textHeaderCalendar'] != null
          ? Color(map['textHeaderCalendar'] as int)
          : null,
      backgroundEdit: map['backgroundEdit'] != null
          ? map['backgroundEdit'] as String
          : null,
      blockBackgroundEdit: map['blockBackgroundEdit'] != null
          ? Color(map['blockBackgroundEdit'] as int)
          : null,
      backgroundDetail: map['backgroundDetail'] != null
          ? map['backgroundDetail'] as String
          : null,
      blockBackgroundDetail: map['blockBackgroundDetail'] != null
          ? Color(map['blockBackgroundDetail'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyTheme.fromJson(String source) =>
      MyTheme.fromMap(json.decode(source) as Map<String, dynamic>);
}
