import 'package:flutter/material.dart';

class SettingsListtile extends StatelessWidget {
  const SettingsListtile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
        horizontalTitleGap: 25,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue[50],
          child: Icon(
            icon,
            size: 25,
            color: const Color.fromARGB(255, 72, 71, 71),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
