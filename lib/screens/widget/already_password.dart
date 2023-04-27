import 'package:chatter/screens/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AlreadyAccountLogin extends StatelessWidget {
  const AlreadyAccountLogin(
      {Key? key,
      required this.text,
      required this.title,
      required this.color1,
      required this.color2})
      : super(key: key);
  final String text;
  final String title;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(color: color1, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            Get.off(() => const LoginScreen());
          },
          child: Text(
            title,
            style: TextStyle(
                color: color2,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                fontSize: 15),
          ),
        ),
      ],
    );
  }
}
