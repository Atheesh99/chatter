// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// signupUser({
//   required String username,
//   required String email,
//   required String image,
//   required String provider,
//   required String uid,
// }) async {
//   final User? userid = FirebaseAuth.instance.currentUser;

//   try {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(uid)
//         .collection('userdetails')
//         .doc('userdetails')
//         .set({
//       'username': username,
//       'userEmail': email,
//       'createdAt': DateTime.now(),
//       'uid': userid!.uid,
//       'image': image,
//       'provider': 'GOOGLE',
//     }).then((value) => (value) {
//               FirebaseAuth.instance.signOut();
//             });
//   } on FirebaseAuthException catch (e) {
//     log("Error $e");
//   }
// }
