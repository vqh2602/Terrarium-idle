import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:terrarium_idle/widgets/library/parallax_scrolling/parallax_flox_delegate.dart';

class ParallaxImage extends StatelessWidget {
  ParallaxImage({super.key, required this.imageWidget, this.zoomheight});

  final GlobalKey _backgroundImageKey = GlobalKey();
  final Widget Function(GlobalKey?) imageWidget;
  final double? zoomheight;

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (BuildContext context, ViewportOffset position) => Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context),
          listItemContext: context,
          zoomheight: zoomheight,
          backgroundImageKey: _backgroundImageKey,
        ),
        clipBehavior: Clip.antiAlias,
        children: [
          imageWidget(_backgroundImageKey),
          // Image.asset(
          //   imagePath,
          //   key: _backgroundImageKey,
          //   fit: BoxFit.cover,
          // ),
        ],
      ),
    );
  }
}
