import 'package:terrarium_idle/c_lang/en_us.dart';
import 'package:terrarium_idle/c_lang/jp.dart';
import 'package:terrarium_idle/c_lang/ko.dart';
import 'package:terrarium_idle/c_lang/ru.dart';

import 'package:terrarium_idle/c_lang/vi_vn.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/c_lang/zh.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'vi': vi,
        'zh': zh,
        // nhật
        'ja': ja,
        'ko': ko,
        'ru': ru,
      };
}
