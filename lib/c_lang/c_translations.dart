import 'package:terrarium_idle/c_lang/en_us.dart';

import 'package:terrarium_idle/c_lang/vi_vn.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/c_lang/zh.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'en': en, 'vi': vi, 'zh': zh,};
}
