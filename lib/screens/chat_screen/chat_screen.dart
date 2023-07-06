import 'dart:developer';

import 'package:chatter/const/color.dart';
import 'package:chatter/const/config.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/controllers/get_user_controller.dart';
import 'package:chatter/model/call_model.dart';

import 'package:chatter/model/user_model.dart';
import 'package:chatter/screens/widget/chat_text_field.dart';
import 'package:chatter/screens/widget/item_chat_user.dart';
import 'package:chatter/service/call_servic.dart';
import 'package:chatter/service/firebase_messeging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:provider/provider.dart';
import 'package:chatter/model/chat_model.dart' as model;
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ChatScreen extends StatefulWidget {
  final UserModel snap;
  // final String callID;
  // final String idUser;
  // final DocumentSnapshot receiver;
  const ChatScreen({
    super.key,
    // required this.callID,
    // required this.receiver,
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
    log(FirebaseAuth.instance.currentUser!.displayName.toString());
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.getUser;
    if (user == null) {
      return Scaffold(
        backgroundColor: backgroundBlack,
        body: Center(
          child:
              LoadingAnimationWidget.discreteCircle(color: textWhite, size: 50),
        ),
      );
    }

    // final callInvitationController = ZegoUIKitPrebuiltCallController();
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: appID,
      appSign: appSign,
      userID: user.uid,
      userName: user.username,
      notifyWhenAppRunningInBackgroundOrQuit: true,
      plugins: [ZegoUIKitSignalingPlugin()],
      showDeclineButton: true,
      // controller: callInvitationController,
      isIOSSandboxEnvironment: false,
      ringtoneConfig: const ZegoRingtoneConfig(
        incomingCallPath: "assets/audio/mobile caller tone.mp3",
        outgoingCallPath: "assets/audio/Oppo Caller tone.mp3",
      ),
    );

    return StreamBuilder(
        stream: FirebaseApi.getMessages(
            idUser: user.uid, recieverId: widget.snap.uid),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.black, size: 50),
            );
          }

          return Scaffold(
            backgroundColor: backgroundBlack,
            body: SafeArea(
              child: Column(
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
                      const Spacer(),
                      actionButton(false, user),
                      actionButton(true, user),
                      kWidth10,
                    ],
                  ),
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
                            snapshot.data!.docs[index],
                          );

                          return snapshot.data!.docs.isEmpty
                              ? const Center(
                                  child: Text(
                                    ('Say Hi.........!'),
                                    style: TextStyle(
                                        fontSize: 24, color: textBlack),
                                  ),
                                )
                              : ItemChatUser(
                                  message: messagessnap,
                                  isMe: messagessnap.senderId == user.uid,
                                );
                        },
                      ),
                    ),
                  ),
                  ChatTextField(currentUser: user, snap: widget.snap),
                ],
              ),
            ),
          );
        });
  }

  ZegoSendCallInvitationButton actionButton(bool isVideo, UserModel user) {
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideo,
      notificationMessage:
          isVideo ? 'Incoming video call' : 'Incoming voice call',
      notificationTitle: widget.snap.username,
      iconTextSpacing: -30,
      iconSize: const Size(45, 45),
      callID: '12',
      invitees: [
        ZegoUIKitUser(id: widget.snap.uid, name: widget.snap.username)
      ],
      onPressed: (code, message, p2) async {
        CallService callService = CallService();
        CallType callType = isVideo ? CallType.incoming : CallType.outgoing;
        await callService.createCallModel(callType, isVideo, user,
            widget.snap.uid, widget.snap.photoUrl, widget.snap.username);
      },
    );
  }
}
