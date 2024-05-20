import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:terrarium_idle/function/share_funciton.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';
import 'package:terrarium_idle/widgets/base/base.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:terrarium_idle/widgets/compoment/bloc_seting.dart';
import 'package:terrarium_idle/widgets/compoment/icon_title.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  static const String routeName = '/user';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserController userController = Get.find();

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
          title: textTitleLarge('Tài khoản'.tr),
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
    return userController.obx((state) => SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 12, bottom: 12),
                // height: 120,
                decoration: const BoxDecoration(color: Colors.white54),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            userController.changeImage();
                          },
                          child: CircleAvatar(
                            radius: Get.width * 0.1,
                            backgroundImage: CachedNetworkImageProvider(
                                userController.user?.user?.userAvatar ?? ''),
                          ),
                        ),
                        cWidth(20),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textTitleLarge(
                                userController.user?.user?.userName ?? 'N.A'),
                            iconTitle(
                              icon: LucideIcons.mail,
                              size: 16,
                              title:
                                  userController.user?.user?.userEmail ?? 'N.A',
                            ),
                            iconTitle(
                              icon: LucideIcons.circleUserRound,
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                        text:
                                            userController.user?.user?.userID ??
                                                ''))
                                    .then((_) {
                                  buildToast(
                                      message: 'Đã sao chép',
                                      status: TypeToast.toastDefault);
                                });
                              },
                              size: 16,
                              title: userController.user?.user?.userID,
                            ),
                            cHeight(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: iconTitle(
                                    icon: LucideIcons.arrowBigUp,
                                    color: Colors.green,
                                    size: 16,
                                    title:
                                        'Level: ${userController.user?.user?.userLevel ?? '0'}',
                                  ),
                                ),
                                Expanded(
                                  child: iconTitle(
                                    icon: LucideIcons.heart,
                                    size: 16,
                                    color: Colors.red,
                                    title:
                                        'Like: ${userController.user?.user?.userTotalLike ?? '0'}',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              cHeight(16),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textTitleMedium('Dịch vụ'.tr, color: Colors.black),
                    cHeight(16),
                    blockSetting(
                        title: 'Đồng bộ dữ liệu',
                        onTap: () {
                          userController.updateUser(
                              userData: userController.user);
                        }),
                    blockSetting(
                        title: 'Liên hệ hỗ trợ'.tr,
                        onTap: () {
                          ShareFuntion.showWebInApp(
                            'https://www.facebook.com/vqhapps',
                          );
                        }),
                    blockSetting(
                        title: 'Chính sách bảo mật'.tr,
                        onTap: () {
                          ShareFuntion.showWebInApp(
                            'https://www.vqhapp.name.vn/p/chinh-sach-bao-mat-daily-brocoli.html',
                          );
                        }),
                    blockSetting(
                        title: 'Điều khoản sử dụng'.tr,
                        onTap: () {
                          ShareFuntion.showWebInApp(
                            'https://www.vqhapp.name.vn/p/ieu-khoan-va-ieu-kien-daily-brocoli.html',
                          );
                        }),
                    blockSetting(
                        title: 'Xóa tài khoản'.tr,
                        onTap: () {
                          ShareFuntion.showWebInApp(
                            'https://www.vqhapp.name.vn/p/xoa-du-lieu-cua-ban-tren-daily-brocoli.html',
                          );
                        }),
                    blockSetting(
                        title: 'Đăng xuất'.tr,
                        onTap: () {
                          ShareFuntion.onPopDialog(
                              context: context,
                              title: 'Bạn muốn đăng xuất?'.tr,
                              onCancel: () {
                                Get.back();
                              },
                              onSubmit: () async {
                                await userController.logOut();
                                await userController.clearDataUser();
                                await userController.clearAndResetApp();
                              });
                        }),
                  ],
                ),
              ),
              cHeight(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      ShareFuntion.showWebInApp(
                        'https://www.facebook.com/vqhapps',
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.squareFacebook),
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                      ShareFuntion.showWebInApp(
                        'https://www.instagram.com/vqh.2602',
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.instagram),
                    color: Colors.grey,
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(FontAwesomeIcons.tiktok),
                  //   color: Colors.grey,
                  // ),
                  IconButton(
                    onPressed: () {
                      ShareFuntion.showWebInApp(
                        'https://www.vqhapp.name.vn/',
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.globePointer),
                    color: Colors.grey,
                  ),
                ],
              ),
              cHeight(kBottomNavigationBarHeight + 100)
            ],
          ),
        ));
  }
}
