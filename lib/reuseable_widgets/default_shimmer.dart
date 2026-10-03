import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultShimmer extends StatelessWidget {
  const DefaultShimmer(
      {super.key,
      required this.height,
      required this.width,
      this.baseColor,
      this.highlightColor,
      this.color,
      this.radius});

  final double? height;
  final double? width;
  final double? radius;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(radius ?? 0)),
      ),
    );
  }
}
