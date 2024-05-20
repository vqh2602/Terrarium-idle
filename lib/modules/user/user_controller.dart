import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/data/repositories/image_repo.dart';
import 'package:terrarium_idle/data/storage/storage.dart';
import 'package:terrarium_idle/mixin/firestore_mixin.dart';
import 'package:terrarium_idle/mixin/user_mixin.dart';
import 'package:terrarium_idle/modules/login/login_screen.dart';

class UserController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, FireStoreMixin {
  // GetStorage box = GetStorage();
  RepoImage repoImage = RepoImage();
  UserData? user;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserData();
    changeUI();
  }

  getUserData() async {
    user = await getDataUser(
      firebaseAuth.currentUser?.uid ?? '',
    );
    if (user == null) {
      await firebaseAuth.signOut();
      Get.offAndToNamed(LoginScreen.routeName);
    }
    updateUI();
  }

  updateUser({required UserData? userData}) async {
    user = await updateDataUser(userData: userData);
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
