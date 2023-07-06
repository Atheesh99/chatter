import 'package:chatter/const/size.dart';
import 'package:chatter/model/call_model.dart';
import 'package:chatter/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallHistoryItem extends StatefulWidget {
  const CallHistoryItem({
    Key? key,
  }) : super(key: key);

  @override
  State<CallHistoryItem> createState() => _CallHistoryItemState();
}

class _CallHistoryItemState extends State<CallHistoryItem> {
  final bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("call_history").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.black, size: 50),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => kHeight10,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final bool isVideoCall =
                  snapshot.data!.docs[index]['isVideoCall'];
              return ListTile(
                minLeadingWidth: 70,
                tileColor: isSelected ? Colors.green : null,
                selectedTileColor: Colors.grey[100],
                horizontalTitleGap: 5,
                leading: _buildLeading(snapshot.data!.docs[index]['image']),
                title: _buildTest(snapshot.data!.docs[index]['name']),
                subtitle: _buildSubtitile(
                    snapshot.data!.docs[index]['time'].toString()),
                trailing: _buildTrailing(isVideoCall),
              );
            },
          );
        });
  }

  Row _buildTrailing(bool isVideoCall) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isVideoCall
            ? const Icon(
                Icons.phone_in_talk_outlined,
                size: 28,
              )
            : const Icon(
                Icons.videocam_outlined,
                size: 30,
              ),
      ],
    );
  }

  Row _buildSubtitile(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDate = DateFormat('d MMMM, h:mm a').format(dateTime);
    return Row(
      children: [
        Icon(
          getIconData(CallType.incoming),
          color: getIconColor(CallType.incoming),
          size: 15,
        ),
        const SizedBox(
          width: 6.0,
        ),
        Text(
          formattedDate,
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

  Text _buildTest(String name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      softWrap: false,
      maxLines: 1,
      overflow: TextOverflow.fade,
    );
  }

  Container _buildLeading(String url) {
    return Container(
      width: 65,
      height: 65,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            url,
          ),
        ),
      ),
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
