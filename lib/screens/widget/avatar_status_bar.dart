import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AvatarstatusBar extends StatelessWidget {
  final double? size;

  const AvatarstatusBar({
    Key? key,
    this.size = 65,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.black, size: 50),
                );
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const SizedBox.shrink();
              }
              final documents = snapshot.data!.docs;
              return ListView.separated(
                itemCount: documents.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (context, index) => kWidth10,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  final data = document.data();
                  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                  if (document.id == currentUserId) {
                    return const SizedBox.shrink();
                  }
                  final photoUrl = data['photoUrl'];
                  if (photoUrl == null) {
                    return const SizedBox.shrink();
                  }
                  return InkWell(
                    onTap: () {
                      Get.to(() => ProfileScreen(
                            snap: snapshot.data!.docs[index],
                          ));
                    },
                    child: Container(
                      width: size,
                      height: size,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: textGrey),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                snapshot.data!.docs[index]['photoUrl'])),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                  // Avatar(
                  //   image: Image.asset('assets/google_icon.png'),
                  // );
                },
              );
            }),
      ),
    );
  }
}
