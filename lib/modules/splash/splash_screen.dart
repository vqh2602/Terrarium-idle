import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/splash/splash_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashController.checkLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      backgroundColor: const Color(0xfffaf3e1),
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return splashController.obx((state) => Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Container(
                  width: Get.width * 0.5,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    'assets/logo/logo.jpg',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ));
  }
}
