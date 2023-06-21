import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.black, size: 50),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (context, index) => kWidth10,
                itemBuilder: (context, index) {
                  if (snapshot.data!.docs[index].id ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return const SizedBox.shrink();
                  }
                  ///////////////////////////// pending//////////////////////////////
                  return Container(
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
