// ignore_for_file: dead_code

import 'dart:developer';

import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/form_validation.dart';
import 'package:chatter/function/authendication/google_sigin.dart';
import 'package:chatter/screens/login/login_screen.dart';
import 'package:chatter/screens/widget/custom_form_field.dart';
import 'package:chatter/screens/widget/login_main.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController forgotPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormValidationLginAndSignup());
    bool _isLoading = false;

    return Scaffold(
      backgroundColor: backgroundwhite,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(65), // Image radius
                    child: Image.asset('assets/chatapp icon.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                kHeight10,
                Text(
                  'Rest Your Password',
                  style: GoogleFonts.frankRuhlLibre(
                      fontSize: 28,
                      color: textBlack,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      wordSpacing: 1),
                ),
                kHeight30,
                Text(
                  'Enter the email associated with \nyour account and we’ll send an \nemail with instructions to reset \nyour password.',
                  style: GoogleFonts.frankRuhlLibre(
                      fontSize: 20,
                      color: textBlack,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                      wordSpacing: 1),
                ),
                kHeight40,
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
                  controller: forgotPasswordController,
                ),
                kHeight30,
                _isLoading
                    ? Center(
                        child: LoadingAnimationWidget.discreteCircle(
                            color: Colors.black, size: 50),
                      )
                    : GestureDetector(
                        onTap: () async {
                          var forgotEmail =
                              forgotPasswordController.text.trim();
                          setState(() {
                            _isLoading = true;
                          });

                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: forgotEmail)
                                .then((value) {
                              log('Email send');
                              Get.off(() => const LoginScreen());
                            });
                          } on FirebaseAuthException catch (e) {
                            log('Reset Password Error: $e');
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: const SiginAndLoginBUtton(
                          text: 'Forgot Password',
                          size: 18,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
