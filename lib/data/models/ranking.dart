import 'dart:convert';

import 'package:terrarium_idle/data/models/user.dart';

class Ranking {
  User user;
  num oxygenCollect;
  DateTime dateUpdate;
  bool isBan = false;
  Ranking({
    required this.user,
    required this.oxygenCollect,
    required this.dateUpdate,
    required this.isBan,
  });

  Ranking copyWith({
    User? user,
    num? oxygenCollect,
    DateTime? dateUpdate,
    bool? isBan,
  }) {
    return Ranking(
      user: user ?? this.user,
      oxygenCollect: oxygenCollect ?? this.oxygenCollect,
      dateUpdate: dateUpdate ?? this.dateUpdate,
      isBan: isBan ?? this.isBan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'oxygenCollect': oxygenCollect,
      'dateUpdate': dateUpdate.millisecondsSinceEpoch,
      'isBan': isBan,
    };
  }

  factory Ranking.fromMap(Map<String, dynamic> map) {
    return Ranking(
      user: User.fromMap(map['user']),
      oxygenCollect: map['oxygenCollect'] ?? 0,
      dateUpdate: DateTime.fromMillisecondsSinceEpoch(map['dateUpdate']),
      isBan: map['isBan'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ranking.fromJson(String source) => Ranking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ranking(user: $user, oxygenCollect: $oxygenCollect, dateUpdate: $dateUpdate, isBan: $isBan)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Ranking &&
      other.user == user &&
      other.oxygenCollect == oxygenCollect &&
      other.dateUpdate == dateUpdate &&
      other.isBan == isBan;
  }

  @override
  int get hashCode {
    return user.hashCode ^
      oxygenCollect.hashCode ^
      dateUpdate.hashCode ^
      isBan.hashCode;
  }
}
