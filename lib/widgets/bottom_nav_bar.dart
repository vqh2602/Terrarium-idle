
// // ignore_for_file: use_super_parameters

// import 'package:flutter/material.dart';

// /// A single tab in the [FlashyTabBar]. A tab has a title and an icon. The title is displayed when the item is not selected. The icon is displayed when the item is selected. Tabs are always used in conjunction with a [FlashyTabBar].
// class FlashyTabBarItem {
//   FlashyTabBarItem({
//     required this.icon,
//     required this.title,
//     this.activeColor = const Color(0xff272e81),
//     this.inactiveColor = const Color(0xff9496c1),
//   });

//   Color activeColor;
//   final Widget icon;
//   Color inactiveColor;
//   final Text title;
// }

// // ignore: unused_element
// class _FlashTabBarItem extends StatelessWidget {
//   const _FlashTabBarItem(
//       {Key? key,
//       required this.item,
//       required this.isSelected,
//       required this.tabBarHeight,
//       required this.backgroundColor,
//       required this.animationDuration,
//       required this.animationCurve,
//       required this.iconSize})
//       : super(key: key);

//   final Curve animationCurve;
//   final Duration animationDuration;
//   final Color backgroundColor;
//   final double iconSize;
//   final bool isSelected;
//   final FlashyTabBarItem item;
//   final double tabBarHeight;

//   @override
//   Widget build(BuildContext context) {
//     /// The icon is displayed when the item is not selected.
//     /// The title is displayed when the item is selected.
//     /// The icon and title are animated together.
//     /// The icon and title are animated in opposite directions.
//     return Container(
//         color: backgroundColor,
//         height: double.maxFinite,
//         child: Stack(
//           clipBehavior: Clip.hardEdge,
//           alignment: Alignment.center,
//           children: <Widget>[
//             AnimatedAlign(
//               duration: animationDuration,
//               alignment: isSelected ? Alignment.topCenter : Alignment.center,
//               child: AnimatedOpacity(
//                   opacity: isSelected ? 1.0 : 1.0,
//                   duration: animationDuration,
//                   child: IconTheme(
//                     data: IconThemeData(
//                         size: iconSize,
//                         color: isSelected
//                             ? item.activeColor.withOpacity(1)
//                             : item.inactiveColor),
//                     child: item.icon,
//                   )),
//             ),
//             AnimatedPositioned(
//               curve: animationCurve,
//               duration: animationDuration,
//               top: isSelected ? -2.0 * iconSize : tabBarHeight / 4,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(
//                     width: iconSize,
//                     height: iconSize,
//                   ),
//                   CustomPaint(
//                     painter: _CustomPath(backgroundColor, iconSize),
//                     child: SizedBox(
//                       width: 80,
//                       height: iconSize,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             AnimatedAlign(
//                 alignment:
//                     isSelected ? Alignment.center : Alignment.bottomCenter,
//                 duration: animationDuration,
//                 curve: animationCurve,
//                 child: AnimatedOpacity(
//                     opacity: isSelected ? 1.0 : 0.0,
//                     duration: animationDuration,
//                     child: DefaultTextStyle.merge(
//                       style: TextStyle(
//                         color: item.activeColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       child: item.title,
//                     ))),
//             Positioned(
//                 bottom: 0,
//                 child: CustomPaint(
//                   painter: _CustomPath(backgroundColor, iconSize),
//                   child: SizedBox(
//                     width: 80,
//                     height: iconSize,
//                   ),
//                 )),

//             /// This is the selected item indicator
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: AnimatedOpacity(
//                   duration: animationDuration,
//                   opacity: isSelected ? 1.0 : 0.0,
//                   child: Container(
//                     width: 5,
//                     height: 5,
//                     alignment: Alignment.bottomCenter,
//                     margin: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: item.activeColor,
//                       borderRadius: BorderRadius.circular(2.5),
//                     ),
//                   )),
//             )
//           ],
//         ));
//   }
// }

// /// A [CustomPainter] that draws a [FlashyTabBar] background.
// class _CustomPath extends CustomPainter {
//   _CustomPath(this.backgroundColor, this.iconSize);

//   final Color backgroundColor;
//   final double iconSize;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path = Path();
//     Paint paint = Paint();

//     path.lineTo(0, 0);
//     path.lineTo(0, (iconSize * .2) * size.height);
//     path.lineTo(1.0 * size.width, (iconSize * .2) * size.height);
//     path.lineTo(1.0 * size.width, 1.0 * size.height);
//     path.lineTo(0, 0);
//     path.close();

//     paint.color = backgroundColor;
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }
