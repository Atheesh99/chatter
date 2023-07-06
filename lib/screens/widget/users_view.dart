import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/model/until.dart';
import 'package:chatter/screens/chat_screen/chat_screen.dart';
import 'package:chatter/service/firebase_messeging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:chatter/model/user_model.dart' as model;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserViewPerson extends StatefulWidget {
  const UserViewPerson({
    super.key,
  });

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
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('lastMessageTime', descending: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseApi.getMessages(
                    idUser: snapshot.data!.docs[index]["uid"],
                    recieverId: FirebaseAuth.instance.currentUser!.uid),
                builder: (context, messegeSnapshot) {
                  if (messegeSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          color: Colors.black, size: 20),
                    );
                  }
                  final messages = messegeSnapshot.data!.docs;
                  final lastMessage = messages.isNotEmpty
                      ? messages.first['message']
                      : snapshot.data!.docs[index]['bio'];
                  final lastMessageTime = messages.isNotEmpty
                      ? (messages.first['createdAt'] as Timestamp).toDate()
                      : null;
                  return Slidable(
                    closeOnScroll: true,
                    // key: ValueKey(0),
                    endActionPane: ActionPane(
                      extentRatio: 0.5,
                      motion: const ScrollMotion(),
                      children: [
                        slidableIcon(
                          icon: Icons.notifications_none,
                          onpress: (context) {},
                        ),
                        slidableIcon(
                          icon: Icons.delete,
                          onpress: (context) {
                            // final userId = snapshot.data!.docs[index].id;
                            // FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(userId)
                            //     .delete();
                            setState(() {
                              snapshot.data!.docs.removeAt(index);
                            });
                          },
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
                          padding:
                              const EdgeInsets.only(left: 5, bottom: 5, top: 6),
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
                                      // callID: "",
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
                                    border: Border.all(
                                        width: 2, color: Colors.grey),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                                subtitle: Text(
                                  lastMessage,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                trailing: lastMessageTime != null
                                    ? Text(
                                        Utils.formatDateTime(lastMessageTime),
                                        style: const TextStyle(fontSize: 10),
                                      )
                                    : const Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis),
                                      )),
                          ),
                        ),
                      ],
                    ),
                  );
                });
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
