// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_porter/sqflite_porter.dart';

import 'package:terrarium_idle/data/models/emotional_data.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';

class DBHelper {
  Database? _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String TABLE_EmotionalData = 'tblEmotionalData';

  static const String DB_NAME = 'database.db';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    //init db
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    //tạo database
    await db.execute(
        '''CREATE TABLE $TABLE_EmotionalData (	id TEXT NOT NULL PRIMARY KEY, dateAdd REAL, emoij TEXT, sleepStart REAL, sleepEnd REAL, label TEXT, note TEXT, album TEXT, todo TEXT )''');
  }

  // CAT
  Future<EmotionalData> addDataEmotionalData(
      EmotionalData emotionalData) async {
    // insert employee vào bảng đơn giản
    var dbClient = await db;
    await dbClient?.insert(TABLE_EmotionalData, emotionalData.toMap());
    return emotionalData;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query); //các bạn có thể sử dụng rawQuery nếu truy vẫn phức tạp để thay thế cho các phước thức có sẵn của lớp Database.
    });
    */
  }

  Future<List<EmotionalData>> getDataEmotionalDatas() async {
    //get list employees đơn giản
    var dbClient = await db;
    // List<Map<String, Object?>>? maps = await dbClient?.query(TABLE_EmotionalData, columns: [ID, NAME]);
    List<Map<String, Object?>>? maps =
        await dbClient?.rawQuery("SELECT * FROM $TABLE_EmotionalData");
    List<EmotionalData> lstEmotionalData = [];
    if (kDebugMode) {
      print('getall emotionalData: $maps');
    }
    if ((maps?.length ?? 0) > 0) {
      for (int i = 0; i < maps!.length; i++) {
        lstEmotionalData.add(EmotionalData.fromMap(maps[i]));
      }
    }
    return lstEmotionalData;
  }

// lọc theo ngày
  Future<List<EmotionalData>> getDataEmotionalDatasByFilter(
      {DateTime? date, bool ismonth = false, bool isYear = false}) async {
    //get list employees đơn giản
    var dbClient = await db;
    // List<Map<String, Object?>>? maps = await dbClient?.query(TABLE_EmotionalData, columns: [ID, NAME]);
    List<Map<String, Object?>>? maps;
    List<EmotionalData> lstEmotionalData = [];

    if (ismonth) {
      int startTimestamp = DateTime(
        date!.year,
        date.month,
        1,
        0,
        0,
        0,
        0,
      ).millisecondsSinceEpoch;
      int endTimestamp = DateTime(date.year, date.month, 31, 23, 59, 59, 999)
          .millisecondsSinceEpoch;

      String sql = '''
  SELECT *
  FROM $TABLE_EmotionalData
  WHERE dateAdd >= ${startTimestamp.toDouble()}
    AND dateAdd <= ${endTimestamp.toDouble()}
 ;
''';
      maps = await dbClient?.rawQuery(sql);
    } else if (isYear) {
      int startTimestamp =
          DateTime(date!.year, 1, 1, 0, 0, 0, 0, 0).millisecondsSinceEpoch;
      int endTimestamp =
          DateTime(date.year, 12, 31, 23, 59, 59, 999).millisecondsSinceEpoch;

      String sql = '''
  SELECT *
  FROM $TABLE_EmotionalData
  WHERE dateAdd >= ${startTimestamp.toDouble()}
    AND dateAdd <= ${endTimestamp.toDouble()}
 ;
''';
      maps = await dbClient?.rawQuery(sql);
    } else {
      maps = await dbClient
          ?.query(TABLE_EmotionalData, where: 'dateAdd = ?', whereArgs: [
        date != null ? DateUtils.dateOnly(date).millisecondsSinceEpoch : null,
      ]);
    }

    // print('getall emotionalData: ${maps.toString()}');
    if ((maps?.length ?? 0) > 0) {
      for (int i = 0; i < maps!.length; i++) {
        lstEmotionalData.add(EmotionalData.fromMap(maps[i]));
      }
    }
    return lstEmotionalData;
  }

  Future<int?> deleteDataEmotionalData(dynamic id) async {
    // xóa employee
    var dbClient = await db;
    return await dbClient?.delete(TABLE_EmotionalData,
        where: 'ID = ?',
        whereArgs: [id]); //where - xóa tại ID nào, whereArgs - argument là gì?
  }

  Future<int?> updateDataEmotionalData(EmotionalData emotionalData) async {
    var dbClient = await db;
    return await dbClient?.update(TABLE_EmotionalData, emotionalData.toMap(),
        where: '$ID = ?', whereArgs: [emotionalData.id]);
  }

  Future close() async {
    //close khi không sử dụng
    var dbClient = await db;
    dbClient?.close();
  }

  Future<List<String>?> exportDB() async {
    Database? dbt = await db;
    if (dbt != null) {
      return await dbExportSql(dbt);
    } else {
      buildToast(
          message: 'Lỗi khi xuất dữ liệu'.tr, status: TypeToast.toastError);
      return null;
    }
  }

  Future importDB(List<String> export) async {
    Database? dbt = await db;
    dbt?.delete(TABLE_EmotionalData);
    // Import during onCreate
    for (int i = 1; i < export.length - 1; i++) {
      if (dbt != null) {
        await dbt.rawInsert(export[i]);
      }
    }

    // if (dbt == null) {
    //   return await dbImportSql(
    //     dbt!,
    //     export,
    //   );
    // }
  }

  Future deleteDB() async {
    Database? dbt = await db;
    dbt?.delete(TABLE_EmotionalData);
  }
}
