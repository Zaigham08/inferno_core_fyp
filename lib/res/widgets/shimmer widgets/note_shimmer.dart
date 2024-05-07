import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/widgets/shimmer%20widgets/shimmer_box.dart';

import '../../constants.dart';

class NoteShimmer extends StatelessWidget {
  const NoteShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(
          width: 150,
          height: 18,
          margin: EdgeInsets.only(top: kDefaultPadding),
          radius: 5,
        ),
        ShimmerBox(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.only(top: kDefaultPadding),
        ),
        ShimmerBox(
          width: 150,
          height: 18,
          margin: EdgeInsets.only(top: kDefaultPadding),
          radius: 5,
        ),
        ShimmerBox(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.only(top: kDefaultPadding),
        ),
        ShimmerBox(
          width: 150,
          height: 18,
          margin: EdgeInsets.only(top: kDefaultPadding),
          radius: 5,
        ),
        ShimmerBox(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.only(top: kDefaultPadding),
        ),
        ShimmerBox(
          width: 150,
          height: 18,
          margin: EdgeInsets.only(top: kDefaultPadding),
          radius: 5,
        ),
        ShimmerBox(
          width: double.infinity,
          height: 124,
          margin: EdgeInsets.only(top: kDefaultPadding),
        ),
        Center(
          child: ShimmerBox(
            width: 200,
            height: 50,
            margin: EdgeInsets.only(top: 50),
          ),
        ),
      ],
    );
  }
}
