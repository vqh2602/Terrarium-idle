import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';

class CoopController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, FireStoreMixin {
  List<UserData>? userdatas = [];
  TextEditingController textSearchTE = TextEditingController();
  List<UserData>? userdataFilter = [];
  @override
  Future<void> onInit() async {
    super.onInit();
    userdatas = await getListDataUser();
    userdataFilter?.addAll(userdatas ?? []);
    changeUI();
  }

  Future<void> filterUser(String id) async {
    userdataFilter?.clear();
    if (id.isEmpty) {
      userdataFilter?.addAll(userdatas ?? []);
    } else {
      userdataFilter?.addAll(userdatas
              ?.where((element) =>
                  element.user?.userID
                      ?.toLowerCase()
                      .contains(id.toLowerCase()) ??
                  false)
              .toList() ??
          []);
    }
    update();
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
