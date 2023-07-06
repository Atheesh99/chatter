import 'package:chatter/model/until.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DateTime createdAt;
  final String message;
  final String recieverAvatharUrl;
  final String recieverId;
  final String recieverUsername;
  final String senderId;

  Message({
    required this.createdAt,
    required this.message,
    required this.recieverAvatharUrl,
    required this.recieverId,
    required this.recieverUsername,
    required this.senderId,
  });
  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Message(
      createdAt: Utils.toDateTime(data['createdAt']),
      message: data["message"],
      recieverAvatharUrl: data["recieverAvatharUrl"],
      recieverId: data["recieverId"],
      recieverUsername: data["recieverUsername"],
      senderId: data["senderId"],
    );
  }
  Map<String, dynamic> tojson() => {
        "createdAt": Utils.fromDateTimeToJson(createdAt),
        "message": message,
        "recieverAvatharUrl": recieverAvatharUrl,
        "recieverId": recieverId,
        "recieverUsername": recieverUsername,
        "senderId": senderId,
      };
}

class UserField {
  static const String lastMessageTime = 'lastMessageTime';
}
