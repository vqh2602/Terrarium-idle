import 'package:firebase_auth/firebase_auth.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/data/repositories/user_repo.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/modules/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, FireStoreMixin {
  UserRepo userRepo = UserRepo();
  late TextEditingController emailTE, passWTE;
  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
    changeUI();
  }

  initData() {
    emailTE = TextEditingController();
    passWTE = TextEditingController();
  }

  Future<void> login() async {
    UserCredential? user;
    user = await userRepo.loginWithGoogle();
    if (user != null) {
      UserData? userCustom = await getDataUser(user.user?.uid ?? 'null_login_controller');
      if (userCustom == null) {
        createDataUser(
            email: user.user?.email,
            name: user.user?.displayName,
            id: user.user?.uid);
      }
      Get.offAllNamed(SplashScreen.routeName);
    }

    changeUI();
  }

  Future<void> loginApple() async {
    UserCredential? user;
    user = await userRepo.loginWithApple();
    if (user != null) {
      UserData? userCustom = await getDataUser(user.user?.uid ?? 'null_login_controller');
      if (userCustom == null) {
        createDataUser(
            email: user.user?.email,
            name: user.user?.displayName,
            id: user.user?.uid);
      }
      Get.offAllNamed(SplashScreen.routeName);
    }

    changeUI();
  }

  Future<void> loginTiktok() async {
    // ignore: unused_local_variable
    UserCredential? user;
    // user = await userRepo.loginWithTiktok();
    // ignore: unused_local_variable
    // UserCustom? userCustom = await getDataUser(user?.id ?? '');
    // if (userCustom == null) {
    //   createDataUser(email: user?.email, name: user?.name, id: user?.id);
    // }

    // user != null ? Get.offAllNamed(SplashScreen.routeName) : null;
    changeUI();
  }

  Future<void> loginGithub() async {
    // UserCredential? user;
    // user = await userRepo.loginWithGithub();
    // UserCustom? userCustom = await getDataUser(user?.id ?? '');
    // if (userCustom == null) {
    //   createDataUser(email: user?.email, name: user?.name, id: user?.id);
    // }

    // user != null ? Get.offAllNamed(SplashScreen.routeName) : null;
    changeUI();
  }

  String? validateEmail(String? value) {
    bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '');
    return emailValid ? null : "Không đúng định dạng email";
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
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
