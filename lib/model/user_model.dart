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

  const UserModel(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.lastMessageTime,
      required this.status});

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
        username: data["username"],
        uid: data["uid"],
        email: data["email"],
        photoUrl: data["photoUrl"] ?? 'assets/image/avatr_person.png',
        bio: data["bio"] ?? '',
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
      };
}
