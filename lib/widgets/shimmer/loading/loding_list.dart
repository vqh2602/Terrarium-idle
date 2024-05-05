import 'package:flutter/material.dart';
import 'package:terrarium_idle/widgets/library/shimmer/shimmer.dart';

class LoadingListEHome extends StatelessWidget {
  const LoadingListEHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const VideoShimmer();
  }
}

class LoadingListPHome extends StatelessWidget {
  const LoadingListPHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [PlayStoreShimmer()],
      ),
    );
  }
}

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
          ProfileShimmer(),
        ],
      ),
    );
  }
}
