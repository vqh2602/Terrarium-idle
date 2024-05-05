import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:terrarium_idle/data/repositories/repo.dart';

class ThemeRepo extends Repo {
  GetStorage box = GetStorage();

  Future<Map<String, dynamic>> getThemes() async {
    var res = await dioRepo.get('/theme/theme.json');
    //log('Event: $');
    Map<String, dynamic> result = jsonDecode(res.toString());
    //print('data new json ${result}');
    return result;
  }
}
