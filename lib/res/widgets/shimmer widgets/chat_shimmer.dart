import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/widgets/shimmer%20widgets/shimmer_box.dart';

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return const ListTile(
          leading: ShimmerBox(
            height: 50,
            width: 50,
            margin: EdgeInsets.zero,
            radius: 100,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(
                height: 15,
                width: 100,
                margin: EdgeInsets.zero,
              ),
              ShimmerBox(
                height: 15,
                width: 50,
                margin: EdgeInsets.zero,
              ),
            ],
          ),
          subtitle: ShimmerBox(
            height: 15,
            width: 60,
            margin: EdgeInsets.zero,
          ),
        );
      },
    );
  }
}
