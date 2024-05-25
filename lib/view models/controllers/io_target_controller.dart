// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inferno_core_fyp/repository/io_target_repository.dart';
//
// import '../../utils/utils.dart';
//
// class IoTargetController extends GetxController {
//   final _repo = IoTargetRepository();
//   final targetIdController = TextEditingController().obs;
//   final userIdController = TextEditingController().obs;
//   final targetIdFocusNode = FocusNode().obs;
//   final userIdFocusNode = FocusNode().obs;
//
//   RxBool loading = false.obs, isError = false.obs;
//   RxString filePath = ''.obs, errorStr = ''.obs;
//
//   Future pickFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//       if (result != null) {
//         filePath.value = result.files.single.path!;
//       } else {
//         // User canceled the file picker.
//         Utils.toastMsg("No file selected");
//       }
//     } catch (e) {
//       debugPrint("Error picking file: $e");
//     }
//   }
//
//   Future receiveCommandResponse() async {
//     try {
//       Utils.showLoadingDialog('Receiving...');
//       Map data = {
//         "command_id": '',
//         "access_key": "",
//         "target_id": "",
//         "response": "",
//       };
//       await _repo.receiveCommandResponse(data: data).then((response) async {
//         Utils.dismissLoadingDialog();
//         Utils.toastMsg("Command received successfully");
//         Get.back();
//       });
//     } catch (error) {
//       Utils.dismissLoadingDialog();
//       Utils.toastMsg("Error: $error");
//     }
//   }
//
//   Future receiveFileCommandResponse() async {
//     try {
//       Utils.showLoadingDialog('Receiving...');
//       final Map<String, String> params = {
//         'target_id': '',
//         'access_key': '',
//         'command_id': '',
//       };
//       await _repo.receiveFileCommandResponse(params: params, filePath: filePath).then((response) async {
//         Utils.dismissLoadingDialog();
//         Utils.toastMsg("Command received successfully");
//         Get.back();
//       });
//     } catch (error) {
//       Utils.dismissLoadingDialog();
//       Utils.toastMsg("Error: $error");
//     }
//   }
//
// }
