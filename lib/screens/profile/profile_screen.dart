import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/widget/profile_image.dart';
import 'package:chatter/screens/widget/search.dart';
import 'package:chatter/screens/widget/sigin_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 35, left: 30),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: textWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        user?.photoURL != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL
                                      .toString(),
                                ),
                                radius: 60,
                              )
                            : const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/avatr_person.png'),
                              ),
                        Positioned(
                          bottom: -10,
                          right: -25,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.9),
                            child: const Icon(
                              Icons.add_a_photo,
                              color: textBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight20,
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: const TextStyle(
                        color: textWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            kHeight30,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                SearchIcon(icon: Icons.message_outlined, size: 25),
                SearchIcon(icon: Icons.videocam_outlined, size: 25),
                SearchIcon(icon: Icons.phone_outlined, size: 25),
                SearchIcon(icon: Icons.more_horiz, size: 25),
              ],
            ),
            kHeight20,
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: textWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        kHeight20,
                        profileTextField(
                            'Display Name', 'Amal kvs', TextInputType.name),
                        kHeight10,
                        profileTextField(
                            'Bio', 'Type you Bio', TextInputType.name),
                        kHeight10,
                        profileTextField('Email Address', 'Amalkvs@gmail.com',
                            TextInputType.emailAddress),
                        kHeight10,
                        profileTextField(
                            'Phone', '12356546554', TextInputType.number),
                        kHeight20,
                        const SiginAndLoginBUtton(
                          text: 'Add',
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField profileTextField(
      String title1, String title2, TextInputType? keyboardType) {
    return TextField(
      decoration: InputDecoration(
          border: InputBorder.none, labelText: title1, hintText: title2),
      keyboardType: keyboardType,
    );
  }
}
