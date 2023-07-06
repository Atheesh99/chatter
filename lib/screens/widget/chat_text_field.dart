import 'package:chatter/const/color.dart';
import 'package:chatter/function/image_picker.dart';
import 'package:chatter/model/user_model.dart';
import 'package:chatter/service/firebase_messeging.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatTextField extends StatefulWidget {
  UserModel snap;
  UserModel? currentUser;
  // DocumentSnapshot receiver;
  ChatTextField({
    Key? key,
    //required this.receiver,
    required this.currentUser,
    required this.snap,
  }) : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
    //final UserProvider userProvider = Provider.of<UserProvider>(context);

    String messages = "";
    final _textController = TextEditingController();

    void sendMessage() async {
      FocusScope.of(context).unfocus();

      //upload message
      await FirebaseApi.uploadMessage(
        currentUserId: widget.currentUser!.uid,
        recieverId: widget.snap.uid,
        message: messages,
        recieverAvatharUrl: widget.snap.photoUrl,
        recieverUsername: widget.snap.username,
        // createdAt: DateTime.now(),
      );

      _textController.clear();
      messages = '';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      color: textWhite,
      child: TextField(
        autocorrect: true,
        enableSuggestions: true,
        textCapitalization: TextCapitalization.sentences,
        controller: _textController,
        // onChanged: (value) {
        //   setState(() {
        //     _textController.text = value;
        //   });
        // },
        decoration: InputDecoration(
          filled: true,
          hintText: 'Type your message...',

          //////pending   /////
          suffixIcon: InkWell(
            onTap: () async {
              messages = _textController.text;
              messages.trim().isEmpty
                  ? showSnackBar(context, 'Type some message to sent!')
                  : sendMessage();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 58, 71, 141)),
              padding: const EdgeInsets.all(14),
              child: const Icon(
                Icons.send_rounded,
                color:
                    //messages.trim().isEmpty ? textBlack :
                    textWhite,
                size: 28,
              ),
            ),
          ),

          fillColor: Colors.blueGrey[50],
          labelStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textBlack.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textBlack.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
