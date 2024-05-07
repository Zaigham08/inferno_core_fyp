import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inferno_core_fyp/view/controls_panel.dart';

import '../res/widgets/appBar components/my_appbar.dart';
import '../res/widgets/general widgets/target_widget.dart';
import '../view models/controllers/general_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GeneralController generalController = Get.put(GeneralController());
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
              TargetWidget(
                name: "Munir",
                targetId: "123",
                onTap: () {},
              ),
              TargetWidget(
                name: "Zain",
                targetId: "123",
                onTap: () {
                  Get.to(() => const ControlPanel());
                },
              ),
              TargetWidget(
                name: "Usman",
                targetId: "123",
                onTap: () {},
              ),
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
