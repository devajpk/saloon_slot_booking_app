import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomeImageLoader extends StatelessWidget {
  final String imagePath;
  final double? hight;
  final double? width;
  final BoxFit boxFit;
  final BoxShape shape;
  final double borderRadius;
  final bool isNetworkImage;

  const CustomeImageLoader({
    super.key,
    this.borderRadius = 10,
    required this.imagePath,
    this.hight,
    this.width,
    this.boxFit = BoxFit.cover,
    this.shape = BoxShape.rectangle,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final border =
        shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius);

    if (isNetworkImage) {
      Widget img = Image.network(
        imagePath,
        width: width,
        height: hight,
        fit: boxFit,
        // show shimmer while loading
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: width,
              height: hight,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: shape,
                borderRadius: border,
              ),
            ),
          );
        },
        // show error icon on failure
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            Icons.error_outline,
            size: (width != null && hight != null)
                ? (width! < hight! ? width! / 2 : hight! / 2)
                : 24,
          ),
        ),
      );

      // clip to desired shape
      if (shape == BoxShape.circle) {
        return ClipOval(child: img);
      } else {
        return ClipRRect(borderRadius: border!, child: img);
      }
    }

    // asset image path
    return Container(
      height: hight,
      width: width,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: border,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: boxFit,
        ),
      ),
    );
  }
}
