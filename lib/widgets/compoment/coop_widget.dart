import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

Widget coopWidget({required UserData? userData}) {
  return Container(
    decoration: BoxDecoration(
      image: userData?.user?.userImageBackground != null
          ? DecorationImage(
              image: CachedNetworkImageProvider(
                  userData?.user?.userImageBackground ?? ''),
              fit: BoxFit.cover)
          : null,
    ),
    padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 4 * 9,
          backgroundImage:
              CachedNetworkImageProvider(userData?.user?.userAvatar ?? ''),
        ),
        cWidth(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            textTitleMedium(
              '${userData?.user?.userName} - Level ${userData?.user?.userLevel ?? 1}',
            ),
            textBodySmall('Like: ${userData?.user?.userTotalLike ?? 0}'),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textBodySmall('${'Huy hiệu'.tr}: '),
                SizedBox(
                  width: Get.width * 0.5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (Bag item in userData?.user?.bag ?? [])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: textBodySmall(item.nameBag ?? 'N.A',
                              color: item.colorBag),
                        ),
                    ]),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    ),
  );
}
