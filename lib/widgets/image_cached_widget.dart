import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../component/theme/theme.dart';

class ImageCachedWidget extends StatelessWidget {
  const ImageCachedWidget({
    super.key,
    required this.url,
  });

  final String? url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      imageBuilder: (context, imageProvider) => DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => const Skeletonizer(
        child: ColoredBox(color: AppColor.white),
      ),
      errorWidget: (context, url, error) => const ColoredBox(
        color: AppColor.white,
        child: Placeholder(),
      ),
      memCacheHeight: 202,
      memCacheWidth: 360,
    );
  }
}
