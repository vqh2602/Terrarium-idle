import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:terrarium_idle/modules/event/event_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/image_custom.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});
  static const String routeName = '/event';

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventController eventController = Get.find();

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
          title: textTitleLarge('Sự kiện'),
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
    return eventController.obx((state) => SafeArea(
          child: Column(
            children: <Widget>[
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imageNetwork(
                                    url: 'https://i.imgur.com/f5PNK5c.jpeg'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 12, bottom: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textTitleMedium(
                                        'Sự kiện đổi oxygen',
                                      ),
                                      textBodySmall(
                                          'Tham gia đổi oxygen để nhận các vật phẩm: Vé sự kiện, đá quí, chậu hồng chấm bi'),
                                      textBodySmall(
                                          'Hạn sự kiện: 23/5/2024 - 30/12/2024'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
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
