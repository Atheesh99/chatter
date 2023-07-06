import 'package:chatter/model/user_model.dart';

enum CallType { incoming, outgoing, missed, unknown }

class CallModel {
  final CallType callType;
  final bool isVideoCall;
  final UserModel user;
  final String receiver;
  final DateTime time;
  final String image;
  final String name;

  CallModel({
    required this.callType,
    required this.isVideoCall,
    required this.user,
    required this.receiver,
    required this.time,
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'callType': callType.toString().split('.').last,
      'isVideoCall': isVideoCall,
      'user': user.toJson(),
      'receiver': receiver,
      'time': time.toIso8601String(),
      'image': image,
      'name': name,
    };
  }

  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(
      callType: _parseCallType(json['callType']),
      isVideoCall: json['isVideoCall'],
      user: UserModel.fromSnapshot(json['user']),
      receiver: json['receiver'],
      time: DateTime.parse(json['time']),
      image: json['image'],
      name: json['name'],
    );
  }
  static CallType _parseCallType(String type) {
    switch (type) {
      case 'incoming':
        return CallType.incoming;
      case 'outgoing':
        return CallType.outgoing;
      case 'missed':
        return CallType.missed;
      default:
        return CallType
            .incoming; // Default to incoming if type is not recognized
    }
  }
}
