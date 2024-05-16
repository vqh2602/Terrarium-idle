import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:terrarium_idle/modules/coop/coop_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

class CoopScreen extends StatefulWidget {
  const CoopScreen({super.key});
  static const String routeName = '/coop';

  @override
  State<CoopScreen> createState() => _CoopScreenState();
}

class _CoopScreenState extends State<CoopScreen> {
  CoopController coopController = Get.find();

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
          title: textTitleLarge('Giao lưu'),
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
                      hintText: 'Nhập id',
                      hintStyle: textStyleCustom(fontSize: 14)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: index % 2 == 0
                                    ? const DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            'https://i.imgur.com/f5PNK5c.jpeg)'),
                                        fit: BoxFit.cover)
                                    : null,
                              ),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 12, bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 4 * 9,
                                    backgroundImage: CachedNetworkImageProvider(
                                        'https://dulich3mien.vn/wp-content/uploads/2023/04/Anh-Avatar-doi-1.jpg'),
                                  ),
                                  cWidth(8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textTitleMedium(
                                        'WuangHuy - Level 120',
                                      ),
                                      textBodySmall('Like: 12000'),
                                      textBodySmall(
                                          'Huy hiệu: Top 100, Ngôi sao mới nổi'),
                                    ],
                                  )
                                ],
                              ),
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
          ),
        ));
  }
}
