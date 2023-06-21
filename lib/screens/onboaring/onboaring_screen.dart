import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/function/authendication/google_sigin.dart';
import 'package:chatter/screens/login/login_screen.dart';
import 'package:chatter/screens/signin/signin_screen.dart';
import 'package:chatter/screens/widget/already_password.dart';
import 'package:chatter/screens/widget/button.dart';
import 'package:chatter/screens/widget/divider_or_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: onboardBackgroundcolor,
            stops: <double>[0.005, 0.05, 1],
          ),
        ),
        child: Column(
          children: [
            kHeight20,
            onboardIconandText(),
            kHeight20,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Connect \nfriends \neasily & \nquickly..',
                style: TextStyle(
                    color: textWhite,
                    fontSize: 60,
                    fontWeight: FontWeight.w800,
                    wordSpacing: -1,
                    letterSpacing: 2),
              ),
            ),
            kHeight20,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Connect with friends and family.',
                style: TextStyle(
                    color: textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            kHeight40,
            Obx(
              () => isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          color: Colors.white, size: 50),
                    )
                  : GestureDetector(
                      onTap: () {
                        AuthServiceGoogle authService = AuthServiceGoogle();
                        authService.signinwithgoogle();
                      },
                      child: Button(
                          text: 'Sign up with google',
                          image: Image.asset('assets/google_icon.png',
                              fit: BoxFit.contain),
                          size: 15),
                    ),
            ),
            kHeight40,
            const DividerOrDivider(color: textWhite),
            kHeight40,
            GestureDetector(
              onTap: () {
                Get.to(() => const SignInScreen());
              },
              child: Button(
                  text: 'Sign up with mail',
                  image:
                      Image.asset('assets/mail_icon.png', fit: BoxFit.contain),
                  size: 15),
            ),
            kHeight40,
            GestureDetector(
              onTap: () {
                Get.to(() => const LoginScreen());
              },
              child: const AlreadyAccountLogin(
                  text: 'Existing Account ? ',
                  title: ' Login',
                  color1: textGrey,
                  color2: textWhite),
            ),
          ],
        ),
      ),
    );
  }

  Row onboardIconandText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(25), // Image radius
            child: Image.network(
                'https://img.freepik.com/premium-photo/blue-neon-bubble-speak-dark-background-3d-illustration_356060-3922.jpg',
                fit: BoxFit.cover),
          ),
        ),
        kWidth20,
        Text(
          'Chatter',
          style: GoogleFonts.festive(
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: textWhite,
              letterSpacing: 2),
        )
      ],
    );
  }
}
