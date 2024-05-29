
import 'package:terrarium_idle/modules/coop/garden_coop/garden_coop_controller.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';

class GardenCoopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GardenCoopController>(() => GardenCoopController());
    Get.lazyPut<UserController>(() => UserController());
  }
}
