import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/view%20models/controllers/target_controller.dart';

import '../res/constants.dart';
import '../res/widgets/appBar components/my_appbar.dart';
import '../res/widgets/exception_widget.dart';
import '../res/widgets/general widgets/add_target_widget.dart';
import '../res/widgets/general widgets/target_widget.dart';
import '../res/widgets/shimmer widgets/rectangle_shimmer.dart';

class AllTargetsPage extends StatelessWidget {
  const AllTargetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TargetController targetController = Get.put(TargetController());
    final double height = targetController.offlineTargets.length * 90;
    return Scaffold(
        appBar: myAppBar(title: "Targets"),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding - 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addTargetWidget(),
                12.ph,
                const MyText(
                  'Targets (offline)',
                  fontSize: 16,
                  color: txtColor,
                ),
                SizedBox(
                  height: height == 0.0 ? 230 : height,
                  child: Obx(() {
                    final offlineTargets = targetController.offlineTargets;

                    if (targetController.loading.value) {
                      return const RectangleShimmer(
                        height: 60,
                        items: 2,
                        radius: 6,
                      );
                    } else if (targetController.isError.value) {
                      if (targetController.errorStr.value == 'No Internet') {
                        return ExceptionWidget(
                          text: internetExceptionString,
                          onPressed: () => targetController.getAllTargets(),
                        );
                      } else {
                        return ExceptionWidget(
                          text: generalExceptionString,
                          onPressed: () => targetController.getAllTargets(),
                        );
                      }
                    } else if (offlineTargets.isNotEmpty) {
                      return ListView.builder(
                        itemCount: offlineTargets.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TargetWidget(
                            name: offlineTargets[index].name,
                            targetId: offlineTargets[index].targetId,
                            onTap: () {},
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.message_outlined,
                            color: txtColor.withOpacity(.6),
                            size: 60,
                          ),
                          10.ph,
                          Text(
                            "You currently don't have\nany targets.\nClick the button above\nto create your first\n Target.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: txtColor.withOpacity(.8),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ),
                20.ph,
                const MyText(
                  'Targets (online)',
                  fontSize: 16,
                  color: txtColor,
                ),
                TargetWidget(
                  name: "Munir",
                  targetId: "123",
                  onTap: () {},
                ),
                TargetWidget(
                  name: "Usman",
                  targetId: "123",
                  onTap: () {},
                ),
                TargetWidget(
                  name: "Zain",
                  targetId: "123",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
