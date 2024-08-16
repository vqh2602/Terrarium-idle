import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/local/list_effect.dart';
import 'package:terrarium_idle/data/local/list_plants.dart';
import 'package:terrarium_idle/data/local/list_pots.dart';
import 'package:terrarium_idle/data/models/item.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
// import 'package:terrarium_idle/data/storage/storage.dart';
// import 'package:terrarium_idle/modules/auth/login/login_screen.dart';
// import 'package:dart_appwrite/dart_appwrite.dart' as server_appwrite;

class GardenCoopController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, FireStoreMixin {
  AudioPlayer audioPlayerBackground = AudioPlayer();
  UserController userController = Get.find();
  bool isEdit = false;
  UserData? userData = Get.arguments;
  bool isRain = false;
  List<SelectOptionItem> listSelectOptionEffect = [];
  List<SelectOptionItem> listSelectOptionMusic = [];
  SelectOptionItem? selectEffect;
  SelectOptionItem? selectMusic;

  bool isWater = false;
  bool isLike = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    isRain = ShareFuntion.gacha(winRate: 10);

    initDataEffect();
    initDataMusic();
    initAudio(asset: selectMusic?.value ?? Assets.audios.peacefulgarden);
    changeUI();
  }

  //init data effect
  initDataEffect() {
    // List<ItemData> listPlant = [];
    listSelectOptionEffect.clear();
    listSelectOptionEffect.addAll(listPlantsData
        .where((element1) => userData!.plants!
            .where((element2) => element2.idPlant == element1.id)
            .isNotEmpty)
        .map((e) {
      ItemData? itemData = listEffectData
          .where((element) =>
              e.effect!.contains(element.id!) && element.type == 'overlay')
          .firstOrNull;

      return SelectOptionItem(
          key: itemData?.name, value: itemData?.image, data: itemData);
    }).toList());
    listSelectOptionEffect.addAll(listPotsData
        .where((element1) => userData!.plants!
            .where((element2) => element2.idPot == element1.id)
            .isNotEmpty)
        .map((e) {
      ItemData? itemData = listEffectData
          .where((element) =>
              e.effect!.contains(element.id!) && element.type == 'overlay')
          .firstOrNull;

      return SelectOptionItem(
          key: itemData?.name, value: itemData?.image, data: itemData);
    }).toList());
    listSelectOptionEffect.removeWhere((element) => element.value == null);
    if (selectEffect == null) {
      if (listSelectOptionEffect.isEmpty) {
        selectEffect = listSelectOptionEffect.firstOrNull;
      } else {
        selectEffect = listSelectOptionEffect[
            Random().nextInt(listSelectOptionEffect.length)];
      }
    }
    update();
  }

  //init data effect
  initDataMusic() {
    // List<ItemData> listPlant = [];
    listSelectOptionMusic.clear();
    listSelectOptionMusic.add(SelectOptionItem(
        key: 'Mặc định'.tr, value: Assets.audios.peacefulgarden, data: {}));
    listSelectOptionMusic.addAll(listPlantsData
        .where((element1) => userData!.plants!
            .where((element2) => element2.idPlant == element1.id)
            .isNotEmpty)
        .map((e) {
      ItemData? itemData = listEffectData
          .where((element) =>
              e.effect!.contains(element.id!) && element.type == 'music')
          .firstOrNull;

      return SelectOptionItem(
          key: itemData?.name, value: itemData?.image, data: itemData);
    }).toList());
    listSelectOptionMusic.addAll(listPotsData
        .where((element1) => userData!.plants!
            .where((element2) => element2.idPot == element1.id)
            .isNotEmpty)
        .map((e) {
      ItemData? itemData = listEffectData
          .where((element) =>
              e.effect!.contains(element.id!) && element.type == 'music')
          .firstOrNull;

      return SelectOptionItem(
          key: itemData?.name, value: itemData?.image, data: itemData);
    }).toList());

    listSelectOptionMusic.removeWhere((element) => element.value == null);
    if (selectMusic == null) {
      try {
        selectMusic = listSelectOptionMusic[
            Random().nextInt(listSelectOptionMusic.length)];
      } on Exception catch (_) {
        selectMusic = listSelectOptionMusic.firstOrNull;
      }
    }
    update();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    await audioPlayerBackground.stop();
    audioPlayerBackground.dispose();
  }

  initAudio({required String asset}) async {
    // Create a player
    await audioPlayerBackground.pause();
    await audioPlayerBackground
        .setAsset(asset); // Schemes: (https: | file: | asset: )
    await audioPlayerBackground.setLoopMode(LoopMode.all);
    await audioPlayerBackground.setVolume(0.3);
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
