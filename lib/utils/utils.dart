import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/view%20models/controllers/target_controller.dart';

import '../res/constants.dart';
import '../res/widgets/button components/my_text_btn.dart';
import '../res/widgets/general widgets/text_for_note.dart';
import '../res/widgets/input field components/my_text_input_field.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: toastColor,
      colorText: whiteColor,
      duration: const Duration(seconds: 4),
    );
  }

  static toastMsg(String message, {Color color = toastColor}) {
    Fluttertoast.showToast(
      msg: message,
      textColor: whiteColor,
      backgroundColor: color,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static showLoadingDialog(String message) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 260,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SpinKitCircle(
                  size: 60,
                  color: btnColor,
                ),
                8.ph,
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: txtColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static showSimpleLoading() {
    Get.dialog(
      barrierDismissible: false,
      const Center(
        child: CircularProgressIndicator(
          color: whiteColor,
        ),
      ),
    );
  }

  static void dismissLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back(); // Close the loading dialog
    }
  }

  static showCreateTargetDialog() {
    TargetController targetController = Get.put(TargetController());
    final formKey = GlobalKey<FormState>();
    Get.dialog(
      Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  5.ph,
                  MyTextInputField(
                    title: "Enter name of the target *",
                    hintText: 'Name',
                    controller: targetController.nameController.value,
                    textColor: Colors.black,
                    giveMargin: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required*";
                      }
                      return null;
                    },
                  ),
                  MyTextInputField(
                    title: "Enter user id of the user you want to give access",
                    hintText: 'Enter user id here (Optional)',
                    controller: targetController.accessedUserController.value,
                    textColor: Colors.black,
                  ),
                  MyTextInputField(
                    title: "Select icon for payload",
                    readOnly: true,
                    hintText: 'Select icon (Optional)',
                    controller: TextEditingController(
                      text: targetController.filePath.extractFileName(),
                    ),
                    textColor: Colors.black,
                    widget: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          targetController.pickFile();
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  myTextForNote("Icon should have extension (.ico)"),
                  20.ph,
                  MyTextButton(
                    width: 150,
                    text: 'Create',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        targetController.createTarget();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static showDeleteConfirmationDialog({
    required String title,
    required String text,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    String confirmBtnTxt = 'Delete',
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: txtColor,
                      fontWeight: FontWeight.bold),
                ),
                8.ph,
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: txtColor,
                  ),
                ),
                15.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyTextButton(
                      width: 90,
                      text: 'Cancel',
                      buttonColor: Colors.green.withOpacity(.85),
                      onPressed: onCancel,
                    ),
                    MyTextButton(
                      width: 90,
                      text: confirmBtnTxt,
                      onPressed: onConfirm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
