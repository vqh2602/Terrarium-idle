import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:terrarium_idle/data/models/user.dart';
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
        user: User(
            userAvatar:
                'https://dulich3mien.vn/wp-content/uploads/2023/04/Anh-Avatar-doi-1.jpg',
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
        item: Item(fertilizer: 5, shovel: 5),
        money: Money(oxygen: 5000, gemstone: 0, ticket: 0),
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
  Future<UserData?> getDataUser(String id) async {
    try {
      await db.collection("users").where("id", isEqualTo: id).get();
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

  //update data user
  Future<UserData?> updateDataUser({required UserData? userData}) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection("users").doc(userData?.user?.userID).get();

    if (querySnapshot.data() != null && userData != null) {
      final washingtonRef = db.collection("users").doc(userData.user?.userID);
      washingtonRef.update(userData.toMap());
      buildToast(message: 'Hoàn tất', status: TypeToast.toastSuccess);
      return userData;
    }
    buildToast(message: 'Lỗi khi mua hàng', status: TypeToast.toastError);
    return null;
    // }
  }
}
