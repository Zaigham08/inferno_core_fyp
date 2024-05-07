import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/view/auth/login_page.dart';

import '../../res/widgets/button components/my_text_btn.dart';
import '../../res/widgets/input field components/my_input_field.dart';
import '../../res/widgets/general widgets/rich_texts_link.dart';
import '../../res/constants.dart';
import '../../utils/utils.dart';
import '../../view models/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  final registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                (size.height * 0.23).ph,
                const Center(
                  child: Text(
                    'Hey There !',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                    ),
                  ),
                ),
                8.ph,
                Text(
                  'Let\'s get started',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                    color: txtColor.withOpacity(0.85),
                  ),
                ),
                36.ph,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyInputField(
                        hintText: "Email address",
                        width: 450,
                        textColor: blackColor,
                        icon: Icons.email_outlined,
                        controller: registerController.emailController.value,
                        focusNode: registerController.emailFocusNode.value,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required*";
                          } else if (!registerController.isValidEmail(value)) {
                            return 'email address not valid';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          Utils.fieldFocusChange(
                              context,
                              registerController.emailFocusNode.value,
                              registerController.passwordFocusNode.value);
                        },
                      ),
                      Obx(
                        () => MyInputField(
                          hintText: "Password",
                          width: 450,
                          textColor: blackColor,
                          icon: Icons.lock_outline,
                          textCapitalization: TextCapitalization.none,
                          controller:
                              registerController.passwordController.value,
                          focusNode: registerController.passwordFocusNode.value,
                          hidePassword: registerController.hidePassword.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required*";
                            }
                            return null;
                          },
                          widget: InkWell(
                            onTap: () {
                              registerController.toggleHidePassword();
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(right: 12, left: 2),
                              child: Icon(
                                registerController.hidePassword.value
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
                30.ph,
                Obx(
                  () => MyTextButton(
                    text: 'Register',
                    width: 450,
                    isLoading: registerController.loading.value,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registerController.signUp();
                      }
                    },
                  ),
                ),
                35.ph,
                RichTextsLink(
                  onPressed: () {
                    Get.to(()=> LoginPage(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 800));
                  },
                  text1: 'Already have an account? ',
                  text2: 'Login',
                ),
                20.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
