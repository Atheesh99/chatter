import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/profile/profile_screen.dart';
import 'package:chatter/screens/search/search_screen.dart';
import 'package:chatter/screens/widget/avatar_status_bar.dart';
import 'package:chatter/screens/widget/profile_image.dart';
import 'package:chatter/screens/widget/search.dart';
import 'package:chatter/screens/widget/users_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.black, size: 50),
                );
              }
              return Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ProfileScreen(snap: snapshot.data),
                          );
                        },
                        child: const ProfileHome(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        // color: Colors.amber,
                        padding: const EdgeInsets.only(top: 30, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chat with \nyour friends',
                              style: GoogleFonts.frankRuhlLibre(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const SearchScreen());
                                  },
                                  child: const SearchIcon(
                                    icon: Icons.search,
                                    size: 30,
                                  ),
                                ),
                                kWidth10,
                                //////avatar status bar /////
                                const AvatarstatusBar(),
                                //////avatar status bar end  //////////
                              ],
                            ),
                            kHeight10,
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 15),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: textWhite,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          ///// userview persons ///////
                          child: const UserViewPerson(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
