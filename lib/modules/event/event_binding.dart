import 'package:terrarium_idle/modules/event/event_controller.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<EventController>(() => EventController());
  }
}
