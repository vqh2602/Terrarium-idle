import 'package:terrarium_idle/c_lang/en_us.dart';
import 'package:terrarium_idle/c_lang/vi_vn.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'vi_VN': vi};
}
