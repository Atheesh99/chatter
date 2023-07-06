import 'package:chatter/const/color.dart';
import 'package:chatter/model/chat_model.dart';
import 'package:chatter/model/until.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemChatUser extends StatelessWidget {
  ItemChatUser({
    Key? key,
    //required this.chat,
    // this.avatar,
    required this.message,
    required this.isMe,
  }) : super(key: key);

//final String? avatar;
  final Message message;
  // final String? time;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          !isMe
              ? Text(
                  Utils.formatDateTime(message.createdAt),
                  style: const TextStyle(color: buttonColor, fontSize: 9),
                )
              : const SizedBox(),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isMe ? Colors.indigo.shade100 : Colors.indigo.shade50,
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                    wordSpacing: 0.2,
                    height: 1.3),
              ),
            ),
          ),
          //  chat == 1
          isMe
              ? Text(
                  Utils.formatDateTime(message.createdAt),
                  style: const TextStyle(color: buttonColor, fontSize: 9),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
