import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/view%20models/controllers/target_controller.dart';

import '../../constants.dart';

class TargetWidget extends StatelessWidget {
  final String name, targetId;
  final VoidCallback onTap;
  final TargetController targetController;

  const TargetWidget({
    super.key,
    required this.name,
    required this.onTap,
    required this.targetId,
    required this.targetController,
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
            Expanded(
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
            4.pw,
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: Get.height * .15,
                        child: Column(
                          children: [
                            8.ph,
                            Container(
                                height: 4,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            10.ph,
                            ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: txtColor,
                                  fontSize: 17,
                                ),
                              ),
                              onTap: () {
                                Get.back();
                                targetController.deleteTarget(targetId);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.more_vert_outlined)),
          ],
        ),
      ),
    );
  }
}
