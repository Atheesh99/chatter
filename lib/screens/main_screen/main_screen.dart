import 'package:chatter/screens/call/call_screen.dart';
import 'package:chatter/screens/home_screen/home_screen.dart';
import 'package:chatter/screens/settings/setting_screen.dart';
import 'package:chatter/screens/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  final _pages = const [
    HomeScreen(),
    CallScreen(),
    SettingScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          }),
      bottomNavigationBar: const BottomNavigationBarWidgets(),
    );
  }
}
