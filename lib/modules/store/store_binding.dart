
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/store/store_controller.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreController>(() => StoreController());
      Get.lazyPut<UserController>(() => UserController());
  }
}
