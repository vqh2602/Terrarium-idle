import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/gift/gift_controller.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({super.key});
  static const String routeName = '/Gift';

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  GiftController giftController = Get.put(GiftController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      child: giftController.getDataConfigGiftGems(),
    );
  }
}
