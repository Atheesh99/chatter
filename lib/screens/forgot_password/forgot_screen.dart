import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/login/login_screen.dart';
import 'package:chatter/screens/widget/custom_form_field.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.signupformkey,
                  child: CustomformField(
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
                ),
                kHeight30,
                const SiginAndLoginBUtton(
                  text: 'Forgot Password',
                  size: 18,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
