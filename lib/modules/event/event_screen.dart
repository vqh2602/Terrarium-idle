import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:terrarium_idle/data/models/event.dart';
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
          title: textTitleLarge('Sự kiện'.tr),
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
    return eventController.obx((state) => eventController.listEvent.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: textBodyMedium('Chưa có sự kiện mới'.tr),
            ),
          )
        : Container(
            color: Colors.transparent,
            child: SafeArea(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: eventController.listEvent.length,
                  itemBuilder: (context, index) {
                    Eventdata? eventdata = (eventController
                        .listEvent[index].eventdata
                        ?.where((element) =>
                            element.local == Get.locale?.countryCode)
                        .firstOrNull);
                    eventdata ??=
                        eventController.listEvent[index].eventdata?.firstOrNull;
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width,
                                child: imageNetwork(
                                    url: eventdata?.image ?? '',
                                    fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 12, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textTitleMedium(
                                      eventdata?.title ?? '',
                                    ),
                                    textBodySmall(eventdata?.description ?? ''),
                                    textBodySmall(
                                        '${'Hạn sự kiện'.tr}: ${eventController.listEvent[index].start} - ${eventController.listEvent[index].end}'),
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
            ),
          ));
  }
}
