import 'package:flutter/material.dart';

class DividerOrDivider extends StatelessWidget {
  const DividerOrDivider({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
            color: Color.fromARGB(255, 100, 99, 99),
          ),
        ),
        Text(
          "OR",
          style: TextStyle(color: color),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
            color: Color.fromARGB(255, 100, 99, 99),
          ),
        ),
      ],
    );
  }
}
