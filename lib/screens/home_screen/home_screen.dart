import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';

import 'package:chatter/screens/profile/profile_screen.dart';
import 'package:chatter/screens/widget/avatar_status_bar.dart';
import 'package:chatter/screens/widget/profile_image.dart';
import 'package:chatter/screens/widget/search.dart';
import 'package:chatter/screens/widget/users_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ProfileScreen());
                  },
                  child: const ProfileHome(),
                ),
              ],
            ),
            Column(
              children: [
                Container(
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
                          const SearchIcon(icon: Icons.search, size: 30),
                          kWidth20,
                          //////avatar status bar /////
                          AvatarstatusBar(
                            image: Image.asset('assets/google_icon.png'),
                          ),
                          //////avatar status bar end  //////////
                        ],
                      ),
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
                    child: UserViewPerson(
                        image: Image.asset('assets/google_icon.png'),
                        title: 'Akesh Chichu',
                        subtitle: 'Hello welcom to chatter....!',
                        timeText: '2 min ago'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
