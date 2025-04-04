import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:terrarium_idle/data/models/ranking.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/main.dart';
import 'package:terrarium_idle/modules/coop/coop_controller.dart';
import 'package:terrarium_idle/modules/coop/garden_coop/garden_coop_screen.dart';
import 'package:terrarium_idle/modules/garden/garden_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';
import 'package:terrarium_idle/widgets/base/text/text_style.dart';
import 'package:terrarium_idle/widgets/compoment/coop_widget.dart';

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
          title: SText.titleLarge(
            'Thế giới'.tr,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.chevronLeft),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.info),
              onPressed: () {
                ShareFuntion.showWebInApp(
                    'https://www.vqhapp.name.vn/p/event-top-oxygen.html');
              },
            )
          ],
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
        ));
  }

  Widget _buildBody() {
    return coopController.obx((state) => SafeArea(
          child: DefaultTabController(
            initialIndex: 0,
            length: 4,
            child: Column(
              children: [
                TabBar(
                  labelColor: Get.theme.primaryColor,
                  indicatorColor: Get.theme.primaryColor,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Thế giới'.tr,
                        textAlign: TextAlign.center,
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Top yêu thích'.tr, textAlign: TextAlign.center,
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Top cấp độ'.tr, textAlign: TextAlign.center,
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Top thu thập'.tr, textAlign: TextAlign.center,
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildListDefautl(),
                      _buildList(coopController.userdataFilterLike),
                      _buildList(coopController.userdataFilterLevel),
                      _buildListRank(coopController.listRankOxygen),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _buildListDefautl() {
    return Column(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
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
                hintStyle: STextTheme.bodyMedium
                    .value(context)
                    ?.copyWith(fontSize: 14)),
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
                          user: coopController.userdataFilter?[index].user),
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
    );
  }

  _buildList(List<UserData>? list) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: list?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await gardenController.audioPlayerBackground.pause();
                    await Get.toNamed(GardenCoopScreen.routeName,
                        arguments: list?[index]);
                    await gardenController.audioPlayerBackground.play();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      coopWidget(user: list?[index].user),
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
    );
  }

  _buildListRank(List<Ranking>? list) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: list?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    audioHandler.pause();
                    await gardenController.audioPlayerBackground.pause();

                    await Get.toNamed(GardenCoopScreen.routeName,
                        arguments: UserData(
                          user: list?[index].user,
                        ));
                    audioHandler.play();
                    await gardenController.audioPlayerBackground.play();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          coopWidget(
                              user: list?[index].user, ranking: list?[index]),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: SText.bodyMedium(
                                'Top${index + 1}',
                                color: Get.theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
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
    );
  }
}
