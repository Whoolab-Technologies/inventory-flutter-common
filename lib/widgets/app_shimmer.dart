import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.height,
    required this.width,
    this.shape,
  });
  final double height;
  final double width;
  final BoxShape? shape;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: shape ?? BoxShape.rectangle,
          borderRadius: (shape ?? BoxShape.rectangle) == BoxShape.circle
              ? null
              : BorderRadius.circular(10.r),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
