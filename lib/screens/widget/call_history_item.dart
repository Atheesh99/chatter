import 'package:chatter/const/size.dart';
import 'package:flutter/material.dart';

enum CallType { missed, incoming, outgoing }

class CallHistory {
  final String image;
  final String name;
  final String time;
  final CallType callType;

  CallHistory(this.image, this.name, this.time, this.callType);
}

class CallHistoryItem extends StatelessWidget {
  CallHistoryItem({Key? key}) : super(key: key);

  final List<CallHistory> callHistoryList = [
    CallHistory("assets/chatapp icon.jpg", "John Doe", "today, 10:00 AM",
        CallType.incoming),
    CallHistory("assets/chatapp icon.jpg", "Jane Smith", " today, 11:00 AM",
        CallType.outgoing),
    CallHistory("assets/chatapp icon.jpg", "Bob Johnson", "yesterday, 12:00 PM",
        CallType.missed),
    CallHistory("assets/chatapp icon.jpg", "Sarah Lee", "yesterday, 1:00 PM",
        CallType.incoming),
  ];
  final bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: callHistoryList.length,
      itemBuilder: (context, index) {
        final callHistoryItem = callHistoryList[index];
        return ListTile(
          tileColor: isSelected ? Colors.green : null,
          selectedTileColor: Colors.grey[100],
          horizontalTitleGap: 5,
          leading: _buildLeading(callHistoryItem),
          title: _buildTest(callHistoryItem),
          subtitle: _buildSubtitile(callHistoryItem),
          trailing: _buildTrailing(),
        );
      },
    );
  }

  Row _buildTrailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /////pending/////
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.phone_in_talk_outlined,
            size: 28,
          ),
        ),
        kWidth20,
        ///// pending/////
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.videocam_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }

  Row _buildSubtitile(CallHistory callHistoryItem) {
    return Row(
      children: [
        Icon(
          getIconData(callHistoryItem.callType),
          color: getIconColor(callHistoryItem.callType),
          size: 15,
        ),
        const SizedBox(
          width: 6.0,
        ),
        Text(
          callHistoryItem.time,
          style: const TextStyle(
            fontSize: 12,
          ),
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  Text _buildTest(CallHistory callHistoryItem) {
    return Text(
      callHistoryItem.name,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      softWrap: false,
      maxLines: 1,
      overflow: TextOverflow.fade,
    );
  }

  CircleAvatar _buildLeading(CallHistory callHistoryItem) {
    return CircleAvatar(
      backgroundImage: AssetImage(callHistoryItem.image),
      radius: 43,
      backgroundColor: Colors.transparent,
    );
  }

  IconData getIconData(CallType callType) {
    switch (callType) {
      case CallType.missed:
        return Icons.call_missed;
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      default:
        return Icons.call;
    }
  }

  Color getIconColor(CallType callType) {
    switch (callType) {
      case CallType.missed:
        return Colors.red;
      case CallType.incoming:
        return Colors.green;
      case CallType.outgoing:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
