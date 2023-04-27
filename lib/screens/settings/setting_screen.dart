import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/widget/setting_listtile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              padding: const EdgeInsets.only(top: 80),
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: _userNameListtile('Amal Kvs',
                          'I can change everything in this world.....@'),
                    ),
                    kHeight30,
                    const SettingsListtile(
                        icon: Icons.person,
                        title: 'Profile',
                        subtitle: 'Add avatar,name,bio'),
                    kHeight10,
                    const SettingsListtile(
                        icon: Icons.message_rounded,
                        title: 'Chat',
                        subtitle: 'Chat history,theme,wallpaper'),
                    kHeight10,
                    const SettingsListtile(
                        icon: Icons.notifications_none,
                        title: 'Group Chat',
                        subtitle: 'create group'),
                    kHeight10,
                    const SettingsListtile(
                        icon: Icons.help_outline,
                        title: 'Help',
                        subtitle: 'Help center, contact us,privacy policy'),
                    kHeight10,
                    const SettingsListtile(
                        icon: Icons.people_outline_outlined,
                        title: 'Invite a friend',
                        subtitle: ''),
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

  ListTile _userNameListtile(String title, String subtitle) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/chatapp icon.jpg'),
        radius: 50,
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12.4, letterSpacing: 0.5),
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
