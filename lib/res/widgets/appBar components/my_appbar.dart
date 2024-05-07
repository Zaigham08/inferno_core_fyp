import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../../view/settings.dart';

AppBar myAppBar({required String title}) {
  return AppBar(
    title: Text(" $title"),
    automaticallyImplyLeading: false,
    actions: [
      InkWell(
        onTap: () {
          Get.to(()=> const SettingsPage());
        },
        child: const Icon(Icons.settings,size: 27),
      ),
      15.pw,
    ],
  );
}