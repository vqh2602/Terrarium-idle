import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:terrarium_idle/data/repositories/repo.dart';

class EventRepo extends Repo {
  GetStorage box = GetStorage();
  Future<Map<String, dynamic>> getEvent() async {
    var res = await dioRepo.get('/event/event.json');
    //log('Event: $');
    Map<String, dynamic> result = jsonDecode(res.toString());
    //print('data new json ${result}');
    return result;
  }
}
