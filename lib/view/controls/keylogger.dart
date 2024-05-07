import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/constants.dart';
import '../../res/widgets/input field components/big_input_field.dart';

class KeyLogger extends StatelessWidget {
  const KeyLogger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KeyLogs"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigInputField(
                readOnly: true,
                height: Get.height*.5,
                hintText: "...KeyLogs...",
                textColor: blackColor,
                controller: TextEditingController(text: "Hello world"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
