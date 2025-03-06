import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:terrarium_idle/data/local/list_bag.dart';
import 'package:terrarium_idle/data/models/event.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/data/repositories/event_repo.dart';
import 'package:terrarium_idle/function/color_helper.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/event/webview_process.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';

class EventController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  UserController userController = Get.find();
  GetStorage box = GetStorage();
  EventRepo eventRepo = EventRepo();
  List<Event> listEvent = [];
  UserData? userData = UserData();

  @override
  Future<void> onInit() async {
    super.onInit();
    listEvent = await eventRepo.getEvent();
    userData = await userController.getUserData();
    addEvent();
    changeUI();
  }

  Future<void> addEvent() async {
    listEvent = listEvent.reversed.toList();
    update();
    // listEvent.add(Event(
    //   eventdata: [
    //     Eventdata(
    //       title: 'Nhận huy hiệu thăng cấp',
    //       description: 'Nhận huy hiệu thăng cấp khi cấp độ nhân vật đạt 50',
    //       image: 'https://i.imgur.com/4y10Hcs.png',
    //       local: 'vi',
    //     ),
    //     Eventdata(
    //       title: 'Receive promotion badge',
    //       description:
    //           'Receive a level up badge when your character level reaches 50',
    //       image: 'https://i.imgur.com/4y10Hcs.png',
    //       local: 'en',
    //     )
    //   ],
    //   create: '',
    //   end: '~',
    //   link: 'clam-level-up',
    //   start: '~',
    // ));
  }

  processLinkEvent(String link) async {
    var userID = userData?.user?.userID;
    var userLevel = userData?.user?.userLevel;
    var userFloor = userData?.user?.userFloor;
    var bagId = userData?.user?.bag
        ?.map((e) => e.idBag)
        .toList()
        .toString()
        .replaceAll(' ', '')
        .replaceAll('[', '')
        .replaceAll(']', '');
    var plantsId = userData?.cart?.cartPlants
        .toString()
        .replaceAll(' ', '')
        .replaceAll('[', '')
        .replaceAll(']', '');
    var potId = userData?.cart?.cartPots
        .toString()
        .replaceAll(' ', '')
        .replaceAll('[', '')
        .replaceAll(']', '');
    if (link == 'clam-level-up') {
      // print(
      //     'https://vqh2602.github.io/dailycoccoli_data.github.io/event/event_level_terrarium/index.html?userLevel=${userData?.user?.userLevel}&userId=${userData?.user?.userID}&bagId=${userData?.user?.bag?.map((e) => e.idBag).toList().toString().replaceAll('[', '').replaceAll(']', '')}');
      Get.to(WebViewProcess(
          html:
              'https://vqh2602.github.io/dailycoccoli_data.github.io/event/event_level_terrarium/index.html?userLevel=$userLevel&userId=$userID&bagId=$bagId'));
    } else if (link == 'clam-floor') {
      // print(
      //     'https://vqh2602.github.io/dailycoccoli_data.github.io/event/events_floors/index.html?userFloor=${userData?.user?.userFloor}&userId=${userData?.user?.userID}&bagId=${userData?.user?.bag?.map((e) => e.idBag).toList().toString().replaceAll('[', '').replaceAll(']', '')}');
      Get.to(WebViewProcess(
          html:
              'https://vqh2602.github.io/dailycoccoli_data.github.io/event/events_floors/index.html?userFloor=$userFloor&userId=$userID&bagId=$bagId'));
    }
    if (link == 'clam-lavender-plant') {
      Get.to(WebViewProcess(
          html:
              'https://vqh2602.github.io/dailycoccoli_data.github.io/event/lucky-wheel/index.html?oxygen=${userData?.money?.oxygen}&plants=$plantsId&pots=$potId&userLevel=$userLevel&userId=$userID&bagId=$bagId'));
    } else {
      ShareFuntion.showWebInApp(link);
    }
  }

  InAppWebViewController? processCallBack(
      InAppWebViewController? webViewController) {
    webViewController?.addJavaScriptHandler(
        handlerName: 'event_get_bag_level',
        callback: (args) async {
          // Xử lý thông điệp từ WebView
          if (args[0] == 'true') {
            await userController.updateUser(
              userData: userController.user?.copyWith(
                user: userController.user?.user?.copyWith(bag: [
                  ...userController.user?.user?.bag ?? [],
                  Bag(
                    idBag: listBagsData[0].id,
                    nameBag: listBagsData[0].name,
                    colorBag: Color(int.parse(listBagsData[0].effect ??
                        Colors.black.toInt32.toString())),
                  ),
                ]),
              ),
            );
            userController.getUserData();
            buildToast(
                message: 'Badge received', status: TypeToast.toastSuccess);
            Get.back();
          }
          return null;
        });
    webViewController?.addJavaScriptHandler(
        handlerName: 'event_get_bag_floor',
        callback: (args) async {
          // Xử lý thông điệp từ WebView
          if (args[0] == 'true') {
            await userController.updateUser(
              userData: userController.user?.copyWith(
                user: userController.user?.user?.copyWith(bag: [
                  ...userController.user?.user?.bag ?? [],
                  Bag(
                    idBag: listBagsData[2].id,
                    nameBag: listBagsData[2].name,
                    colorBag: Color(int.parse(listBagsData[2].effect ??
                        Colors.black.toInt32.toString())),
                  ),
                ]),
              ),
            );
            userController.getUserData();
            buildToast(
                message: 'Badge received', status: TypeToast.toastSuccess);
            Get.back();
          }
          return null;
        });
    webViewController?.addJavaScriptHandler(
        handlerName: 'clam-lavender-plant',
        callback: (args) async {
          // Xử lý thông điệp từ WebView
          if (args[0] != null) {
            // print(args[0]);
            await userController.updateUser(
              userData: userController.user?.copyWith(
                  user: userController.user?.user?.copyWith(
                    // thêm bag
                    bag: (userController.user?.user?.bag ?? []) +
                        [
                          if (args[0]['code']?.toString().contains('bag') ??
                              false)
                            Bag(
                              idBag: listBagsData
                                  .where((element) =>
                                      element.id == args[0]['code'])
                                  .first
                                  .id,
                              nameBag: listBagsData
                                  .where((element) =>
                                      element.id == args[0]['code'])
                                  .first
                                  .name,
                              colorBag: Color(int.parse(listBagsData
                                      .where((element) =>
                                          element.id == args[0]['code'])
                                      .first
                                      .effect ??
                                  Colors.black.toInt32.toString())),
                            )
                        ],
                  ),
                  cart: userController.user?.cart?.copyWith(
                    cartPlants: (userController.user?.cart?.cartPlants ?? []) +
                        [
                          if (args[0]['code']?.toString().contains('plant') ??
                              false)
                            args[0]['code']
                        ]
                      ..removeWhere((element) => element == ''),
                    cartPots: (userController.user?.cart?.cartPots ?? []) +
                        [
                          if (args[0]['code']?.toString().contains('pot') ??
                              false)
                            args[0]['code']
                        ]
                      ..removeWhere((element) => element == ''),
                  ),
                  item: userController.user?.item?.copyWith(
                    fertilizer: (userController.user?.item?.fertilizer ?? 0) +
                        ((args[0]?['code'] == 'fertilizer') ? 1 : 0),
                    shovel: (userController.user?.item?.shovel ?? 0) +
                        ((args[0]?['code'] == 'shovel') ? 1 : 0),
                  ),
                  money: userController.user?.money?.copyWith(
                    gemstone: (userController.user?.money?.gemstone ?? 0) +
                        ((args[0]?['code'] == 'gemstone') ? 10 : 0),
                    oxygen: ((userController.user?.money?.oxygen ?? 0) - 100) +
                        ((args[0]?['code'] == 'oxygen') ? 50 : 0),
                    ticket: (userController.user?.money?.ticket ?? 0) +
                        ((args[0]?['code'] == 'ticket') ? 5 : 0),
                  )),
            );
            userData = await userController.getUserData();
            if (args[0]['code'] == 'gemstone') {
              buildToast(
                  message: 'Received 10 gemstones',
                  status: TypeToast.toastSuccess);
            } else if (args[0]['code'] == 'oxygen') {
              buildToast(
                  message: 'Received 50 oxygen',
                  status: TypeToast.toastSuccess);
            } else if (args[0]['code'] == 'ticket') {
              buildToast(
                  message: 'Received 5 tickets',
                  status: TypeToast.toastSuccess);
            } else if (args[0]['code'] == 'fertilizer') {
              buildToast(
                  message: 'Received 1 fertilizer',
                  status: TypeToast.toastSuccess);
            } else if (args[0]['code'] == 'shovel') {
              buildToast(
                  message: 'Received 1 shovel', status: TypeToast.toastSuccess);
            } else if (args[0]['code'].toString().contains('plant')) {
              buildToast(
                  message: 'Received plant', status: TypeToast.toastSuccess);
              Future.delayed(const Duration(seconds: 1), () {
                Get.back();
              });
            } else if (args[0]['code'].toString().contains('pot')) {
              buildToast(
                  message: 'Received pot', status: TypeToast.toastSuccess);
              Future.delayed(const Duration(seconds: 1), () {
                Get.back();
              });
            } else {
              buildToast(
                  message: 'Received ${args[0]['code']}',
                  status: TypeToast.toastSuccess);
              Future.delayed(const Duration(seconds: 1), () {
                Get.back();
              });
            }
          }
          return null;
        });

    return webViewController;
  }

  bool isDateValid(String endDate) {
    // Định dạng ngày theo định dạng của bạn (ở đây là yyyy-MM-dd)
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    // Chuyển đổi ngày kết thúc từ chuỗi sang đối tượng DateTime
    final DateTime end = dateFormat.parse(endDate);

    // Lấy ngày hiện tại
    final DateTime now = DateTime.now();

    // So sánh ngày hiện tại với ngày kết thúc
    if (kDebugMode) return true;
    return now.isBefore(end) || now.isAtSameMomentAs(end);
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
