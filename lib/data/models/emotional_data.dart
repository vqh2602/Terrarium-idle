import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmotionalData {
  String id;
  DateTime dateAdd;
  String? emoij;
  DateTime? sleepStart;
  DateTime? sleepEnd;
  List<String> label;
  String note;
  List<String> album;
  List<Todo>? todo;
  EmotionalData({
    required this.id,
    required this.dateAdd,
    required this.emoij,
    required this.sleepStart,
    required this.sleepEnd,
    required this.label,
    required this.note,
    required this.album,
    required this.todo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateAdd': DateUtils.dateOnly(dateAdd).millisecondsSinceEpoch,
      'emoij': emoij,
      'sleepStart': sleepStart?.millisecondsSinceEpoch,
      'sleepEnd': sleepEnd?.millisecondsSinceEpoch,
      'label': label.toSet().toList().toString(),
      'note': note,
      'album': album.toSet().toList().toString(),
      'todo': todo
          ?.map((x) => jsonEncode(x.toMap()))
          .toString()
          .replaceAll('({', '[{')
          .replaceAll('})', '}]')
          .replaceAll(', ', ',')
          .replaceAll('()', '[]'),
    };
  }

  factory EmotionalData.fromMap(Map<String, dynamic> map) {
    return EmotionalData(
        id: map['id'] as String,
        dateAdd: DateTime.fromMillisecondsSinceEpoch(map['dateAdd']?.toInt()),
        emoij: map['emoij'] as String?,
        sleepStart: map['sleepStart'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['sleepStart']?.toInt())
            : null,
        sleepEnd: map['sleepEnd'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['sleepEnd']?.toInt())
            : null,
        label: List<String>.from(
          map['label']
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll(' ', '')
              .split(','),
        ),
        note: map['note'] as String,
        album: List<String>.from(
          map['album']
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll(' ', '')
              .split(','),
        ),
        todo: map['todo'] != null
            ? List<Todo>.from(jsonDecode(map['todo'].toString())
                .map((x) => Todo.fromMap(x as Map<String, dynamic>)))
            : null);
  }

  String toJson() => json.encode(toMap());

  factory EmotionalData.fromJson(String source) =>
      EmotionalData.fromMap(json.decode(source) as Map<String, dynamic>);

  EmotionalData copyWith({
    String? id,
    DateTime? dateAdd,
    String? emoij,
    DateTime? sleepStart,
    DateTime? sleepEnd,
    List<String>? label,
    String? note,
    List<String>? album,
    List<Todo>? todo,
  }) {
    return EmotionalData(
      id: id ?? this.id,
      dateAdd: dateAdd ?? this.dateAdd,
      emoij: emoij ?? this.emoij,
      sleepStart: sleepStart ?? this.sleepStart,
      sleepEnd: sleepEnd ?? this.sleepEnd,
      label: label ?? this.label,
      note: note ?? this.note,
      album: album ?? this.album,
      todo: todo ?? this.todo,
    );
  }
}

class Todo {
  String? name;
  String? icon;
  bool? isDone;
  Todo({
    this.name,
    this.icon,
    this.isDone,
  });

  @override
  String toString() => 'Todo(name: $name, icon: $icon, isDone: $isDone)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icon': icon,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      name: map['name'] != null ? map['name'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  Todo copyWith({
    String? name,
    String? icon,
    bool? isDone,
  }) {
    return Todo(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isDone: isDone ?? this.isDone,
    );
  }
}
