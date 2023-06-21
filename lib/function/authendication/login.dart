import 'dart:math';
import 'package:chatter/function/authendication/google_sigin.dart';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:chatter/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// loginUser({required String email, required String password}) async {
//   String res = await AuthMethods().loginUser(
//     email: email,
//     password: password,
//   );
//   Get.offAll(() => const MainScreen(),
//       transition: Transition.circularReveal,
//       duration: const Duration(seconds: 1));
//   isLoading.value = false;
// }
// class AuthenticationModelEmail {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<User?> loginUser(
//       {required String email, required String password}) async {
//     isLoading.value = true;
//     try {
//       final UserCredential userCredential =
//           await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final User? user = userCredential.user;
//       if (user != null) {
//         Get.offAll(
//             () =>
//                 const ProfileScreen(), ////////////////////////////////////////
//             transition: Transition.circularReveal,
//             duration: const Duration(seconds: 1));

//         isLoading.value = false;
//         return user;
//       }
//       return null;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'wrong-password') {
//         // Password is incorrect, show error message
//         Get.snackbar('Login Error', 'Incorrect password');
//       } else {
//         // Other FirebaseAuthException, show generic error message
//         Get.snackbar('Login Error', 'An error occurred during login');
//       }
//       log('Email Sign-in Error: $e' as num);
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
// }
