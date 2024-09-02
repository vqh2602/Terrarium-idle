import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/login/login_screen.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';

mixin FireStoreMixin {
  final db = FirebaseFirestore.instance;
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  GetStorage box = GetStorage();
  // tạo dữ liệu của tài khoản
  Future<void> createDataUser(
      {required String? email,
      required String? name,
      required String? id}) async {
    try {
      //FirebaseFirestore db = FirebaseFirestore.instance;
      final user = UserData(
        isBan: false,
        isServerUpdate: false,
        user: User(
            userAvatar: 'https://i.imgur.com/pWzNAg8.jpeg',
            userName: name ?? 'user${Random().nextInt(999999999)}',
            bag: [],
            identifier: null,
            latestPurchaseDate: null,
            userEmail: email,
            userID: id,
            userTotalLike: 0,
            userFloor: 2,
            userLevel: 1,
            userLevelEXP: 0),
        cart: Cart(cartPlants: [], cartPots: []),
        item: Item(fertilizer: 40, shovel: 5),
        money: Money(oxygen: 10000, gemstone: 0, ticket: 0),
        plants: [],
      );
      // Add a new document with a generated ID
      // db.collection("users").add(user).then((DocumentReference doc) =>
      //     print('DocumentSnapshot added with ID: ${doc.id}'));
      await db.collection("users").doc(id).set(user.toMap()).onError((e, _) =>
          buildToast(
              message: 'Lỗi tạo tài khoản'.tr, status: TypeToast.toastError));
    } catch (_) {
      firebaseAuth.signOut();
    }
  }

// lấy dũ liệu tài khoản
  Future<UserData?> getDataUser(String id, {bool isCloud = false}) async {
    // DateTime? dateTimeOut =
    //     DateTime.tryParse(box.read(Storages.dataUserCloudTimeOut) ?? '');
    // // local
    // if (!isCloud &&
    //     dateTimeOut != null &&
    //     (DateTime.now().difference(dateTimeOut).inMinutes <= 5)) {
    //   try {
    //     // await box.write(
    //     //     Storages.dataUserCloudTimeOut, DateTime.now().toString());
    //     return UserData.fromJson(box.read(Storages.dataUserCloud) ?? '');
    //   } on Exception catch (_) {
    //     // if (box.read(Storages.dataUserCloud) != null &&
    //     //     box.read(Storages.dataUserCloud) != '') {
    //     //   UserData userData =
    //     //       UserData.fromJson(box.read(Storages.dataUserCloud));
    //     //   await updateDataUser(userData: userData);
    //     // }
    //     await box.write(
    //         Storages.dataUserCloudTimeOut, DateTime.now().toString());
    //   }
    // } else {
    //   try {
    //     if (box.read(Storages.dataUserCloud) != null &&
    //         box.read(Storages.dataUserCloud) != '') {
    //       UserData userData =
    //           UserData.fromJson(box.read(Storages.dataUserCloud));
    //       await updateDataUser(userData: userData);
    //     }
    //   } on Exception catch (_) {}
    //   await box.write(Storages.dataUserCloudTimeOut, DateTime.now().toString());
    // }
//cloud
    try {
      // await db.collection("users").where("id", isEqualTo: id).get();
      final docRef = db.collection("users").doc(id);
      DocumentSnapshot doc = await docRef.get();

      final data = doc.data() as Map<String, dynamic>?;
      var userCustom = data != null
          ? UserData.fromMap(data)
          // UserCustom(
          //     id: data["id"],
          //     email: data["email"],
          //     coins: data["coins"],
          //     themes: List<String>.from(data["themes"]))
          : null;

      return userCustom;
    } on Exception catch (e) {
      buildToast(
          message:
              '${'Kiểm tra lại tài khoản & mật khẩu'.tr} \n code: ${e.toString()}',
          status: TypeToast.getError,
          title: 'Lỗi đăng nhập'.tr);
      await firebaseAuth.signOut();
      Get.offAndToNamed(LoginScreen.routeName);
      return null;
    }
    //update();
  }

  Future<void> getDataUserRealtime(
      String id, Function(UserData) updateUserData) async {
    try {
      // await db.collection("users").where("id", isEqualTo: id).get();

      final docRef = db.collection("users").doc(id);
      docRef.snapshots().listen((event) {
        // DocumentSnapshot doc = await docRef.get();
        DocumentSnapshot doc = event;

        final data = doc.data() as Map<String, dynamic>?;
        var userCustom = data != null
            ? UserData.fromMap(data)
            // UserCustom(
            //     id: data["id"],
            //     email: data["email"],
            //     coins: data["coins"],
            //     themes: List<String>.from(data["themes"]))
            : null;
        // print('data: ${data.toString()}');
        if (userCustom != null) {
          updateUserData(userCustom);
        }
      });
    } on Exception catch (e) {
      buildToast(
          message:
              '${'Kiểm tra lại tài khoản & mật khẩu'.tr} \n code: ${e.toString()}',
          status: TypeToast.getError,
          title: 'Lỗi đăng nhập'.tr);
      await firebaseAuth.signOut();
      Get.offAndToNamed(LoginScreen.routeName);
    }
    //update();
  }

  //update data user
  Future<UserData?> updateDataUser(
      {required UserData? userData, bool isCloud = false}) async {
    if (userData == null) {
      buildToast(
          message: 'Lỗi không tìm thấy thông tin tà khoản'.tr,
          status: TypeToast.toastError);
      return null;
    } else {
      userData = ShareFuntion.updateLevel(userData);
    }

    // DateTime? dateTimeOut =
    //     DateTime.tryParse(box.read(Storages.dataUserCloudTimeOut) ?? '');
    // // local
    // if (!isCloud &&
    //     dateTimeOut != null &&
    //     (DateTime.now().difference(dateTimeOut).inMinutes <= 5)) {
    //   try {
    //     // await box.write(
    //     //     Storages.dataUserCloudTimeOut, DateTime.now().toString());
    //     await box.write(Storages.dataUserCloud, userData.toJson());
    //     return userData;
    //   } on Exception catch (_) {
    //     await box.write(
    //         Storages.dataUserCloudTimeOut, DateTime.now().toString());
    //   }
    // } else {
    //   await box.write(Storages.dataUserCloudTimeOut, DateTime.now().toString());
    // }

    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection("users").doc(userData.user?.userID).get();

    try {
      if (querySnapshot.data() != null) {
        final washingtonRef = db.collection("users").doc(userData.user?.userID);
        await washingtonRef.update(userData.toMap());
        // buildToast(message: 'Hoàn tất'.tr, status: TypeToast.toastSuccess);
        return userData;
      }
    } on Exception catch (e) {
      buildToast(
          message: 'Lỗi khi mua hàng $e'.tr, status: TypeToast.toastError);
    }
    return null;
    // }
  }

  Future<List<UserData>?> getListDataUser({bool isCloud = false}) async {
    // final docRef = await db.collection("users").limit(20).get();
    // QuerySnapshot<Map<String, dynamic>> doc = docRef;

    // final data = doc.docs;
    // var userCustom = data.isNotEmpty
    //     ? List<UserData>.from(data.map((e) => UserData.fromMap(e.data())))
    //     // UserCustom(
    //     //     id: data["id"],
    //     //     email: data["email"],
    //     //     coins: data["coins"],
    //     //     themes: List<String>.from(data["themes"]))
    //     : null;
    // return userCustom;

    final random = Random();
    final totalDocs = await db.collection("users").get();
    final totalUsers = totalDocs.size;

    // Tạo ngẫu nhiên một điểm bắt đầu
    final start = random.nextInt(totalUsers - 30);
    final userIdStart = totalDocs.docs[start].data()["user"];

    final docRef = await db
        .collection("users")
        .orderBy("user") // Dùng một trường bất kỳ để sắp xếp
        .startAt([userIdStart])
        .limit(30)
        .get();

    final userCustom = docRef.docs.isNotEmpty
        ? List<UserData>.from(
            docRef.docs.map((e) => UserData.fromMap(e.data())))
        : null;
    userCustom?.removeWhere((element) => element.plants?.isEmpty ?? true);
    return userCustom;
  }
}
