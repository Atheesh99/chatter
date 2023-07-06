import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/widget/setting_listtile.dart';
import 'package:chatter/screens/widget/setting_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 110),
              child: Text(
                'Settings',
                style: GoogleFonts.frankRuhlLibre(
                    fontSize: 28,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: textWhite),
              ),
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
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Settingprofile(),
                    ),
                    kHeight30,
                    const SettingsListtile(
                        icon: Icons.message_rounded,
                        title: 'Chat',
                        subtitle: 'Chat history,theme,wallpaper'),
                    kHeight10,
                    // const SettingsListtile(
                    //     icon: Icons.notifications_none,
                    //     title: 'Group Chat',
                    //     subtitle: 'create group'),
                    kHeight10,
                    const SettingsListtile(
                        icon: Icons.help_outline,
                        title: 'Help',
                        subtitle: 'Help center, contact us,privacy policy'),
                    kHeight10,
                    InkWell(
                      onTap: () {
                        Share.share("com.example.chatter");
                      },
                      child: const SettingsListtile(
                          icon: Icons.people_outline_outlined,
                          title: 'Invite a friend',
                          subtitle: 'welcom toi the chatter'),
                    ),
                    kHeight10,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
