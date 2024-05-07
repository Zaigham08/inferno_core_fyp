import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/view%20models/controllers/general_controller.dart';

import '../../res/constants.dart';
import '../../res/widgets/button components/my_text_btn.dart';
import '../../res/widgets/input field components/big_input_field.dart';

class ClipboardPage extends StatelessWidget {
  const ClipboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalController = GeneralController();
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
                    ? BigInputField(
                        readOnly: true,
                        height: Get.height * .44,
                        hintText: "User's Clipboard is empty right now!",
                        textColor: blackColor,
                        controller: TextEditingController(text: "Hello world"),
                      )
                    : Column(
                        children: [
                          const BigInputField(
                            height: 140,
                            hintText: "Enter text you want to fill in user's clipboard",
                            textColor: Colors.black,
                          ),
                          14.ph,
                          MyTextButton(
                            text: "Fill",
                            onPressed: () {},
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
