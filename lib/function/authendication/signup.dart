import 'dart:math';
import 'package:chatter/function/authendication/google_sigin.dart';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatter/model/chatuser.dart' as model;
import 'package:get/get.dart';

// signupfun(
//     {required String username,
//     required String userpassword,
//     required String useremail,
//     String? bio,
//     Uint8List? file}) async {
//   isLoading.value = true;
// // var newIm='assets/avatr_person.png';
//   String res = await AuthMethods().signUpUser(
//     // file: file!,
//     //  bio: bio ?? 'No bio',
//     username: username,
//     email: useremail,
//     password: userpassword,
//   );

//   Get.offAll(() => const Signin(),
//       transition: Transition.circularReveal,
//       duration: const Duration(seconds: 1));
//   isLoading.value = false;
// }

class AuthicationModelEmail {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> emailSignIn(
      {required String username,
      required String email,
      required String password}) async {
    User? currentUser = _firebaseAuth.currentUser;

    //User is already authenticated, return the current user
    if (currentUser != null) {
      return currentUser;
    }
    isLoading.value = true;
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        await _storeUserData(username, email, user.uid);
        Get.offAll(() => const MainScreen(),
            transition: Transition.circularReveal,
            duration: const Duration(seconds: 1));
        isLoading.value = false;
      }
      return user;
    } on FirebaseAuthException catch (e) {
      log('Email Sign-in Error: $e' as num);
      return null;
    }
  }

  Future<void> _storeUserData(String username, String email, String uid) async {
    final userData = model.UserModel(
      username: username,
      email: email,
      uid: uid,
      photoUrl: '',
      lastMessageTime: DateTime.now(),
      status: 'offline',
      provide: 'Email',
    );

    await _firestore.collection('users').doc(uid).set(userData.toJson());
  }
}
