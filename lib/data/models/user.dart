// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserCustom {
  String? id;
  String? displayName;
  String? email;
  num? coins;
  DateTime? expirationDate;
  List<String>? themes;
  UserCustom({
    this.id,
    this.displayName,
    this.email,
    this.coins,
    this.expirationDate,
    this.themes,
  });

  UserCustom copyWith({
    String? id,
    String? displayName,
    String? email,
    num? coins,
    DateTime? expirationDate,
    List<String>? themes,
  }) {
    return UserCustom(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      coins: coins ?? this.coins,
      expirationDate: expirationDate ?? this.expirationDate,
      themes: themes ?? this.themes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'email': email,
      'coins': coins,
      'expirationDate': expirationDate?.millisecondsSinceEpoch,
      'themes': themes,
    };
  }

  factory UserCustom.fromMap(Map<String, dynamic> map) {
    return UserCustom(
      id: map['id'] != null ? map['id'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      coins: map['coins'] != null ? map['coins'] as num : null,
      expirationDate: map['expirationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int)
          : null,
      themes: map['themes'] != null
          ? List<String>.from((map['themes'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCustom.fromJson(String source) =>
      UserCustom.fromMap(json.decode(source) as Map<String, dynamic>);
}
