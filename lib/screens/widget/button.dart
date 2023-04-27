import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.image,
    required this.text,
    this.size,
    this.container,
  }) : super(key: key);
  final Image? image;
  final String text;
  final double? size;
  final Widget? container;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: textGrey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: image,
          ),
          kWidth20,
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size,
              color: textWhite,
            ),
          ),
        ],
      ),
    );
  }
}
