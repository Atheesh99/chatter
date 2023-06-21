import 'package:chatter/const/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class ProfileHome extends StatelessWidget {
  const ProfileHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.black, size: 50),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: size.height * 0.07,
              width: size.width * 0.16,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: textWhite),
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  snapshot.data!['photoUrl'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }
}
