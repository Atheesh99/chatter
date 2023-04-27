import 'package:chatter/const/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationBarWidgets extends StatelessWidget {
  const BottomNavigationBarWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) {
          return Container(
            height: size.height * 0.09,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: buttonColor),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: newIndex,
              selectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              iconSize: 27,
              unselectedItemColor: textGrey,
              selectedItemColor: buttonColor,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.commentDots),
                    label: 'Message'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.phoneVolume), label: 'Phone'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.gear), label: 'Setting'),
                // BottomNavigationBarItem(
                //     icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
              ],
            ),
          );
        });
  }
}
