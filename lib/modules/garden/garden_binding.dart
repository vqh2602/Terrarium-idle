import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';

class GardenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GardenController>(() => GardenController());
        Get.lazyPut<UserController>(() => UserController());
  }
}
