import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/form_validation.dart';
import 'package:chatter/screens/forgot_password/forgot_screen.dart';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:chatter/screens/signin/signin_screen.dart';
import 'package:chatter/screens/widget/custom_form_field.dart';
import 'package:chatter/screens/widget/divider_or_divider.dart';
import 'package:chatter/screens/widget/image_login_text.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final controller = Get.put(FormValidationLginAndSignup());

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  imagepath: "assets/login_img.jpg",
                  text: 'Login',
                  title: 'Please signin to continue'),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    CustomformField(
                      hide: false,
                      onSave: (value) {
                        controller.username = value!;
                      },
                      validator: (value) {
                        return controller.validateUsername(value!);
                      },
                      text: 'User Name',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person_outline_outlined,
                      controller: controller.usernamecontroller,
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
                        prefixIcon: Icons.lock_outlined,
                        suffixIcon1: Icons.visibility_off_rounded,
                        suffixIcon2: Icons.visibility_outlined,
                        controller: controller.passwordcontroller,
                      ),
                    ),
                    kHeight30,
                    ////////////////////pending
                    GestureDetector(
                      onTap: () {
                        controller.checkLogin();
                        Get.to(() => const MainScreen());
                      },
                      child: const SiginAndLoginBUtton(
                        text: 'Login',
                        size: 20,
                      ),
                    ),
                    kHeight20,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPasswordScreen());
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                    kHeight20,
                    const DividerOrDivider(color: textBlack),
                    kHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account ?",
                          style: TextStyle(color: textBlack, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Get.to(() => const SignInScreen());
                          }),
                          child: const Text(
                            "  SignUp",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
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
