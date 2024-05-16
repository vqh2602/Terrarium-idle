import 'dart:async';

import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/mixin/user_mixin.dart';
import 'package:terrarium_idle/modules/login/login_screen.dart';

class UserController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, FireStoreMixin {
  // GetStorage box = GetStorage();
  UserData? user;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserData();
    changeUI();
  }

  getUserData() async {
    user = await getDataUser(firebaseAuth.currentUser?.uid ?? '');
    if (user == null) {
      await firebaseAuth.signOut();
      Get.offAndToNamed(LoginScreen.routeName);
    }
    updateUI();
  }

  logOut() async {
    await firebaseAuth.signOut();
    // Get.offAndToNamed(LoginScreen.routeName);
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
