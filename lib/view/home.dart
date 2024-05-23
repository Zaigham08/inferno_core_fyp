import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/view%20models/controllers/target_controller.dart';
import 'package:inferno_core_fyp/view/controls_panel.dart';

import '../res/widgets/appBar components/my_appbar.dart';
import '../res/widgets/button components/my_text_btn.dart';
import '../res/widgets/general widgets/exception_widget.dart';
import '../res/widgets/general widgets/target_widget.dart';
import '../res/widgets/shimmer widgets/rectangle_shimmer.dart';
import '../view models/controllers/general_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GeneralController generalController = Get.put(GeneralController());
    TargetController targetController = Get.put(TargetController());
    return Scaffold(
      appBar: myAppBar(title: "InfernoCore"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding - 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  generalController.selectedIndex.value = 1;
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: whiteColor, width: 2),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Target ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(">",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ],
                  ),
                ),
              ),
              10.ph,
              const Text(
                'Targets (online)',
                style: TextStyle(
                  fontSize: 16,
                  color: txtColor,
                ),
              ),
              Obx(() {
                final double listHeight =
                    targetController.onlineTargets.length * 90;
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
                            onPressed: () =>
                                targetController.getAllTargetsOnline(),
                            width: 85,
                            height: 45,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
              15.ph,
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Chat with AI",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: whiteColor,
                            letterSpacing: 1.5),
                      ),
                      SvgPicture.asset(
                        "assets/icons/robot_icon.svg",
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
