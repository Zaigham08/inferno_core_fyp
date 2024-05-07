import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/widgets/shimmer%20widgets/shimmer_box.dart';

class RectangleShimmer extends StatelessWidget {
  final double height;
  final double? radius;
  final int items;

  const RectangleShimmer({
    super.key,
    required this.height,
    this.items = 3,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ShimmerBox(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.only(top: 10),
          radius: radius ?? 10,
        );
      },
    );
  }
}
