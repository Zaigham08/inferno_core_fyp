import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/button%20components/my_text_btn.dart';

import '../../res/widgets/general widgets/dotted_strings.dart';
import '../../res/widgets/general widgets/my_text.dart';

class Network extends StatelessWidget {
  const Network({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Network"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: Get.width / 1.27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: whiteColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dotsSeparatedStrings(t1: "IP", t2: "198.168.0.1"),
                    dotsSeparatedStrings(t1: "Country ", t2: "Pakistan"),
                    dotsSeparatedStrings(t1: "More Info ", t2: "Abcd"),
                  ],
                ),
              ),
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextButton(
                  text: "Available\ndevices",
                  onPressed: () {},
                  height: 57,
                ),
                MyTextButton(
                  text: "Get wifi\npasswords",
                  onPressed: () {},
                  height: 57,
                ),
                MyTextButton(
                  text: "Get available\nadapters",
                  onPressed: () {},
                  height: 57,
                ),
              ],
            ),
            20.ph,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: whiteColor, width: 2),
                ),
                child: const SingleChildScrollView(
                  child: MyText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing"
                      " elit. Sed consequat, sapien ac viverra sollicitudin, libero nulla s"
                      "celerisque nulla, sit amet facilisis sapien eros vel quam. Nulla facil"
                      "isi. Curabitur in turpis id metus dictum feugiat. Sed non risus auctor, va"
                      "rius erat id, faucibus eros. Duis ut arcu et neque scelerisque venenatis."),
                ),
              ),
            ),
            10.ph
          ],
        ),
      ),
    );
  }
}
