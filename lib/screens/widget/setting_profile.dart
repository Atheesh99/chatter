import 'package:chatter/const/color.dart';
import 'package:chatter/screens/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Settingprofile extends StatelessWidget {
  const Settingprofile({super.key});

  @override
  Widget build(BuildContext context) {
    // final currentUser = FirebaseAuth.instance.currentUser;
    // final userRef =
    //     FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
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
        return ListTile(
          onTap: () {
            Get.to(() => ProfileScreen(snap: snapshot.data));
          },
          leading: Container(
            width: 60,
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: textWhite),
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  snapshot.data!['photoUrl'],
                  fit: BoxFit.cover,
                )),
          ),
          title: Text(
            snapshot.data!["username"] ?? "",
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            snapshot.data!["bio"] ?? "Chat with your Friends....😜",
            style: const TextStyle(fontSize: 12.4, letterSpacing: 0.5),
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        );
      },
    );
  }
}
