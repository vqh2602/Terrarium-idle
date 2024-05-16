
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
