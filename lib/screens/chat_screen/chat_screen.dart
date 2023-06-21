import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/get_user_controller.dart';
import 'package:chatter/model/user_model.dart';
import 'package:chatter/screens/widget/chat_text_field.dart';
import 'package:chatter/screens/widget/item_chat_user.dart';
import 'package:chatter/screens/widget/search.dart';
import 'package:chatter/service/firebase_messeging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:chatter/model/chat_model.dart' as model;

class ChatScreen extends StatefulWidget {
  final UserModel snap;

  const ChatScreen({
    super.key,
    required this.snap,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: backgroundBlack,
      body: StreamBuilder(
          stream: FirebaseApi.getMessages(
            idUser: currentUser.uid,
            recieverId: widget.snap.uid,
          ),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                    color: Colors.black, size: 50),
              );
            }
            return SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 10, left: 20),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 25,
                                color: textWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 210),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            ///// pending///////
                            SearchIcon(
                                icon: Icons.local_phone_outlined, size: 25),
                            kWidth20,
                            SearchIcon(icon: Icons.videocam_outlined, size: 25),
                          ],
                        ),
                      ),
                      kHeight20,
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          widget.snap.username.toUpperCase(),
                          style: GoogleFonts.frankRuhlLibre(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: textWhite),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      kHeight20,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: textWhite,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final messagessnap = model.Message.fromSnapshot(
                                  snapshot.data!.docs[index]);

                              // children: const [
                              //   ItemChatUser(
                              //       chat: 1,
                              //       avatar:
                              //          'assets/chat_icon-removebg-preview.png',
                              //       message:
                              //           'It has survived not only five centuries. it is very beautyful i like it very much, 😀',
                              //       time: 18.00),
                              // ],
                              return snapshot.data!.docs.isEmpty
                                  ? const Center(
                                      child: Text(
                                        ('Say Hi.........!'),
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    )
                                  : ItemChatUser(
                                      message: messagessnap,
                                      isMe: messagessnap.senderId ==
                                          currentUser.uid,
                                      avatar:
                                          'assets/chat_icon-removebg-preview.png',
                                      // time: messagessnap.createdAt.toString(),
                                    );
                            },
                          ),
                        ),
                      ),
                      ChatTextField(
                          currentUser: currentUser, snap: widget.snap),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class ChatPageArguments {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;

  ChatPageArguments(
      {required this.peerId,
      required this.peerAvatar,
      required this.peerNickname});
}
