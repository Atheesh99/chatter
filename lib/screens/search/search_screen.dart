import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:chatter/model/user_model.dart' as model;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String text = "";
  List<String> selectedUserIds = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                style: const TextStyle(
                    color: textWhite, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 88, 82, 82),
                  contentPadding: const EdgeInsets.all(8),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),
            kHeight30,
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .orderBy('lastMessageTime', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: Colors.white,
                        size: 50,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                        filteredUsers = snapshot.data!.docs.where((user) {
                      final String username =
                          user.data()['username']?.toString() ?? '';
                      return username
                          .toLowerCase()
                          .contains(text.toLowerCase());
                    }).toList();
                    final currentUserID =
                        FirebaseAuth.instance.currentUser!.uid;
                    filteredUsers
                        .removeWhere((user) => user.id == currentUserID);

                    return ListView.separated(
                      separatorBuilder: (context, index) => kHeight10,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        var data = filteredUsers[index].data();

                        return ListTile(
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
                                  data['photoUrl'],
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            data['username'],
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),

                          subtitle: Text(
                            data['bio'],
                            style: const TextStyle(
                              letterSpacing: 0.5,
                              fontSize: 13,
                              color: textGrey,
                            ),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     setState(() {});
                          //   },
                          //   icon: Icon(
                          //     Icons.close,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          onTap: () {
                            Get.to(
                              () => ChatScreen(
                                // callID: "",
                                snap: model.UserModel.fromSnapshot(
                                  filteredUsers[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
