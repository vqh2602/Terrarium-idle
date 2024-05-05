import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget animationListview(
    {required Widget Function(
      int index, {
      BuildContext? context,
    }) itemBuilder,
    List? listData,
    EdgeInsets? padding,
    Axis scrollDirection = Axis.vertical,
    ScrollPhysics? physics,
    bool shrinkWrap = true}) {
  return AnimationLimiter(
      child: ListView.builder(
          shrinkWrap: shrinkWrap,
          scrollDirection: scrollDirection,
          itemCount: listData?.length ?? 0,
          physics: physics,
          padding: padding ?? const EdgeInsets.only(left: 5, bottom: 20),
          itemBuilder: (BuildContext ctx, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                verticalOffset: 100.0,
                child: FadeInAnimation(
                  child: itemBuilder(index),
                ),
              ),
            );
          }));
}

Widget aniamtionGirdView(
    {required Widget Function(
      int index, {
      BuildContext? context,
    }) itemBuilder,
    List? listData,
    Axis scrollDirection = Axis.vertical,
    ScrollPhysics? physics,
    bool shrinkWrap = true,
    bool? primary,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    SliverGridDelegate? gridDelegate}) {
  return AnimationLimiter(
    child: GridView.builder(
        shrinkWrap: shrinkWrap,
        primary: primary,
        controller: controller,
        padding: padding,
        gridDelegate: gridDelegate ??
            const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 5.7 / 7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
        itemCount: listData?.length,
        itemBuilder: (BuildContext ctx, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 700),
            child: SlideAnimation(
              verticalOffset: 100.0,
              child: FadeInAnimation(
                child: itemBuilder(index),
              ),
            ),
          );
        }),
  );
}
