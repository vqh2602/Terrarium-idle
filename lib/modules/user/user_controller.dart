import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:terrarium_idle/data/local/list_bag.dart';
import 'package:terrarium_idle/data/local/list_plants.dart';
import 'package:terrarium_idle/data/models/item.dart';
import 'package:terrarium_idle/data/models/ranking.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/data/repositories/image_repo.dart';
import 'package:terrarium_idle/data/storage/storage.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/mixin/user_mixin.dart';
import 'package:terrarium_idle/modules/login/login_screen.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
// import 'package:terrarium_idle/widgets/build_toast.dart';

class UserController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, FireStoreMixin {
  // GetStorage box = GetStorage();
  RepoImage repoImage = RepoImage();
  UserData? user;
  List<ItemData> listMyBags = [];
  bool isGraphicsHight = true;
  bool isCache = false;
  bool isLandscapeFade = false; // mờ phong cảnh
  Ranking? rank;
  PackageInfo? packageInfo;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserData();
    getDataUserRealtime(firebaseAuth.currentUser?.uid ?? '',
        (p0) => {user = p0, getUserData(), update()});
    isGraphicsHight = box.read(Storages.graphicsOption) ?? true;
    isCache = box.read(Storages.isCache) ?? false;
    isLandscapeFade = box.read(Storages.isLandscapeFade) ?? false;
    updateColumData();

    // hàm xử lý sự kiện thu thập
    checkCreateNewRank();
    packageInfo = await PackageInfo.fromPlatform();
    changeUI();
  }

  // kiểm tra rank của bản thân đã tồn tại hay chưa, nếu chưa thì tạo mới
  checkCreateNewRank({bool isRealtime = true}) async {
    rank = await getDataRank(user?.user?.userID ?? '');
    if (rank == null && user != null) {
      await createDataRank(user: user!.user!);
    }
    if (isRealtime) {
      getDataRankRealtime(
          firebaseAuth.currentUser?.uid ?? '', (p0) => {rank = p0, update()});
    }
  }

  // cập nhật giá trị cho người dùng // bản mới thêm trường isHanging
  updateColumData() {
    if (user?.plants?.firstOrNull != null) {
      if (user?.plants?.firstOrNull?.isHanging == null) {
        List<Plants>? listDataPlants = user?.plants;
        for (int i = 0; i < listDataPlants!.length; i++) {
          if (listDataPlants[i].isHanging == null) {
            listDataPlants[i].isHanging = (listPlantsData
                        .where((element) =>
                            element.id == listDataPlants[i].idPlant)
                        .firstOrNull
                        ?.itemTypeAttribute ??
                    ItemTypeAttribute.none) ==
                ItemTypeAttribute.hanging;
          }
        }
        user?.plants = listDataPlants;
        updateUser(userData: user);
      }
    }
  }

  Future<UserData?> getUserData() async {
    user = await getDataUser(
      firebaseAuth.currentUser?.uid ?? '',
    );
    if (user == null) {
      await firebaseAuth.signOut();
      Get.offAndToNamed(LoginScreen.routeName);
    }
    listMyBags = listBagsData
        .where((element) =>
            (user?.user?.bag
                    ?.where((element1) => element1.idBag == element.id)
                    .length ??
                0) >
            0)
        .toList();
    // print(user.toString());
    // buildToast(
    //   message: 'Thành công'.tr,
    //   status: TypeToast.toastSuccess,
    // );
    updateUI();
    return user;
  }

  updateUser({required UserData? userData}) async {
    // print(userData.toString());
    user = await updateDataUser(userData: userData);
    if (user == null) {
      Get.offAndToNamed(LoginScreen.routeName);
    }
    update();
    // loadingUI();
    // try {
    //   // await box.write(
    //   //     Storages.dataUserCloudTimeOut, DateTime.now().toString());
    //   await updateDataUser(
    //       userData: UserData.fromJson(box.read(Storages.dataUserCloud)),
    //       isCloud: true);
    //   buildToast(
    //       message: 'Đã đồng bộ lên máy chủ', status: TypeToast.toastSuccess);
    //   changeUI();
    // } on Exception catch (_) {
    //   changeUI();
    //   // if (box.read(Storages.dataUserCloud) != null &&
    //   //     box.read(Storages.dataUserCloud) != '') {
    //   //   UserData userData =
    //   //       UserData.fromJson(box.read(Storages.dataUserCloud));
    //   //   await updateDataUser(userData: userData);
    //   // }
    // }
    // changeUI();
  }

  changeGraphics(BuildContext? context) async {
    await ShareFuntion.onPopDialog(
        context: context ?? Get.context!,
        title:
            'Bật đồ họa hiệu suất cao sẽ tăng bộ nhớ cần sử dụng và có thể gây giật lag trên máy cấu hình yếu, nhưng bạn sẽ có 1 khu vườn đẹp hơn'
                .tr,
        titleCancel: '(Tắt)'.tr,
        titleSubmit: '(Bật)'.tr,
        onCancel: () async {
          Get.back();
          isGraphicsHight = false;
          await box.write(Storages.graphicsOption, false);
          buildToast(message: 'Hoàn tất'.tr, status: TypeToast.toastSuccess);
          clearAndResetApp();
        },
        onSubmit: () async {
          Get.back();
          isGraphicsHight = true;
          await box.write(Storages.graphicsOption, true);
          buildToast(message: 'Hoàn tất'.tr, status: TypeToast.toastSuccess);
          clearAndResetApp();
        });
  }

  changeCache(BuildContext? context) async {
    await ShareFuntion.onPopDialog(
        context: context ?? Get.context!,
        title:
            'Bật chế độ bộ nhớ sẽ có thể khiến thiết bị xử lý nhiều hơn, nhưng sẽ giảm tải dung lượng mạng của bạn'
                .tr,
        titleCancel: '(Tắt)'.tr,
        titleSubmit: '(Bật)'.tr,
        onCancel: () async {
          Get.back();
          isCache = false;
          await box.write(Storages.isCache, false);
          buildToast(message: 'Hoàn tất'.tr, status: TypeToast.toastSuccess);
          clearAndResetApp();
        },
        onSubmit: () async {
          Get.back();
          isCache = true;
          await box.write(Storages.isCache, true);
          buildToast(message: 'Hoàn tất'.tr, status: TypeToast.toastSuccess);
          clearAndResetApp();
        });
  }

  changeLandscapeFade(BuildContext? context) async {
    await ShareFuntion.onPopDialog(
        context: context ?? Get.context!,
        title:
            'Bật chế độ mờ phong cảnh sẽ làm cho khu vườn của bạn trở nên rõ nét hơn'
                .tr,
        titleCancel: '(Tắt)'.tr,
        titleSubmit: '(Bật)'.tr,
        onCancel: () async {
          Get.back();
          isLandscapeFade = false;
          await box.write(Storages.isLandscapeFade, false);
          buildToast(message: 'Hoàn tất'.tr, status: TypeToast.toastSuccess);
          clearAndResetApp();
        },
        onSubmit: () async {
          Get.back();
          isLandscapeFade = true;
          await box.write(Storages.isLandscapeFade, true);
          buildToast(message: 'Hoàn tất'.tr, status: TypeToast.toastSuccess);
          clearAndResetApp();
        });
  }

  changeImage() async {
    loadingUI();
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String? img = await repoImage.uploadImage(File(image.path));
      if (img != null) {
        UserData? userDataCustom =
            user!.copyWith(user: user!.user?.copyWith(userAvatar: img));
        await updateDataUser(userData: userDataCustom);
        user = userDataCustom;
        changeUI();
      }
    }
    changeUI();
  }

  logOut() async {
    await box.write(Storages.dataUserCloudTimeOut, null);
    await box.write(Storages.dataUserCloud, null);
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
