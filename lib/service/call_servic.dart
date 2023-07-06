import 'dart:developer';
import 'package:chatter/model/call_model.dart';
import 'package:chatter/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CallService {
  // Method to create a new CallModel instance and store it in Firestore
  Future<void> createCallModel(
    CallType callType,
    bool isVideoCall,
    UserModel user,
    String receiver,
    String image,
    String name,
  ) async {
    CallModel callModel = CallModel(
      callType: callType,
      isVideoCall: isVideoCall,
      user: user,
      receiver: receiver,
      image: image,
      time: DateTime.now(),
      name: name,
    );

    //create a collection
    CollectionReference callHistoryRef =
        FirebaseFirestore.instance.collection('call_history');

    // Add the CallModel instance to Firestore
    await callHistoryRef.add(callModel.toJson());
  }

  // Method to retrieve the call history from Firestore
  Future<List<CallModel>> getCallHistory() async {
    // Get a reference to the Firestore collection
    CollectionReference callHistoryRef =
        FirebaseFirestore.instance.collection('call_history');

    // Get all documents from the collection
    QuerySnapshot querySnapshot = await callHistoryRef.get();

    // Iterate over the documents and create a CallModel instance for each one
    List<CallModel> callHistory = [];
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      CallModel callModel = CallModel.fromJson(data);
      callHistory.add(callModel);
    });
    log("checking for data get on firebase");

    return callHistory;
  }
}
