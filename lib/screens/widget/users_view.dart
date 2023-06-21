import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:chatter/model/user_model.dart' as model;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserViewPerson extends StatefulWidget {
  const UserViewPerson(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.timeText});
  final String image;
  final String title;
  final String subtitle;
  final String timeText;

  @override
  State<UserViewPerson> createState() => _UserViewPersonState();
}

class _UserViewPersonState extends State<UserViewPerson> {
  int? isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = -1;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: Colors.black, size: 50),
          );
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            // Avoid the signed-in user in this list
            if (snapshot.data!.docs[index].id ==
                FirebaseAuth.instance.currentUser!.uid) {
              return const SizedBox.shrink();
            }
            return Slidable(
              // key: ValueKey(0),
              endActionPane: ActionPane(
                extentRatio: 0.5,
                motion: const ScrollMotion(),

                ///////// delet the item//////  pending //////////////
                // dismissible: DismissiblePane(
                //   onDismissed: () {},
                // ),
                children: [
                  slidableIcon(
                    icon: Icons.notifications_none,
                    onpress: (context) {},
                  ),
                  slidableIcon(
                    icon: Icons.delete,
                    onpress: (context) {},
                  ),
                ],
              ),
              child: Column(
                children: [
                  kHeight10,
                  // const Divider(
                  //   height: 10.0,
                  //   thickness: 0.8,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5, top: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected == index
                            ? sclorColor
                            : Colors.transparent,
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                            () => ChatScreen(
                              snap: model.UserModel.fromSnapshot(
                                snapshot.data!.docs[index],
                              ),
                            ),
                          );
                          setState(
                            () {
                              isSelected = index;
                            },
                          );
                        },
                        minLeadingWidth: 70,
                        leading: Container(
                          width: 65,
                          height: 65,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data!.docs[index]['photoUrl'],
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          snapshot.data!.docs[index]['username'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        subtitle: Text(
                          snapshot.data!.docs[index]['bio'],
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        trailing: Text(
                          widget.timeText,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  slidableIcon(
      {required IconData icon, required Function(BuildContext)? onpress}) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 82,
      width: 100,
      child: SlidableAction(
        autoClose: true,
        flex: 1,
        onPressed: onpress,
        backgroundColor: sclorColor,
        icon: icon,
      ),
    );
  }
}
