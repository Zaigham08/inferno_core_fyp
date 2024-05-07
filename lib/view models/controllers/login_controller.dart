import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/user_repository.dart';
import '../../utils/utils.dart';
import '../../view/navbar.dart';
import '../services/google_auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool hidePassword = true.obs;
  RxBool loading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  final _repo = UserRepository();

  void toggleHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  void login() async {
    loading.value = true;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.value.text.trim(),
        password: passwordController.value.text.trim(),
      );
      if (userCredential.user != null) {
        // Reload user information to get the latest email verification status
        await _repo.createUser().then((response) async {
          await userCredential.user!.reload();
          loading.value = false;
          if (userCredential.user!.emailVerified) {
              Get.offAll(() => const NavBar(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 1500));
              Utils.snackBar("Success!", "Login Successfully");
          } else {
            loading.value = false;
            Utils.snackBar(
                "Error", "Please verify your email before logging in.");
          }
        }).onError((error, stackTrace) {
          loading.value = false;
          Utils.toastMsg("error: $error");
        });
      }
    } catch (error) {
      loading.value = false;
      Utils.snackBar("Error", error.toString());
    }
  }

  // void loginWithGoogle() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isFirstTimeUser = prefs.getBool('isFirstTimeUser') ?? true;
  //   Utils.showSimpleLoading();
  //   authService.signInWithGoogle().then((response) async {
  //     if (response != null) {
  //       await _repo.createUser().then((response) async {
  //         final detail = response['detail'];
  //         detail == null
  //             ? Utils.toastMsg("User created Successfully")
  //             : detail == "User already exists"
  //                 ? null
  //                 : Utils.toastMsg(detail);
  //         Utils.dismissLoadingDialog();
  //           Get.offAll(() => const NavBar(),
  //               transition: Transition.rightToLeft,
  //               duration: const Duration(milliseconds: 1500));
  //           Utils.snackBar("Success!", "Login Successfully");
  //       }).onError((error, stackTrace) {
  //         Utils.dismissLoadingDialog();
  //         Utils.toastMsg(error.toString());
  //       });
  //     } else {
  //       Utils.dismissLoadingDialog();
  //       Utils.snackBar("Error", 'Login Failed');
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.dismissLoadingDialog();
  //     Utils.snackBar("Error", error.toString());
  //   });
  // }
}
