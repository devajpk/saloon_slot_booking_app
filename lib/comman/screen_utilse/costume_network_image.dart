import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit;
  final double width;
  final double height;
  final bool isBorderEnable;
  final bool onlyCurve;
  final bool leftOnlyCurve;
  final Color? color;

  const CustomImageWidget({
    this.leftOnlyCurve = false,
    this.onlyCurve = false,
    super.key,
    this.isBorderEnable = true,
    required this.imageUrl,
    this.borderRadius = 10.0,
    this.fit = BoxFit.cover,
    this.color,
    this.width = double.maxFinite,
    this.height = double.maxFinite,
  });

  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isBorderEnable
            ? Border.all(color: color ?? AppColor.lightGreyColor)
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: onlyCurve
            ? leftOnlyCurve
                ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
            : BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          useOldImageOnUrlChange: false,
          cacheManager: _isMobile ? null : null, // Disable custom caching on Web/Desktop
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.white,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.lightGreyColor),
                color: Colors.grey.shade400,
              ),
            ),
          ),
          errorWidget: (context, url, error) {
            debugPrint("Image load failed for URL: $url");
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.extraLightGrey,
              ),
              child: Icon(
                Icons.image_not_supported,
                size: 30.w,
                color: Colors.grey,
              ),
            );
          },
          imageBuilder: (context, imageProvider) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
