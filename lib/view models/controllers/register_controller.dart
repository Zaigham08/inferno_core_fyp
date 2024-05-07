import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../repository/user_repository.dart';
import '../../utils/utils.dart';
import '../../view/auth/login_page.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool hidePassword = true.obs;
  RxBool loading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _repo = UserRepository();

  void toggleHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  void signUp() {
    loading.value = true;
    _auth.createUserWithEmailAndPassword(
      email: emailController.value.text.trim(),
      password: passwordController.value.text.trim(),
    ).then((userCredential) async {
      await _repo.createUser();
      await userCredential.user!.sendEmailVerification().then((_) {
        Utils.toastMsg("User Signed Up Successfully.");
        Utils.snackBar("Message",
            "A verification email has been sent. Please verify your email.");
        loading.value = false;
        Get.to(LoginPage(),
            transition: Transition.downToUp,
            duration: const Duration(seconds: 1));
      }).catchError((error) {
        loading.value = false;
        Utils.snackBar("Error", error.toString());
      });
    }).catchError((error) {
      loading.value = false;
      Utils.snackBar("Error", error.toString());
    });
  }
}
