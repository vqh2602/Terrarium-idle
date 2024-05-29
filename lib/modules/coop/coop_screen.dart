import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:terrarium_idle/modules/coop/coop_controller.dart';
import 'package:terrarium_idle/modules/coop/garden_coop/garden_coop_screen.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/compoment/coop_widget.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';

class CoopScreen extends StatefulWidget {
  const CoopScreen({super.key});
  static const String routeName = '/coop';

  @override
  State<CoopScreen> createState() => _CoopScreenState();
}

class _CoopScreenState extends State<CoopScreen> {
  CoopController coopController = Get.find();
  GardenController gardenController = Get.find();

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
    return buildBody(
        // backgroundColor: const Color(0xfffaf3e1),
        context: context,
        body: _buildBody(),
        appBar: AppBar(
          title: textTitleLarge('Thế giới'.tr),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.chevronLeft),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
        ));
  }

  Widget _buildBody() {
    return coopController.obx((state) => SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 12, bottom: 12),
                // height: 50,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: coopController.textSearchTE,
                  onChanged: (value) => coopController.filterUser(value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Get.theme.primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Get.theme.primaryColor),
                          borderRadius: BorderRadius.circular(100)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100)),
                      // labelText: 'Nhập id',
                      hintText: 'Nhập id'.tr,
                      hintStyle: textStyleCustom(fontSize: 14)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: coopController.userdataFilter?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await gardenController.audioPlayerBackground.pause();
                          await Get.toNamed(GardenCoopScreen.routeName,
                              arguments: coopController.userdataFilter?[index]);
                          await gardenController.audioPlayerBackground.play();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            coopWidget(
                                userData:
                                    coopController.userdataFilter?[index]),
                            const Divider(
                              thickness: 2,
                              height: 4,
                              color: Colors.black12,
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
