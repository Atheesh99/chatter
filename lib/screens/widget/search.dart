import 'package:chatter/const/color.dart';
import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    Key? key,
    required this.icon,
    required this.size,
  }) : super(key: key);
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: textGrey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        icon,
        size: size,
        color: textWhite,
      ),
    );
  }
}
