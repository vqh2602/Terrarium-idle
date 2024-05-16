import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:terrarium_idle/modules/garden/garden_screen.dart';
import 'package:terrarium_idle/modules/login/login_screen.dart';
// import 'package:terrarium_idle/data/storage/storage.dart';
// import 'package:terrarium_idle/modules/auth/login/login_screen.dart';
// import 'package:dart_appwrite/dart_appwrite.dart' as server_appwrite;

class SplashController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GetStorage box = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    // testappWire();
    // await testappWireServer();
    changeUI();
  }

  Future<void> checkLogin() async {
    // var dataUser = await box.read(Storages.dataUser);
    // kiểm tra dữ liệu user và thời gian đăng nhập
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAndToNamed(GardenScreen.routeName);
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAndToNamed(LoginScreen.routeName);
      });
      // }
    }
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
