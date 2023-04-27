import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/form_validation.dart';
import 'package:chatter/screens/main_screen/main_screen.dart';

import 'package:chatter/screens/widget/already_password.dart';
import 'package:chatter/screens/widget/custom_form_field.dart';
import 'package:chatter/screens/widget/image_login_text.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final controller = Get.put(FormValidationLginAndSignup());

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cntrl = Get.put(FormValidationLginAndSignup());
    return Scaffold(
      backgroundColor: backgroundwhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 20),
          child: Column(
            children: [
              const ImageLoginText(
                  imagepath: 'assets/signup_img.jpg',
                  text: 'Register',
                  title: 'Please register to login'),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.signupformkey,
                child: Column(
                  children: [
                    CustomformField(
                      onSave: (value) {
                        controller.username = value!;
                      },
                      validator: (value) {
                        return controller.validateUsername(value!);
                      },
                      hide: false,
                      text: 'User Name',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person_outline_outlined,
                      controller: controller.usernamecontroller,
                    ),
                    kHeight20,
                    CustomformField(
                      onSave: (value) {
                        controller.email = value!;
                      },
                      validator: (value) {
                        return controller.validateEmail(value!);
                      },
                      hide: false,
                      text: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      controller: controller.emailcontroller,
                    ),
                    kHeight20,
                    Obx(
                      () => CustomformField(
                        onSave: (value) {
                          controller.password = value!;
                        },
                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
                        ontap: () {
                          cntrl.isPasswordVisibility.value =
                              !cntrl.isPasswordVisibility.value;
                        },
                        hide: cntrl.isPasswordVisibility.value,
                        text: 'Password',
                        suffixIcon1: Icons.visibility_off_rounded,
                        suffixIcon2: Icons.visibility_outlined,
                        prefixIcon: Icons.lock_outlined,
                        controller: controller.passwordcontroller,
                      ),
                    ),
                    kHeight30,
                    ///////////////pending
                    GestureDetector(
                      onTap: () {
                        controller.checkSignup();

                        Get.to(() => const MainScreen());
                      },
                      child: const SiginAndLoginBUtton(
                        text: 'Create an account',
                        size: 18,
                      ),
                    ),
                    kHeight30,
                    const AlreadyAccountLogin(
                        text: 'Already have an account ? ',
                        title: 'Login',
                        color1: textBlack,
                        color2: textBlack)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
