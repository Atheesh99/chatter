import 'package:chatter/model/chat_model.dart';
import 'package:chatter/model/until.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  //uploading message to firestore
  static Future uploadMessage({
    required String recieverId,
    required String message,
    required String currentUserId,
    required String recieverAvatharUrl,
    required String recieverUsername,
    // required DateTime createdAt,
  }) async {
    //adding datas to CurrentUser database
    final refMessage = FirebaseFirestore.instance
        .collection('chats')
        .doc(currentUserId)
        .collection('messages')
        .doc(recieverId)
        .collection('chats');

    Message newMessage = Message(
      createdAt: DateTime.now(),
      message: message,
      recieverAvatharUrl: recieverAvatharUrl,
      recieverId: recieverId,
      recieverUsername: recieverUsername,
      senderId: currentUserId,
    );

    await refMessage.add(newMessage.tojson()).then(
      (value) {
        final cRef = FirebaseFirestore.instance
            .collection('chats')
            .doc(currentUserId)
            .collection('messages')
            .doc(recieverId);
        cRef.set({'lastMessage': message});
      },
    );

    //adding datas to reciever's data base
    final recieverRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .doc(currentUserId)
        .collection('chats');
    recieverRef.add(newMessage.tojson()).then(
          (value) => {
            FirebaseFirestore.instance
                .collection('chats')
                .doc(recieverId)
                .collection('messages')
                .doc(currentUserId)
                .set({'lastMessage': message})
          },
        );
    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers.doc(recieverId).update(
      {
        UserField.lastMessageTime: Utils.fromDateTimeToJson(
          DateTime.now(),
        ),
      },
    );
  }

  //fetching messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
          {required String idUser, required String recieverId}) =>
      FirebaseFirestore.instance
          .collection('chats')
          .doc(idUser)
          .collection('messages')
          .doc(recieverId)
          .collection('chats')
          .orderBy('createdAt', descending: true)
          // .orderBy(MessageField.createdAt, descending: true)
          .snapshots();

  Future<void> clearMessages(
      {required String currentuserId, required String reciever}) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(currentuserId)
        .collection('messages')
        .doc(reciever)
        .delete();
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(reciever)
        .collection('messages')
        .doc(currentuserId)
        .delete();
  }
}
