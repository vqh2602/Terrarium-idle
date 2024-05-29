import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:terrarium_idle/data/models/event.dart';
import 'package:terrarium_idle/data/repositories/repo.dart';

class EventRepo extends Repo {
  GetStorage box = GetStorage();
  Future<List<Event>> getEvent() async {
    var res = await dioRepo.get('/event/event_terrarium.json');
    //log('Event: $');
    Map<String, dynamic> result = jsonDecode(res.toString());
    //print('data new json ${result}');
    return List<Event>.from(result['data'].map((x) => Event.fromJson(x)));
  }
}
