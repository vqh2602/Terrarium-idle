import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBox extends StatelessWidget {
  const BlurBox({
    super.key,
    required this.child,
    this.clipBehavior = Clip.hardEdge,
    this.borderRadius = BorderRadius.zero,
    this.blurColor,
    this.blurSigma = 10.0,
  });

  final Widget child;
  final Clip clipBehavior;
  final BorderRadiusGeometry borderRadius;
  final double blurSigma;
  final Color? blurColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: blurColor ??
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.86),
          ),
          child: child,
        ),
      ),
    );
  }
}
