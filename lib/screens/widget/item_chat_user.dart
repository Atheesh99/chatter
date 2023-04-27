import 'package:chatter/const/color.dart';
import 'package:chatter/screens/widget/avatar.dart';
import 'package:flutter/material.dart';

class ItemChatUser extends StatelessWidget {
  const ItemChatUser(
      {Key? key,
      required this.chat,
      this.avatar,
      required this.message,
      this.time})
      : super(key: key);
  final int chat;
  final String? avatar;
  final String message;
  final num? time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment:
            chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          avatar != null
              ? Avatar(
                  image: avatar,
                  size: 55,
                )
              : Text(
                  '$time',
                  style: const TextStyle(color: buttonColor, fontSize: 13),
                ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    chat == 0 ? Colors.indigo.shade100 : Colors.indigo.shade50,
                borderRadius: chat == 0
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
                message,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                    wordSpacing: 0.2,
                    height: 1.3),
              ),
            ),
          ),
          chat == 1
              ? Text(
                  '$time',
                  style: const TextStyle(color: buttonColor, fontSize: 13),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
