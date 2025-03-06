import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:rive/rive.dart' as rive;
import 'package:terrarium_idle/c_theme/colors.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';
import 'package:terrarium_idle/modules/login/login_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';

import 'package:terrarium_idle/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return loginController.obx((state) => Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              color: bg500,
            ),
            Container(
              height: Get.height,
              width: Get.width,
              margin: alignment_20_0(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: Get.width * 0.5,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Image.asset(
                          Assets.logo.logoPng.path,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SText.headlineLarge('Terrarium idle'.toUpperCase(),
                          color: Colors.black, fontWeight: FontWeight.w900),
                    ],
                  ),

                  //cHeight(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //  verticalDirection: VerticalDirection.up,
                    children: [
                      SText.bodyMedium(
                        'Đăng nhập để tiếp tục\n sử dụng ứng dụng'.tr,
                        textAlign: TextAlign.center,
                      ),
                      cHeight(12),
                      TextButton.icon(
                        onPressed: () {
                          loginController.login();
                        },
                        label: SText.bodyMedium("Tiếp tục với Google".tr),
                        // backgroundColor: Colors.white,

                        // shape: CircleBorder(),

                        // padding: EdgeInsets.zero,
                        icon: FaIcon(
                          FontAwesomeIcons.googlePlusG,
                          color: text500,
                        ),
                      ),
                      if (!kIsWeb)
                        if (Platform.isIOS)
                          TextButton.icon(
                            onPressed: () {
                              loginController.loginApple();
                            },
                            // color: Colors.white,
                            label: SText.bodyMedium("Tiếp tục với Apple".tr),
                            // textStyle: textStyleCustom(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.bold,
                            //     color: text500),
                            // textColor: Colors.black,
                            // shape: GFButtonShape.pills,
                            // blockButton: true,
                            // size: GFSize.LARGE,
                            // padding: EdgeInsets.zero,
                            icon: Icon(
                              FontAwesomeIcons.apple,
                              color: text500,
                              size: 30,
                            ),
                          ),
                      TextButton.icon(
                        onPressed: () {
                          loginController.loginAnonymous();
                        },
                        label: SText.bodyMedium(
                            "Tiếp tục với người dùng khách".tr),
                        // backgroundColor: Colors.white,

                        // shape: CircleBorder(),

                        // padding: EdgeInsets.zero,
                        icon: FaIcon(
                          FontAwesomeIcons.userSecret,
                          color: text500,
                        ),
                      ),
                      // cHeight(12),

                      // GFButton(
                      //   onPressed: () {
                      //     loginController.loginTiktok();
                      //   },
                      //   color: Colors.white,
                      //   text: "Tiếp tục với Tiktok".tr,
                      //   textStyle: textStyleCustom(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //       color: text500),
                      //   textColor: Colors.black,
                      //   shape: GFButtonShape.pills,
                      //   blockButton: true,
                      //   size: GFSize.LARGE,
                      //   padding: EdgeInsets.zero,
                      //   icon: Icon(
                      //     FontAwesomeIcons.tiktok,
                      //     color: text500,

                      //   ),
                      // ),

                      // Align
                      //   alignment: Alignment.bottomCenter,
                      //     child: Image.asset('assets/background/logo.png',width: 100, fit: BoxFit.cover,))
                    ],
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: SText.bodySmall(
                    'Khi bạn đăng nhập ứng dụng cũng có nghĩa sẽ đồng ý với các điều khoản của chúng tôi.'
                        .tr,
                    textAlign: TextAlign.center,
                  ),
                )),
            IgnorePointer(
              ignoring: true,
              child: Container(
                // color:
                //     Colors.black.withOpacity(0.5), // Màu nền đen với độ mờ 50%
                width: Get.width,
                height: Get.height,
                padding: EdgeInsets.zero,
                child: rive.RiveAnimation.asset(
                  // 'assets/backgrounds/sky_sun_day.riv',
                  // 'assets/backgrounds/sky_rain.riv',
                  Assets.rive.overlay.overlay1,
                  fit: BoxFit.cover,
                ),
                // Căn container để nó phủ lên toàn bộ màn hình
              ),
            )
          ],
        ));
  }
}
