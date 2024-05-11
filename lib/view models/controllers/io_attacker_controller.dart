import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/repository/io_attacker_repository.dart';

import '../../utils/utils.dart';

class IoAttackerController extends GetxController {
  final _repo = IoAttackerRepository();
  final targetIdController = TextEditingController().obs;
  final userIdController = TextEditingController().obs;
  final targetIdFocusNode = FocusNode().obs;
  final userIdFocusNode = FocusNode().obs;

  RxBool loading = false.obs, isError = false.obs;
  RxString errorStr = ''.obs;
  String commandId = "";

  Future submitCommand({required String targetId, required Map data}) async {
    try {
      Map<String, dynamic> jsonMap =
          await _repo.submitCommand(data: data, targetId: targetId);
      commandId = jsonMap["command"]["id"];

      Utils.toastMsg("Command submitted successfully");
    } catch (error) {
      Utils.toastMsg("Error: $error");
    }
  }

  Future<bool> checkResponseAvailability() async {
    try {
      final Map<String, dynamic> data =
          await _repo.checkResponseAvailability(commandId: commandId);

      if (data.containsKey("available") && data["available"] == true) {
        return true; // Return true if available is true
      } else {
        return false;
      }
    } catch (error) {
      errorStr.value = error.toString();
      return false;
    }
  }

  Future<Map<String, dynamic>> getCommandResponse() async {
    try {
      isError.value = false;
      loading.value = true;
      final Map<String, dynamic> data =
          await _repo.getCommandResponse(commandId: commandId);

      loading.value = false;
      return data;
    } catch (error) {
      loading.value = false;
      isError.value = true;
      errorStr.value = error.toString();
      return {};
    }
  }

  Future<Map<String, dynamic>> executeCommand({required String targetId, required Map data}) async {
    try {
      // Call submitCommand function to submit the command
      Utils.showLoadingDialog('Executing...');
      await submitCommand(targetId: targetId, data: data);

      // Start a timer for 10 seconds
      const timeout = Duration(seconds: 10);
      final endTime = DateTime.now().add(timeout);

      // Repeat checkResponseAvailability function until timeout
      while (DateTime.now().isBefore(endTime)) {
        final bool success = await checkResponseAvailability();

        if (success) {
          final Map<String, dynamic> response = await getCommandResponse();

          if (response.isNotEmpty) {
            Utils.toastMsg("Data received successfully!");
            Utils.dismissLoadingDialog();
            return response;
          } else {
            Utils.dismissLoadingDialog();
            Utils.toastMsg("Error: Unable to retrieve data");
          }
          break; // Exit the loop if successful response received
        }

        // Wait for a short interval before calling checkResponseAvailability again
        await Future.delayed(const Duration(seconds: 1));
      }
      // Handle case if no successful response is received within 10 seconds
      if (!isError.value) {
        Utils.toastMsg("No successful response received within 10 seconds");
      }
      Utils.dismissLoadingDialog();
      return {};
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
      return {};
    }
  }
}
