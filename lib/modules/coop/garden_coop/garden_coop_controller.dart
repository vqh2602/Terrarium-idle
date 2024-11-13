import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/data/local/list_effect.dart';
import 'package:terrarium_idle/data/local/list_plants.dart';
import 'package:terrarium_idle/data/local/list_pots.dart';
import 'package:terrarium_idle/data/local/list_weather.dart';
import 'package:terrarium_idle/data/models/item.dart';
import 'package:terrarium_idle/data/models/select_option_item.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/data/repositories/image_repo.dart';
import 'package:terrarium_idle/data/storage/storage.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/service/firebase_push.dart';
// import 'package:terrarium_idle/data/storage/storage.dart';
// import 'package:terrarium_idle/modules/auth/login/login_screen.dart';
// import 'package:dart_appwrite/dart_appwrite.dart' as server_appwrite;

class GardenCoopController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, FireStoreMixin {
  AudioPlayer audioPlayerBackground = AudioPlayer();
  UserController userController = Get.find();
  bool isEdit = false;
  UserData? userData = Get.arguments;
  UserData? myUser;
  bool isRain = false;
  List<SelectOptionItem> listSelectOptionEffect = [];
  List<SelectOptionItem> listSelectOptionMusic = [];
  List<SelectOptionItem> listSelectOptionWeatherLandscape = [];
  SelectOptionItem? selectEffect;
  SelectOptionItem? selectMusic;
  SelectOptionItem? selectWeatherLandscape;
  RepoImage repoImage = RepoImage();
  bool isWater = false;
  bool isLike = false;
  bool isGraphicsHight = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    isRain = ShareFuntion.gacha(winRate: 10);
    myUser = await userController.getUserData();
    isGraphicsHight = box.read(Storages.graphicsOption) ?? false;
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
        .where((element1) => (userData?.plants ?? [])
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
        .where((element1) => (userData?.plants ?? [])
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
    // thêm trạng thái là trống
    listSelectOptionEffect.insert(
        0, SelectOptionItem(key: 'Mặc định'.tr, value: '', data: {}));
    update();
  }

  //init data effect
  initDataMusic() {
    // List<ItemData> listPlant = [];
    listSelectOptionMusic.clear();
    listSelectOptionMusic.add(SelectOptionItem(
        key: 'Mặc định'.tr, value: Assets.audios.peacefulgarden, data: {}));
    listSelectOptionMusic.addAll(listPlantsData
        .where((element1) => (userData?.plants ?? [])
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
        .where((element1) => (userData?.plants ?? [])
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

  initDataWeatherLandscape() {
    // List<ItemData> listPlant = [];
    listSelectOptionWeatherLandscape.clear();
    listSelectOptionWeatherLandscape
        .add(SelectOptionItem(key: 'Mặc định'.tr, value: '', data: {}));
    listSelectOptionWeatherLandscape.addAll(listPlantsData
        .where((element1) => userData!.plants!
            .where((element2) => element2.idPlant == element1.id)
            .isNotEmpty)
        .map((e) {
      ItemData? itemData = listWeatherLandscapeData
          .where((element) =>
              e.effect!.contains(element.id!) && element.type == 'landscape')
          .firstOrNull;

      return SelectOptionItem(
          key: itemData?.name, value: itemData?.image, data: itemData);
    }).toList());
    listSelectOptionWeatherLandscape.addAll(listPotsData
        .where((element1) => userData!.plants!
            .where((element2) => element2.idPot == element1.id)
            .isNotEmpty)
        .map((e) {
      ItemData? itemData = listWeatherLandscapeData
          .where((element) =>
              e.effect!.contains(element.id!) && element.type == 'landscape')
          .firstOrNull;

      return SelectOptionItem(
          key: itemData?.name, value: itemData?.image, data: itemData);
    }).toList());

    listSelectOptionWeatherLandscape
        .removeWhere((element) => element.value == null);
    if (selectWeatherLandscape == null) {
      try {
        selectWeatherLandscape = listSelectOptionWeatherLandscape[
            Random().nextInt(listSelectOptionWeatherLandscape.length)];
      } on Exception catch (_) {
        selectWeatherLandscape = listSelectOptionWeatherLandscape.firstOrNull;
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
  sendLike() async {
    final directory = await getApplicationDocumentsDirectory();
//creates text_file in the provided path.
    File file = File('${directory.path}/text_file_${myUser?.user?.userID}.txt');
    String content =
        'Like by user: ${myUser?.user?.userID}\n Like:${userData?.user?.userID} \n Total Like: ${(int.tryParse(userData?.user?.userTotalLike.toString() ?? '') ?? 0) + 1}';
    await file.writeAsString(content);

    repoImage.uploadFileDiscord(file, 'like', content);

    String? token = await FirebaseCouldMessage().getAccessToken();
    FirebaseCouldMessage().sendNotificationWithAccessToken(
        'fuXCeeuYRruj7d9TKbV3xB:APA91bHQclJuoMARgJkVpsxdB8Rbm0T46lr0wPuZXyy9siO50iHRJpaC5F-zOOTE3k54vvUZNWQCxfHmctdaZPmpvA6ghutAfrB5jzX7NoyrzKS_3_J1KfrT7W4GT167KzrLOeH8T6WD',
        token ?? '');
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
