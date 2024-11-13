import 'package:get/get.dart';
import 'package:terrarium_idle/modules/gift/gift_controller.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';

class GiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<GiftController>(() => GiftController());
  }
}
