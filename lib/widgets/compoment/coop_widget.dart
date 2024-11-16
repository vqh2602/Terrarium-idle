import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/data/models/ranking.dart';
import 'package:terrarium_idle/data/models/user.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';

import 'package:terrarium_idle/widgets/widgets.dart';

Widget coopWidget({required User? user, Function()? onTap, Ranking? ranking}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        image: user?.userImageBackground != null
            ? DecorationImage(
                image:
                    CachedNetworkImageProvider(user?.userImageBackground ?? ''),
                fit: BoxFit.cover)
            : null,
      ),
      padding: const EdgeInsets.only(left: 20, right: 12, top: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 4 * 9,
            backgroundImage: CachedNetworkImageProvider(user?.userAvatar ?? ''),
          ),
          cWidth(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Get.width * .6,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SText.bodyMedium(
                      '${user?.userName} - Level ${user?.userLevel ?? 1}',
                      fontWeight: FontWeight.bold),
                ),
              ),
              (ranking != null)
                  ? SText.bodySmall('Oxygen: ${ranking.oxygenCollect}')
                  : SText.bodySmall('Like: ${user?.userTotalLike ?? 0}'),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SText.bodySmall('${'Huy hiệu'.tr}: '),
                  Container(
                    color: Colors.transparent,
                    width: Get.width * 0.45,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        for (Bag item in user?.bag ?? [])
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SText.bodySmall(item.nameBag?.tr ?? 'N.A',
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
    ),
  );
}
