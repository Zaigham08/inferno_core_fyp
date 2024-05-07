import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';

import '../../constants.dart';

class TargetWidget extends StatelessWidget {
  final String name, targetId;
  final VoidCallback onTap;

  const TargetWidget({
    super.key,
    required this.name,
    required this.onTap,
    required this.targetId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 50,
                width: 50,
                color: whiteColor,
                child: const Icon(
                  Icons.person,
                  color: bgColor,
                  size: 34,
                ),
              ),
            ),
            14.pw,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  MyText(
                    "Target Id: $targetId",
                    fontSize: 12,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
