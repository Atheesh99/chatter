import 'package:chatter/const/color.dart';
import 'package:flutter/material.dart';

class SiginAndLoginBUtton extends StatelessWidget {
  const SiginAndLoginBUtton({
    Key? key,
    required this.text,
    this.size,
  }) : super(key: key);

  final String text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: const BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 5,
              offset: Offset(4, 4),
            ),
            BoxShadow(
              color: Color.fromARGB(61, 57, 56, 56),
              blurRadius: 5,
              offset: Offset(-4, -4),
            ),
          ]),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: size,
            letterSpacing: 1,
            color: textWhite,
          ),
        ),
      ),
    );
  }
}
