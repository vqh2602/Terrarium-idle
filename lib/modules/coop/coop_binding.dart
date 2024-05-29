import 'package:terrarium_idle/modules/coop/coop_controller.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';

class CoopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoopController>(() => CoopController());
    Get.lazyPut<GardenController>(() => GardenController());
  }
}
