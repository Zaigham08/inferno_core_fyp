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

  Future submitCommand(String targetId) async {
    try {
      Utils.showLoadingDialog('Submitting...');
      Map data = {
        "text": '',
        "command_args": "",
      };
      await _repo.submitCommand(data: data, targetId: targetId).then((response) async {
        Utils.dismissLoadingDialog();
        Utils.toastMsg("Command submitted successfully");
        Get.back();
      });
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }

  Future<void> checkResponseAvailability(String commandId) async {
    try {
      isError.value = false;
      loading.value = true;
      final Map<String, dynamic> data = await _repo.checkResponseAvailability(commandId: commandId);

      // final TargetModel fileModel = TargetModel.fromJson(data);
      // files.assignAll(fileModel.files);
      loading.value = false;
    } catch (error) {
      loading.value = false;
      isError.value = true;
      errorStr.value = error.toString();
    }
  }

  Future<void> getCommandResponse(String commandId) async {
    try {
      isError.value = false;
      loading.value = true;
      final Map<String, dynamic> data = await _repo.getCommandResponse(commandId: commandId);

      // final TargetModel fileModel = TargetModel.fromJson(data);
      // files.assignAll(fileModel.files);
      loading.value = false;
    } catch (error) {
      loading.value = false;
      isError.value = true;
      errorStr.value = error.toString();
    }
  }

}
