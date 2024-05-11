import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/view%20models/controllers/target_controller.dart';

import '../res/constants.dart';
import '../res/widgets/appBar components/my_appbar.dart';
import '../res/widgets/button components/my_text_btn.dart';
import '../res/widgets/exception_widget.dart';
import '../res/widgets/general widgets/add_target_widget.dart';
import '../res/widgets/general widgets/target_widget.dart';
import '../res/widgets/shimmer widgets/rectangle_shimmer.dart';
import 'controls_panel.dart';

class AllTargetsPage extends StatelessWidget {
  const AllTargetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TargetController targetController = Get.put(TargetController());
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
                'Targets (online)',
                fontSize: 16,
                color: txtColor,
              ),
              Obx(() {
                final double listHeight = targetController.onlineTargets.length * 90;
                final onlineTargets = targetController.onlineTargets;

                if (targetController.loading2.value) {
                  return const SizedBox(
                    height: 140,
                    child: RectangleShimmer(
                      height: 60,
                      items: 2,
                      radius: 6,
                    ),
                  );
                } else if (targetController.isError2.value) {
                  if (targetController.errorStr.value == 'No Internet') {
                    return SizedBox(
                      height: 230,
                      child: ExceptionWidget(
                        text: internetExceptionString,
                        onPressed: () => targetController.getAllTargetsOnline(),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 230,
                      child: ExceptionWidget(
                        text: generalExceptionString,
                        onPressed: () => targetController.getAllTargetsOnline(),
                      ),
                    );
                  }
                } else if (onlineTargets.isNotEmpty) {
                  return SizedBox(
                    height: listHeight,
                    child: ListView.builder(
                      itemCount: onlineTargets.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TargetWidget(
                          name: onlineTargets[index].name,
                          targetId: onlineTargets[index].targetId,
                          targetController: targetController,
                          onTap: () {
                            Get.to(() => ControlPanel(
                              targetId: onlineTargets[index].targetId,
                              targetName: onlineTargets[index].name,
                            ));
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 210,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.message_outlined,
                            color: txtColor.withOpacity(.6),
                            size: 60,
                          ),
                          10.ph,
                          Text(
                            "You currently don't have\nany online targets.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: txtColor.withOpacity(.8),
                            ),
                          ),
                          15.ph,
                          MyTextButton(
                            text: "Refresh",
                            onPressed: ()=> targetController.getAllTargetsOnline(),
                            width: 85,
                            height: 45,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
              20.ph,
              const MyText(
                'All Targets',
                fontSize: 16,
                color: txtColor,
              ),
              Obx(() {
                final double listHeight = targetController.allTargets.length * 90;
                final allTargets = targetController.allTargets;

                if (targetController.loading.value) {
                  return const SizedBox(
                    height: 140,
                    child: RectangleShimmer(
                      height: 60,
                      items: 2,
                      radius: 6,
                    ),
                  );
                } else if (targetController.isError.value) {
                  if (targetController.errorStr.value == 'No Internet') {
                    return SizedBox(
                      height: 230,
                      child: ExceptionWidget(
                        text: internetExceptionString,
                        onPressed: () => targetController.getAllTargets(),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 230,
                      child: ExceptionWidget(
                        text: generalExceptionString,
                        onPressed: () => targetController.getAllTargets(),
                      ),
                    );
                  }
                } else if (allTargets.isNotEmpty) {
                  return SizedBox(
                    height: listHeight,
                    child: ListView.builder(
                      itemCount: allTargets.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TargetWidget(
                          name: allTargets[index].name,
                          targetId: allTargets[index].targetId,
                          targetController: targetController,
                          onTap: () {},
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 220,
                    child: Center(
                      child: Column(
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
                          15.ph,
                          MyTextButton(
                            text: "Refresh",
                            onPressed: ()=> targetController.getAllTargets(),
                            width: 85,
                            height: 45,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
