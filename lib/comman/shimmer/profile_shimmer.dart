import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 90),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        ShimmerBox(height: 20, width: 100),
        const SizedBox(height: 10),
        ShimmerBox(height: 40, width: 120, radius: 8),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                ShimmerBox(height: 50, width: double.infinity, radius: 12),
                const SizedBox(height: 20),
                ...List.generate(3, (index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          ShimmerBox(height: 30, width: 30, radius: 8),
                          const SizedBox(width: 16),
                          Expanded(child: ShimmerBox(height: 16, width: 150)),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (index != 2) const Divider(),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                ShimmerBox(height: 45, width: double.infinity, radius: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.radius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
