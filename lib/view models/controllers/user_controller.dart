import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../repository/user_repository.dart';
import '../../utils/utils.dart';

class UserController extends GetxController {
  final _repo = UserRepository();
  final userNameController = TextEditingController().obs;

  RxBool loading = false.obs;
  RxString userId = ''.obs, userEmail = ''.obs;

  Future<void> fetchUserData() async {
    try {
      final Map<String, dynamic> data = await _repo.getUser();
      final UserModel userModel = UserModel.fromJson(data);
      userEmail.value = userModel.email;
      userId.value = userModel.userId;
    } catch (error) {
      // Utils.toastMsg("Error: $error");
      debugPrint(error.toString());
    }
  }

  Future deleteUser() async {
    try {
      Utils.showLoadingDialog('Deleting...');
      await _repo.deleteUser().then((response) {
        Utils.dismissLoadingDialog();
        if (response['detail'] != null) {
          Utils.toastMsg(response['detail']);
        } else {
          Utils.toastMsg("User deleted successfully");
          Get.back();
        }
      });
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.toastMsg("Error: $error");
    }
  }
}
