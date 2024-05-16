
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
