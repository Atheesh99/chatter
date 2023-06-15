import 'package:chatter/const/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class ProfileHome extends StatelessWidget {
  const ProfileHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: size.width * 0.16,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: textWhite),
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: user?.photoURL != null
              ? Image.network(
                  FirebaseAuth.instance.currentUser!.photoURL.toString(),
                )
              : Image.asset('assets/avatr_person.png'),
        ),
      ),
    );
  }
}
