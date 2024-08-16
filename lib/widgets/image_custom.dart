import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:photo_view_v3/photo_view.dart';
import 'package:terrarium_idle/data/constants/assets.gen.dart';

Widget imageNetwork({
  required String url,
  BoxFit? fit,
  Color? color,
  double? height,
  double? width,
  // double scale = 1.0,
  Alignment alignment = Alignment.center,
  // int? cacheHeight,
  // int? cacheWidth,
  // Animation<double>? opacity,
  ImageRepeat repeat = ImageRepeat.noRepeat,
  bool matchTextDirection = false,
  BlendMode? colorBlendMode,
  // Rect? centerSlice,
  // Map<String, String>? headers,
  FilterQuality filterQuality = FilterQuality.low,
  Key? key,
  // String? semanticLabel
}) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: fit ?? BoxFit.cover,
    color: color,
    height: height,
    width: width,

    // scale: scale,
    alignment: alignment,
    // cacheHeight: cacheHeight,
    // cacheWidth: cacheWidth,
    // opacity: opacity,
    repeat: repeat,
    matchTextDirection: matchTextDirection,
    colorBlendMode: colorBlendMode,
    errorWidget: (context, object, stackTrace) {
      return SizedBox(
        height: double.infinity,
        child: Image.asset(
          Assets.logo.logoPng.path,
          fit: fit ?? BoxFit.fill,
        ),
      );
    },
    // centerSlice: centerSlice,
    // headers: headers,
    filterQuality: filterQuality,
    key: key,
    // semanticLabel: semanticLabel,
    progressIndicatorBuilder: (context, url, downloadProgress) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}

class ViewImageWithZoom extends StatelessWidget {
  const ViewImageWithZoom(
      {super.key, required this.url, required this.index, this.downFile});
  final String url;
  final num index;
  final Function? downFile;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero_show_image$index',
      child: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(
              url,
            ),
            // minScale: 0.7,
            // maxScale: 2.5,
            // initialScale: 0.6,
            onScaleEnd: (context, details, controllerValue) async {
              if ((controllerValue.scale ?? 1) < 0.9) {
                Get.back();
              }
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 8,
                children: [
                  IconButton(
                    color: Get.theme.colorScheme.onBackground.withOpacity(0.3),
                    icon: Icon(
                      LucideIcons.x,
                      color: Get.theme.colorScheme.background,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  if (downFile != null)
                    IconButton(
                      color:
                          Get.theme.colorScheme.onBackground.withOpacity(0.3),
                      icon: Icon(
                        LucideIcons.cloudDownload,
                        color: Get.theme.colorScheme.background,
                      ),
                      onPressed: () {
                        downFile != null ? downFile!() : null;
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
