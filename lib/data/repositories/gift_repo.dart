import 'dart:convert';

import 'package:terrarium_idle/data/repositories/repo.dart';
import 'package:get_storage/get_storage.dart';

class GiftRepo extends Repo {
  GetStorage box = GetStorage();

  // lấy thông tin phiên bản mới
  Future<Map<String, dynamic>> getGift() async {
    var res = await dioRepo.get('/gift/gift.json');
    //log('gift: $');
    Map<String, dynamic> result = jsonDecode(res.toString());
    //print('data new json ${result}');
    return result;
  }
}
