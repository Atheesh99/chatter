import 'dart:developer';
import 'package:chatter/screens/main_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatter/model/chatuser.dart' as model;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithCredential(credential);
      // final User userCredential =
      //     (await _auth.signInWithCredential(credential)).user!;

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // final username = userCredential.displayName;
      // final email = userCredential.email;
      // final uid = userCredential.uid;

      // final imaphotoUrl = userCredential.photoURL;
      // await signupUser(
      //   provider: 'GOOGLE',
      //   uid: uid,
      //   image: imaphotoUrl ??
      //       'https://thumbs.dreamstime.com/z/businessman-icon-image-male-avatar-profile-vector-glasses-beard-hairstyle-179728610.jpg',
      //   username: username ?? 'No username',
      //   email: email.toString(),
      // );

      // ignore: unnecessary_null_comparison
      if (user != null) {
        await _storeUserData(user);
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

  // Future<model.UserModel> createNewUserInFirestore() async {
  //   User currentUser = _auth.currentUser!;
  //   DocumentSnapshot documentSnapshot =
  //       await _firestore.collection('users').doc(currentUser.uid).get();

  //   if (documentSnapshot.exists) {
  //     return model.UserModel.fromSnapshot(documentSnapshot);
  //   } else {
  //     model.UserModel newUser = model.UserModel(
  //       provide: "Google",
  //       photoUrl: currentUser.photoURL!,
  //       username: currentUser.displayName!,
  //       uid: currentUser.uid,
  //       email: currentUser.email!,
  //       lastMessageTime: DateTime.now(),
  //       status: 'offline',
  //     );
  //     await _firestore
  //         .collection('users')
  //         .doc(currentUser.uid)
  //         .set(newUser.toJson());

  //     return newUser;
  //   }
  // }
  Future<void> _storeUserData(User user) async {
    final userData = model.UserModel(
      username: user.displayName ?? '',
      email: user.email ?? '',
      uid: user.uid,
      photoUrl: user.photoURL ?? '',
      lastMessageTime: DateTime.now(),
      status: 'offline',
      provide: 'Google',
    );

    await _firestore.collection('users').doc(user.uid).set(userData.toJson());
  }
}
