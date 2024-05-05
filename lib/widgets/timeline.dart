// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:timelines/timelines.dart';

// Widget timeLine(
//     {Widget? Function(BuildContext, int)? contentsBuilder, List? listData}) {
//   return Timeline.tileBuilder(
//     shrinkWrap: true,
//     primary: false,
//     padding: EdgeInsets.zero,
//     theme: TimelineThemeData(
//       nodePosition: 0,
//       color: Color(0xff989898),
//       indicatorTheme: IndicatorThemeData(
//         position: 0,
//         size: 16.0,
//       ),
//       connectorTheme: ConnectorThemeData(
//         thickness: 2.0,
//       ),
//     ),
//     builder: TimelineTileBuilder.connected(
//       contentsAlign: ContentsAlign.basic,
//       addAutomaticKeepAlives: false,
//       oppositeContentsBuilder: (context, index) => null,
//       contentsBuilder: contentsBuilder,
//       itemCount: listData?.length ?? 0,
//       indicatorBuilder: (_, index) {
//         return DotIndicator(
//           color: Colors.white,
//           position: 0.07,
//           child: Icon(
//             LucideIcons.dot,
//             color: Colors.white,
//             size: 12.0,
//           ),
//         );
//       },
//       connectorBuilder: (_, index, ___) => SolidLineConnector(
//         color: Get.theme.primaryColor,
//         thickness: 4,
//       ),
//     ),
//   );
// }
