import 'dart:convert';

import 'package:chatter/model/until.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String recieverId;
  final String senderId;
  final String recieverAvatharUrl;
  final String recieverUsername;
  final String message;
  final DateTime createdAt;

  Message({
    required this.recieverId,
    required this.senderId,
    required this.recieverAvatharUrl,
    required this.recieverUsername,
    required this.message,
    required this.createdAt,
  });
  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Message(
        recieverId: data["recieverId"],
        senderId: data["senderId"],
        recieverAvatharUrl: data["recieverAvatharUrl"],
        recieverUsername: data["recieverUsername"],
        message: data["message"],
        createdAt: Utils.toDateTime(
          data['createdAt'],
        ));
  }
  Map<String, dynamic> tojson() => {
        "recieverId": recieverId,
        "senderId": senderId,
        "recieverAvatharUrl": recieverAvatharUrl,
        "recieverUsername": recieverUsername,
        "message": message,
        "createdAt": Utils.fromDateTimeToJson(createdAt),
      };
}

class UserField {
  static const String lastMessageTime = 'lastMessageTime';
}
