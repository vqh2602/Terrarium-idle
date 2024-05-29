import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:terrarium_idle/data/models/event.dart';
import 'package:terrarium_idle/data/repositories/event_repo.dart';

class EventController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  EventRepo eventRepo = EventRepo();
  List<Event> listEvent = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    listEvent = await eventRepo.getEvent();
    changeUI();
  }

  Future<void> checkLogin() async {
  
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
