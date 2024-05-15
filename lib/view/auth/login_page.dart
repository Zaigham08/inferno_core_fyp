import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/view/auth/register.dart';

import '../../res/widgets/button components/my_text_btn.dart';
import '../../res/widgets/input field components/my_input_field.dart';
import '../../res/widgets/general widgets/rich_texts_link.dart';
import '../../res/constants.dart';
import '../../utils/utils.dart';
import '../../view models/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (_) async {
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  (size.height * 0.12).ph,
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/app_logo.jpg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  20.ph,
                  const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                    ),
                  ),
                  30.ph,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyInputField(
                          hintText: "Email address",
                          width: 450,
                          textColor: blackColor,
                          icon: Icons.email_outlined,
                          controller: loginController.emailController.value,
                          focusNode: loginController.emailFocusNode.value,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required*";
                            } else if (!loginController.isValidEmail(value)) {
                              return 'Email Address not valid';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            Utils.fieldFocusChange(
                                context,
                                loginController.emailFocusNode.value,
                                loginController.passwordFocusNode.value);
                          },
                        ),
                        Obx(
                          () => MyInputField(
                            hintText: "Password",
                            width: 450,
                            textColor: blackColor,
                            icon: Icons.lock_outline,
                            controller:
                                loginController.passwordController.value,
                            focusNode: loginController.passwordFocusNode.value,
                            hidePassword: loginController.hidePassword.value,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required*";
                              }
                              return null;
                            },
                            widget: InkWell(
                              onTap: () {
                                loginController.toggleHidePassword();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(right: 12, left: 2),
                                child: Icon(
                                  loginController.hidePassword.value
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash,
                                  color: Colors.black.withOpacity(.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  25.ph,
                  Obx(
                    () => MyTextButton(
                      text: 'Log In ',
                      width: 450,
                      isLoading: loginController.loading.value,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginController.login();
                        }
                      },
                    ),
                  ),
                  35.ph,
                  RichTextsLink(
                    onPressed: () {
                      Get.to(() => RegisterPage(),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 800));
                    },
                    text1: 'Don\'t have an account? ',
                    text2: 'Sign Up',
                  ),
                  20.ph,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

