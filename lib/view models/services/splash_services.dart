import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/view/auth/login_page.dart';
import 'package:inferno_core_fyp/view/navbar.dart';

class SplashServices {

  void isLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null && user.emailVerified){
      Timer(
        const Duration(seconds: 2),
            () => Get.offAll(()=> const NavBar()),
      );
    }
    else{
      Timer(
        const Duration(seconds: 2),
        () => Get.offAll(()=>LoginPage()),
      );
    }
  }

  bool isUserLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user == null){
      return false;
    }
    else{
      return true;
    }
  }

}
