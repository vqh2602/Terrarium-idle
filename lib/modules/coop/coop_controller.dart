import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/ranking.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/service/throttle.dart';

class CoopController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, FireStoreMixin {
  List<UserData>? userdatas = [];
  TextEditingController textSearchTE = TextEditingController();
  List<UserData>? userdataFilter = [];
  List<UserData>? userdataFilterLike = [];
  List<UserData>? userdataFilterLevel = [];
  List<Ranking>? listRankOxygen = [];
  final Throttle throttle = Throttle(const Duration(milliseconds: 1000));
  @override
  Future<void> onInit() async {
    super.onInit();
    userdatas = await getListDataUser();
    getDataUserAdmin(null);
    userdataFilter?.addAll(userdatas ?? []);
    var listLike = await getTop10UsersWithMost('user.userTotalLike');
    var listLevel = await getTop10UsersWithMost('user.userLevel');
    var listOxygen = await getRanking();
    userdataFilterLike?.addAll(listLike ?? []);
    userdataFilterLevel?.addAll(listLevel ?? []);
    listRankOxygen?.addAll(listOxygen);
    changeUI();
  }

  @override
  onClose() {
    throttle.cancel();
  }

  Future getDataUserAdmin(String? id) async {
    var user = await getDataUser(id ?? 'pb03Q3R93naRsjiAuyTGz0BPHI92');
    if (user != null) {
      userdataFilter?.insert(0, user);
    }
    update();
  }

  Future<void> filterUser(String id) async {
    userdataFilter?.clear();
    if (id.isEmpty) {
      userdataFilter?.addAll(userdatas ?? []);
    } else {
      throttle.run(() async {
        var user = await getDataUser(id);
        if (user != null) {
          userdataFilter?.add(user);
        }
        update();
      });
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
