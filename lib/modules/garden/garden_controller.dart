import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
// import 'package:terrarium_idle/data/storage/storage.dart';
// import 'package:terrarium_idle/modules/auth/login/login_screen.dart';
// import 'package:dart_appwrite/dart_appwrite.dart' as server_appwrite;

class GardenController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, FireStoreMixin {
  AudioPlayer audioPlayerBackground = AudioPlayer();
  UserController userController = Get.find();
  bool isEdit = false;
  UserData? userData;

  @override
  Future<void> onInit() async {
    super.onInit();
    userData = await getDataUser(
        firebaseAuth.currentUser?.uid ?? 'null_graden_controller');
    initAudio();
    changeUI();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    await audioPlayerBackground.stop();
    audioPlayerBackground.dispose();
  }

  initAudio() async {
    // Create a player
    await audioPlayerBackground.setAsset(
        'assets/audios/peacefulgarden.mp3'); // Schemes: (https: | file: | asset: )
    await audioPlayerBackground.setLoopMode(LoopMode.all);
    await audioPlayerBackground.setVolume(0.5);
    await audioPlayerBackground.play(); // Play while waiting for completion
    // await player.pause(); // Pause but remain ready to play
    // await  audioPlayerBackground.stop();
  }

  Future<void> checkLogin() async {
    // var dataUser = await box.read(Storages.dataUser);
    // kiểm tra dữ liệu user và thời gian đăng nhập

    // if (dataUser != null) {
    //   Future.delayed(const Duration(seconds: 4), () {
    //     Get.offAndToNamed(HomeScreen.routeName);
    //   });
    // } else {
    //   Future.delayed(const Duration(seconds: 4), () {
    //     Get.offAndToNamed(LoginScreen.routeName);
    //   });
    // }
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
