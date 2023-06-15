import 'package:chatter/model/until.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;

  final DateTime? lastMessageTime;
  final String status;
  final String provide;

  const UserModel(
      {required this.username,
      required this.uid,
      this.photoUrl = 'assets/avatr_person.png',
      required this.email,
      this.bio = 'chat with your friends',
      required this.provide,
      this.lastMessageTime,
      this.status = ''});

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
        username: data["username"],
        uid: data["uid"],
        email: data["email"],
        photoUrl: data["photoUrl"] ?? 'assets/avatr_person.png',
        provide: data['provide'] ?? '',
        bio: data["bio"] ?? 'Chat with your friend',
        lastMessageTime: Utils.toDateTime(data['lastMessageTime']),
        status: data['status'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
        'status': status,
        'provide': provide,
      };
}
