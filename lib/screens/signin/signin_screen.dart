import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/form_validation.dart';
import 'package:chatter/function/authendication/google_sigin.dart';
import 'package:chatter/function/authendication/signup.dart';
import 'package:chatter/screens/widget/already_password.dart';
import 'package:chatter/screens/widget/custom_form_field.dart';
import 'package:chatter/screens/widget/image_login_text.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  //final User? currentuser = FirebaseAuth.instance.currentUser;

  final controller = Get.put(FormValidationLginAndSignup());
  @override
  Widget build(BuildContext context) {
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
                        controller.email = value!.trim();
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
                          controller.isPasswordVisibility.value =
                              !controller.isPasswordVisibility.value;
                        },
                        hide: controller.isPasswordVisibility.value,
                        text: 'Password',
                        suffixIcon1: Icons.visibility_off_rounded,
                        suffixIcon2: Icons.visibility_outlined,
                        prefixIcon: Icons.lock_outlined,
                        controller: controller.passwordcontroller,
                      ),
                    ),
                    kHeight30,
                    Obx(
                      () => isLoading.value
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () async {
                                controller.checkSignup();
                                // await signupfun(
                                //   username: controller.password,
                                //   useremail: controller.email,
                                //   userpassword: controller.password,
                                // );
                                AuthicationModelEmail authicationmodelemail =
                                    AuthicationModelEmail();
                                await authicationmodelemail.emailSignIn(
                                    username: controller.username,
                                    email: controller.email,
                                    password: controller.password);
                              },
                              child: const SiginAndLoginBUtton(
                                text: 'Create an account',
                                size: 18,
                              ),
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
