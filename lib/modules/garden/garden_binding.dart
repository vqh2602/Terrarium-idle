import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:get/get.dart';

class GardenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GardenController>(() => GardenController());
  }
}
