import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../res/widgets/button components/icon_text_btn.dart';

class Miscellaneous extends StatelessWidget {
  const Miscellaneous({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Miscellaneous"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextBtn(
                  btnText: "CMD\n enable/disable",
                  icon: Icons.settings,
                  width: Get.width*.42,
                  height: 166,
                  onTap: () {},
                ),
                5.pw,
                IconTextBtn(
                  btnText: "Task Manager\n enable/disable",
                  icon: Icons.widgets,
                  width: Get.width*.42,
                  height: 166,
                  onTap: () {},
                ),
              ],
            ),
            25.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextBtn(
                  btnText: "Internet\n enable/disable",
                  icon: Icons.wifi,
                  width: Get.width*.42,
                  height: 166,
                  onTap: () {},
                ),
                5.pw,
                IconTextBtn(
                  btnText: "Clear Logs",
                  icon: Icons.delete_outline,
                  width: Get.width*.42,
                  height: 166,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
