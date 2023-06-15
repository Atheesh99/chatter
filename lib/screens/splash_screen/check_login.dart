import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:chatter/screens/onboaring/onboaring_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StateCheckingWidget extends StatelessWidget {
  const StateCheckingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const MainScreen();
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return const OnboardingScreen();
        }));
  }
}
