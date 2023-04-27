import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/widget/chat_text_field.dart';
import 'package:chatter/screens/widget/item_chat_user.dart';
import 'package:chatter/screens/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 35, left: 30),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: textWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 210),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ///// pending///////
                          SearchIcon(
                              icon: Icons.local_phone_outlined, size: 25),
                          kWidth20,
                          SearchIcon(icon: Icons.videocam_outlined, size: 25),
                        ],
                      ),
                    ),
                  ],
                ),
                kHeight20,
                userName('Antony Arakal'),
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
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        ItemChatUser(
                            chat: 1,
                            avatar: 'assets/chat_icon-removebg-preview.png',
                            message:
                                'It has survived not only five centuries. it is very beautyful i like it very much, 😀',
                            time: 18.00),
                        ItemChatUser(
                            chat: 0,
                            message:
                                'It has survived not only five centuries. it is very beautyful i like it very much, 😀',
                            time: 1.50),
                        ItemChatUser(
                            chat: 1,
                            avatar: 'assets/chat_icon-removebg-preview.png',
                            message:
                                'It has survived not only five centuries. it is very beautyful i like it very much, 😀',
                            time: 18.00),
                        ItemChatUser(
                            chat: 0,
                            message:
                                'It has survived not only five centuries. it is very beautyful i like it very much, 😀',
                            time: 18.30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const ChatTextField()
          ],
        ),
      ),
    );
  }

  Padding userName(name) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Text(
        name,
        style: GoogleFonts.frankRuhlLibre(
            fontSize: 26, fontWeight: FontWeight.bold, color: textWhite),
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
