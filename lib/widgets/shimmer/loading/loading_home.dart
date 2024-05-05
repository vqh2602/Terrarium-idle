import 'package:flutter/material.dart';
import 'package:terrarium_idle/widgets/library/shimmer/shimmer.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          ProfilePageShimmer(),
          VideoShimmer(),
          VideoShimmer(isRectBox: true, hasBottomBox: true),
          ListTileShimmer(),
          ListTileShimmer(),
          ListTileShimmer(),
          ListTileShimmer(),
          ListTileShimmer(),
        ],
      ),
    ));
  }
}
