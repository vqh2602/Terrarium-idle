import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/login/login_screen.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xóa tài khoản'.tr),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText.bodyMedium(
              'Xóa tài khoản của bạn'.tr,
            ),
            SText.bodyMedium(
                'Lưu ý rằng việc xóa tài khoản sẽ không thể đảo ngược và có nghĩa bạn sẽ không thể truy cập vào ứng dụng và dữ liệu'
                    .tr),
            // FxText(
            //     'yêu cầu xóa tài khoản và dữ liệu tài khoản NinhBinhTour: \n email: <email của bạn> \n phone: <số điện thoại của bạn nếu có>'
            //         .cl()),

            SText.bodyMedium(
                'Tài khoản sẽ bị xóa hoàn toàn sau khi xóa trong vòng 30 ngày, để kích hoạt lại tài khoản hãy đăng nhập lại trước khi hết hạn 30 ngày kể từ ngày xóa'
                    .tr),
            SText.bodyMedium(
              'Dữ liệu nào sẽ bị xóa?'.tr,
            ),
            SText.bodyMedium(
                'Toàn bộ thông tin cá nhân của bạn, dữ liệu đã tạo'.tr),
            ElevatedButton(
              onPressed: () {
                ShareFuntion.onPopDialog(
                    context: context,
                    title: 'Xác nhận xóa tài khoản'.tr,
                    onCancel: () {
                      Get.back();
                    },
                    onSubmit: () {
                      buildToast(
                          message: 'Đã xóa tài khoản thành công'.tr,
                          status: TypeToast.getSuccess);
                      Get.offAndToNamed(LoginScreen.routeName);
                    });
              },
              child: Text('Xác nhận xóa'.tr),
            ),
          ],
        ),
      )),
    );
  }
}
