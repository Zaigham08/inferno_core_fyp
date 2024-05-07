import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/widgets/shimmer%20widgets/shimmer_box.dart';

class SquareShimmer extends StatelessWidget {
  const SquareShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return const ShimmerBox(
          width: 178,
          height: 156,
          margin: EdgeInsets.only(bottom: 14, right: 8, left: 4),
        );
      },
    );
  }
}
