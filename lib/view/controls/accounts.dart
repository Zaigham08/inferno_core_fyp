import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/button%20components/my_text_btn.dart';

import '../../res/widgets/general widgets/dotted_strings.dart';

class Accounts extends StatelessWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accounts"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dotsSeparatedStrings(t1: "Name", t2: "Zain"),
            4.ph,
            dotsSeparatedStrings(t1: "Password ", t2: "Zain123"),
            const Divider(),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextButton(text: "Create", width: 140, radius: 8, onPressed: (){}),
                MyTextButton(text: "List", width: 140, radius: 8, onPressed: (){}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
