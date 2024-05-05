import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

mixin FireStoreMixin {
  final db = FirebaseFirestore.instance;
  GetStorage box = GetStorage();
  // tạo dữ liệu của tài khoản
  Future<void> createDataUser(
      {required String? email,
      required String? name,
      required String? id}) async {
    try {
      //FirebaseFirestore db = FirebaseFirestore.instance;
      final user = UserCustom(
          displayName: name,
          email: email,
          coins: 0,
          id: id,
          expirationDate: DateTime.now(),
          themes: []);
      // Add a new document with a generated ID
      // db.collection("users").add(user).then((DocumentReference doc) =>
      //     print('DocumentSnapshot added with ID: ${doc.id}'));
      await db.collection("users").doc(id).set(user.toMap()).onError((e, _) =>
          buildToast(
              message: 'Lỗi tạo tài khoản'.tr, status: TypeToast.toastError));
    } catch (_) {}
  }

// lấy dũ liệu tài khoản
  Future<UserCustom?> getDataUser(String id) async {
    await db.collection("users").where("id", isEqualTo: id).get();
    final docRef = db.collection("users").doc(id);
    DocumentSnapshot doc = await docRef.get();
    try {
      final data = doc.data() as Map<String, dynamic>?;
      var userCustom = data != null
          ? UserCustom(
              id: data["id"],
              email: data["email"],
              coins: data["coins"],
              themes: List<String>.from(data["themes"]))
          : null;
      return userCustom;
    } on Exception catch (e) {
      buildToast(
          message:
              '${'Kiểm tra lại tài khoản & mật khẩu'.tr} \n code: ${e.toString()}',
          status: TypeToast.getError,
          title: 'Lỗi đăng nhập'.tr);
      return null;
    }
    //update();
  }

  //update data user
  Future<bool> updateDataUserCoins(
      {String? id, num? coinsAdd, bool isAdd = true, String? idTheme}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection("users").where("id", isEqualTo: id).get();

    int coins = 0;
    if (querySnapshot.size > 0) {
      final docRef = db.collection("users").doc(id);
      DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      // ...
      coins = data["coins"];
      if (isAdd) {
        coins = data["coins"] + coinsAdd;
      } else {
        if (coins >= (coinsAdd ?? 1)) {
          coins = data["coins"] - coinsAdd;
          if (idTheme != null) {
            List<String> themes = List<String>.from(data["themes"]);
            if (themes.contains(idTheme)) {
              buildToast(
                  title: 'Thông báo'.tr,
                  message: 'Bạn đã sở hữu chủ đề này rồi'.tr,
                  status: TypeToast.getDefault);
              return false;
            } else {
              themes.add(idTheme);
              final washingtonRef = db.collection("users").doc(id);
              washingtonRef.update({"themes": themes});
              // return true;
            }
          }
        } else {
          buildToast(
              message: 'Số dư không đủ'.tr, status: TypeToast.toastError);
          return false;
        }
      }

      // cạp nhat catcoin
      final washingtonRef = db.collection("users").doc(id);
      washingtonRef.update({"coins": coins});
      // await settingController
      //     .getDataUser(userCustom?.email ?? ''),
      // await settingController.onInit()
      return true;
    }
    return false;
    // }
  }
}
