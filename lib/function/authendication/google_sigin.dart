import 'dart:developer';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatter/model/user_model.dart' as model;

var isLoading = false.obs;

class AuthServiceGoogle {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signinwithgoogle() async {
    isLoading.value = true;

    try {
      final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleauth =
          await googleuser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken,
        idToken: googleauth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        model.UserModel _user = model.UserModel(
          bio: '',
          email: user.email ?? '',
          lastMessageTime: DateTime.now(),
          photoUrl: user.photoURL ?? '',
          status: '',
          uid: user.uid,
          username: user.displayName ?? '',
        );
        await _firestore.collection("users").doc(user.uid).set(_user.toJson());

        Get.offAll(() => const MainScreen(),
            transition: Transition.circularReveal,
            duration: const Duration(seconds: 1));
        isLoading.value = false;
      }
      return user;
    } on FirebaseAuthException catch (e) {
      log('Google Sign-in error: $e');
      return null;
    }
  }
}
