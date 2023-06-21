import 'dart:developer';

import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/form_validation.dart';
import 'package:chatter/function/authendication/signup.dart';
import 'package:chatter/function/image_picker.dart';
import 'package:chatter/screens/forgot_password/forgot_screen.dart';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:chatter/screens/signin/signin_screen.dart';
import 'package:chatter/screens/widget/custom_form_field.dart';
import 'package:chatter/screens/widget/divider_or_divider.dart';
import 'package:chatter/screens/widget/image_login_text.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormValidationLginAndSignup());
    return Scaffold(
      backgroundColor: backgroundwhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, top: 20),
          child: Column(
            children: [
              const ImageLoginText(
                  height: 0.41,
                  imagepath: "assets/login_img.jpg",
                  text: 'Login',
                  title: 'Please signin to continue'),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  children: [
                    CustomformField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      onSave: (value) {
                        controller.email = value!.trim();
                      },
                      validator: (value) {
                        return controller.validateEmail(value!);
                      },
                      hide: false,
                      text: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                    ),
                    kHeight20,
                    Obx(
                      () => CustomformField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        onSave: (value) {
                          controller.password = value!;
                        },
                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
                        ontap: () {
                          controller.isPasswordVisibility.value =
                              !controller.isPasswordVisibility.value;
                        },
                        hide: controller.isPasswordVisibility.value,
                        text: 'Password',
                        prefixIcon: Icons.lock_outlined,
                        suffixIcon1: Icons.visibility_off_rounded,
                        suffixIcon2: Icons.visibility_outlined,
                      ),
                    ),
                    kHeight30,
                    _isLoading
                        ? Center(
                            child: LoadingAnimationWidget.discreteCircle(
                                color: Colors.black, size: 30),
                          )
                        : GestureDetector(
                            onTap: loginUser,
                            //controller.validateForm;

                            child: const SiginAndLoginBUtton(
                              text: 'Login',
                              size: 20,
                            ),
                          ),
                    kHeight20,
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ForgotPasswordScreen());
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

  void loginUser() async {
    // log('Login function calling');
    setState(() {
      _isLoading = true;
    });

    String res =
        await AuthMethods().loginUser(email: email, password: password);
    log('$email  .... $password');
    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Get.offAll(() => const MainScreen());
    } else {
      showSnackBar(context, res);
    }
  }
}
