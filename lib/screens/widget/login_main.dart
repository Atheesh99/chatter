import 'package:chatter/const/color.dart';
import 'package:chatter/screens/login/login_screen.dart';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const SingleChildScrollView(
                child: LoginScreen(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error Occured"),
              );
              // ignore: unnecessary_null_comparison
            } else if (snapshot.data != null || snapshot.data!.uid != null) {
              return const MainScreen();
            } else {
              return const SingleChildScrollView(
                child: LoginScreen(),
              );
            }
          }),
    );
  }
}
