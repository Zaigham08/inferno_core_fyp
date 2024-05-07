import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/button%20components/my_text_btn.dart';
import 'package:inferno_core_fyp/res/widgets/input%20field%20components/big_input_field.dart';

class HostFilePage extends StatelessWidget {
  const HostFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
              10.ph,
              MyTextButton(
                text: "Confirm",
                onPressed: (){},
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
