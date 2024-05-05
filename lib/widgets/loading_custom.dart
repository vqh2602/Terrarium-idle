import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      color: Get.theme.colorScheme.background,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              color: Get.theme.colorScheme.background,
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/background/bg.png'),
              //         fit: BoxFit.fill)),
            ),
            Center(
              child: Lottie.asset('assets/animation/loadding.json',
                  width: Get.width * 0.5, fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
